extends Node3D

var die: RigidBody3D

@export var throw_force: float = 10.0

func _ready() -> void:
	die = %Die1
	die.roll_finished.connect(_on_die_roll_finished)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("roll_die"):
		die.throw(throw_force);

func _on_die_roll_finished(value: int):
	print("rolled a " + str(value))
