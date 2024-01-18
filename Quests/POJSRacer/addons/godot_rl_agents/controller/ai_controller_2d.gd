extends Node2D
class_name AIController2D

@export var reset_after := 1000

var heuristic := "human"
var done := false
var reward := 0.0
var n_steps := 0
var needs_reset := false

func _ready():
	add_to_group("AGENT")
	
func get_obs() -> Dictionary:
	# ZROBIT
	return {"obs":[]}

func get_reward() -> float:	
	return reward
	
func get_action_space() -> Dictionary:
	return {
		"move" : {
			"size": 2,
			"action_type": "continuous"
		}
		}
	
func set_action(action) -> void:	
	# ZROBIT
	pass




	
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

		
func set_heuristic(h):
	heuristic = h

func get_done():
	return done
	
func zero_reward():
	reward = 0.0
	
