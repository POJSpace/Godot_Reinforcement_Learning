extends StaticBody2D

signal player_entere_gate


func _on_area_2d_body_entered(body):
	player_entere_gate.emit(body)
