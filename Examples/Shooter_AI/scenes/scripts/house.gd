extends Area2D


signal player_entered_house
signal player_exited_house

func _on_body_entered(body):
	if body.name == "Player":
		player_entered_house.emit(body)


func _on_body_exited(body):
	if body.name == "Player":
		player_exited_house.emit(body)
