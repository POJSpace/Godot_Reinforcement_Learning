extends CharacterBody2D


const SPEED = 20000.0
var direction : Vector2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	direction = Input.get_vector("left", "right", "up", "down") # get direction from human if presed left the direction = Vector(-1, 0) 
	velocity = direction * SPEED * delta # calculate the velocity and add movement to player
	
	# rotation for cat
	if direction:
		direction *= -1
		rotation = direction.angle() - 1.5707963268 # in radians
	
	move_and_slide() # function to use the velocity and rotation

func restart_pos():
	position = Vector2(50, 230)

func _on_outside_body_entered(body):
	restart_pos()
	print("Auto vyjelo z trati: ", body)
	# ADD REWARD HERE

func _on_gate_1_body_entered(body):
	# ADD REWARD HERE
	pass # Replace with function body.


func _on_gate_2_body_entered(body):
	pass # Replace with function body.


func _on_gate_3_body_entered(body):
	pass # Replace with function body.


func _on_gate_4_body_entered(body):
	pass # Replace with function body.


func _on_gate_5_body_entered(body):
	pass # Replace with function body.


func _on_gate_6_body_entered(body):
	pass # Replace with function body.


func _on_gate_7_body_entered(body):
	pass # Replace with function body.


func _on_gate_8_body_entered(body):
	pass # Replace with function body.


func _on_gate_9_body_entered(body):
	pass # Replace with function body.
