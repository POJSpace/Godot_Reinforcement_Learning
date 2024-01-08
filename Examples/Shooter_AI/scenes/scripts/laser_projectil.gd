extends Area2D

@export var speed: int = 1000 
var dir : Vector2
@export var damage: int = 10
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	#dir = global_position.direction_to(get_global_mouse_position())
	rotation =  dir.angle()

func _process(delta):
	global_position += dir * speed * delta
	


func _on_body_entered(body):
	if body.has_method("hit"):
		body.hit(damage)
		player = $"../../Player"
		player.hit = 1 
		
	queue_free()


func _on_timer_timeout():
	queue_free()
