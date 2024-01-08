extends Node2D
class_name AIController2D

@export var reset_after := 1000
@onready var player = $".."
@onready var raycast_sensor = $"../RaycastSensor2D"

var heuristic := "human"
var done := false
var reward := 0.0
var n_steps := 0
var needs_reset := false

var obs := []
var move : Vector2
var shoot : bool
var shoot_2

func _ready():
	add_to_group("AGENT")
	
#-- Methods that need implementing using the "extend script" option in Godot --#
func get_obs() -> Dictionary:
	var player_reference: Vector2 = to_local(player.global_position)
	var player_vel = to_local(player.velocity)
	var raycast_obs = raycast_sensor.get_observation()
	obs = [
		player_reference.x,
		player_reference.y,
		player.rotation,
		player_vel.x/10.0,
		player_vel.y/10.0
	]
	obs.append_array(raycast_obs)
	return {"obs":obs}

func get_reward() -> float:	
	return reward
	
func get_action_space() -> Dictionary:
	return {
		"move" : {
			"size": 2,
			"action_type": "continuous"
		},
		"rotate" : {
			"size": 1,
			"action_type": "continuous"
			},
		"shoot" : {
			"size": 1,
			"action_type": "discrete"
			}
		}
	
func set_action(action) -> void:	
	rotation = clamp(action["rotate"][0], -1.0, 1.0)
	move.x = action["move"][0]
	move.y = action["move"][1]
	shoot = bool(action["shoot"])
	
func _physics_process(delta):
	n_steps += 1
	if n_steps > reset_after:
		needs_reset = true
		
func get_obs_space():
	# may need overriding if the obs space is complex
	var obs = get_obs()
	return {
		"obs": {
			"size": [len(obs["obs"])],
			"space": "box"
		},
	}

func reset():
	n_steps = 0
	needs_reset = false

func reset_if_done():
	if done:
		reset()
		
func set_heuristic(h):
	# sets the heuristic from "human" or "model" nothing to change here
	heuristic = h

func get_done():
	return done
	
func set_done_false():
	done = false

func zero_reward():
	reward = 0.0
	

