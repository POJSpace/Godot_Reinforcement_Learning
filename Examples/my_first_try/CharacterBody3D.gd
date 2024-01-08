extends CharacterBody3D


const SPEED = 5.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var pos
var new_pos
var start_pos := Vector3(6,1,6)

@onready var ai_controller = $AIController3D
@onready var target = $"../target"

func _ready():
	pos = (target.global_position - global_position).length()
	random_pos()

func _physics_process(delta):
	if ai_controller.needs_reset:
		ai_controller.reward -= 10
		ai_controller.reset()
		position = start_pos
	new_pos = (target.global_position - global_position).length()
	if new_pos < pos:
		ai_controller.reward += 1.0
	else:
		ai_controller.reward -= 2.0
	pos = (target.global_position - global_position).length()
	# Add the gravity.
	print(ai_controller.reward)
	if not is_on_floor():
		velocity.y -= gravity * delta
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	velocity.x = ai_controller.move.x * SPEED
	velocity.z = ai_controller.move.y * SPEED
	
	move_and_slide()

func _on_target_body_entered(_body):
	random_pos()
	ai_controller.reward += 10.0


func _on_walls_body_entered(_body):
	position = start_pos
	ai_controller.reward -= 10.0
	ai_controller.reset()
	random_pos()
	
func random_pos():
	target.position = Vector3(randi_range(2,9), 0, randi_range(2,9))



