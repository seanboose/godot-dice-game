extends Node3D

@onready var die: RigidBody3D = $Die1

# TODO: look more into unique names. this didnt like a non-unique name
@onready var result_label: Label = %ResultLabel

@export var throw_force: float = 10.0

func _ready() -> void:
	die.roll_finished.connect(_on_die_roll_finished)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("roll_die"):
		die.throw(throw_force);

func _on_die_roll_finished(value: int):
	result_label.show_result(value)
