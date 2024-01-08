extends CharacterBody2D

var direction: Vector2
@export var health: float = 50
var drone_scene
var start_pos :Vector2

func _ready():
	start_pos = position

func _process(delta):
	direction = global_position.direction_to(get_node("../../Player").global_position)
	rotation =  direction.angle()
	velocity = direction * 15000 * delta
	
	move_and_slide()
	
	#position = position.move_toward(%Player.position, delta * 100)
	
func hit(damage):
	health -= damage
	if health <= 0:
		queue_free()
	
	
