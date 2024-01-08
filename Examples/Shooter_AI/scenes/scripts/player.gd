extends CharacterBody2D

signal laser 
signal granade

var direction
var event
var mouse_vect

var rotation_speed : int = 5

@onready var ai_controller = $AIController2D

var can_laser: bool = true
var can_granade: bool = true
var laser_markers 
var selected_laser
var laser_dir
var hit := 0.0
var start_pos :Vector2 = Vector2(2000, 2000)

@export var max_speed: int = 30500
@onready var level = $".."


func  _ready():
	start_pos = global_position
	

func _process(delta):
	
	if ai_controller.needs_reset:
		#print("out_of time")
		ai_controller.needs_reset = false
		ai_controller.reward -= 10.0
		ai_controller.reset()
		print(start_pos, global_position)
		global_position = start_pos
		print(start_pos, global_position)
		level.reset()
		return
	
	if hit == 1.0:
		ai_controller.reward += 5.0
		
		hit = 0.0
	
	
	if ai_controller.heuristic == "human":
		# player movement
		direction = Input.get_vector("left", "right", "up", "down")
		velocity = direction * max_speed * delta
		look_at(get_global_mouse_position())
	else:
		velocity.x = ai_controller.move.x * max_speed * delta
		velocity.y = ai_controller.move.y * max_speed * delta
		rotate(ai_controller.rotation*delta*rotation_speed)

	move_and_slide() 
	
	
	#if Input.is_action_pressed("primary_action") and can_laser == true:
	if ai_controller.shoot and can_laser == true:
		
		laser_markers = $Laser_start_position.get_children()
		selected_laser = $Laser_start_position/Marker2D3
		laser_dir = global_position.direction_to($Laser_start_position/Marker2D3.global_position)
		
		can_laser = false
		$Laser_timer.start()
		laser.emit(position, laser_dir)
		
		
		# Particles
		$CPUParticles2D.emitting = true
		
		
	elif Input.is_action_pressed("secondary_action") and can_granade == true:
		laser_markers = $Laser_start_position.get_children()
		selected_laser = laser_markers[0]
		
		can_granade = false
		$Granade_timer.start()
		granade.emit(selected_laser.global_position)
		


func _on_granade_timer_timeout():
	can_granade = true


func _on_laser_timer_timeout():
	can_laser = true

func reset():
	pass


func _on_area_2d_body_entered(body):
		ai_controller.reward -= 20.0
		#print(body)




func _on_drone_node_child_exiting_tree(node):
	
	if node.is_in_group("enemy"):
		ai_controller.reward += 50
		ai_controller.n_steps -= 50
		#print("enemy died")
		level.spawn_drone()
