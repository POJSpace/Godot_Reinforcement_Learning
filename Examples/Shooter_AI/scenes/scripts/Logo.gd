extends Sprite2D

var pos: Vector2 = Vector2(200, 200)
const speed: int = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("left"):
		position += pos * -delta
	elif Input.is_action_pressed("right"):
		position += pos * delta
	
	rotation_degrees = rotation_degrees + 100 * delta
	
	if position.y > 648:
		pos.y *= -1
	elif position.y < 0:
		pos.y *= -1
	#if position.x > 1152:
		#pos.x -= 10
	#if position.x < 0:
		#pos.x -= 10
