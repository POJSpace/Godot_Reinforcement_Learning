extends Node2D
class_name Level_parent

var laser_scene: PackedScene = preload("res://scenes/projectils/laser_projectil.tscn")
var granade_scene: PackedScene = preload("res://scenes/projectils/grenade.tscn")
var drone_scene := preload("res://scenes/enemies/drone.tscn")

var laser
var laser_node

var granade
var granade_node
var dir: Vector2 = Vector2.ZERO

var drone

@onready var player = %Player


# Called when the node enters the scene tree for the first time.
func _ready():
	granade_node = Node2D.new()
	granade_node.name = "granade_node"
	add_child(granade_node)
	move_child(granade_node, $drone_node.get_index())
	
	# laser
	laser_node = Node2D.new()
	laser_node.name = "laser_node"
	add_child(laser_node)  
	# granade

func _on_player_laser(laser_pos, laser_dir):
	laser = laser_scene.instantiate()
	laser.position = laser_pos
	laser.dir = laser_dir
	$laser_node.add_child(laser)
	
	

func _on_player_granade(granade_pos):
	granade = granade_scene.instantiate() as RigidBody2D
	granade.position = granade_pos
	$granade_node.add_child(granade)
	
func _physics_process(_delta):
	if player.ai_controller.needs_reset:
		player.ai_controller.reset()
		reset()
		return

func reset():
	var enemies = get_all_children($drone_node)
	for en in enemies:
		if en.is_in_group("enemy"):
			en.position = en.start_pos

func get_all_children(in_node,arr:=[]):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child,arr)
	return arr


func _on_drone_spawn_timer_timeout():
	spawn_drone()
	
	
func get_random_pos():
	var pos = Vector2(randf_range(100, 3000), randf_range(100,3000))
	
	if pos >= player.position + Vector2(-500, -500) and pos <= player.position + Vector2(500,500):
		#print("bad position drone: ", pos)
		pos = get_random_pos()
		
	#print(pos)
	return pos


func spawn_drone():
	drone = drone_scene.instantiate() as CharacterBody2D
	var spawn_pos = get_random_pos()
	drone.position = spawn_pos
	$drone_node.add_child.call_deferred(drone)
	#print("drone spawnd")


