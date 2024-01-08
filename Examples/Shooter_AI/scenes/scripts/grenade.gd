extends RigidBody2D

var dir
@export var speed: int = 1300
@onready var player =  $/root/Level/%Player as CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	dir = global_position.direction_to(get_global_mouse_position())
	rotation =  dir.angle()
	linear_velocity = dir * speed
	$Timer.start()

func _process(_delta):
	pass


func _on_timer_timeout():
	$AnimationPlayer.pause()
	$AnimationPlayer.play("explosion", -1, 2)
	
