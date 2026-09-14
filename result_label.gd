extends Label

func show_result(value: int) -> void:
	text = "rolled a " + str(value) + "!"
	visible = true
	await get_tree().create_timer(1.0).timeout
	visible = false
