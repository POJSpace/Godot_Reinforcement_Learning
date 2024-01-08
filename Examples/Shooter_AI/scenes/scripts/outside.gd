extends Level_parent

var tween


func _on_gate_player_entere_gate(body):
	tween = create_tween()
	tween.tween_property($Player, "max_speed", 0, 0.5)

func _on_house_player_entered_house(_body):	
	tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.4,0.4), 2).from(0.5)
	tween.tween_property($Player, "modulate:a", 0, 2).set_trans(Tween.TRANS_SPRING)

func _on_house_player_exited_house(_body):
	tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.5,0.5), 2)
	tween.tween_property($Player, "modulate:a", 1, 2)
