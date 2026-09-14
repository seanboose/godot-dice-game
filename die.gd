extends RigidBody3D

signal roll_finished(value: int)
var torque_min: float = -1.0
var torque_max: float = 1.0

func _ready() -> void:
	sleeping_state_changed.connect(_on_sleeping_state_changed)

func throw(force: float) -> void:
	if not sleeping:
		return
	var impulse: Vector3 = Vector3(0.0, force, 0.0)
	apply_central_impulse(impulse)
	apply_torque_impulse(_make_torque())
	
func _make_torque() -> Vector3:
	return Vector3(_make_torque_value(), _make_torque_value(), _make_torque_value())

func _make_torque_value() -> float:
	return randfn(torque_min, torque_max)
	

func _read_face() -> void:
	var value: int = 6
	roll_finished.emit(value)

func _on_sleeping_state_changed() -> void:
	if (sleeping):
		_read_face()
