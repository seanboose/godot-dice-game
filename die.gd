extends RigidBody3D

signal roll_finished(value: int)
var torque_min: float = -1.0
var torque_max: float = 1.0

var last_throw_force: float = 0

var sides: Dictionary = {
	1: Vector3(0, -1, 0),
	2: Vector3(0, 0, 1),
	3: Vector3(1, 0, 0),
	4: Vector3(-1, 0, 0),
	5: Vector3(0, 0, -1),
	6: Vector3(0, 1, 0)
}

func _ready() -> void:
	sleeping_state_changed.connect(_on_sleeping_state_changed)

func throw(force: float) -> void:
	if not sleeping:
		return
	last_throw_force = force
	var impulse: Vector3 = Vector3(0.0, force, 0.0)
	apply_central_impulse(impulse)
	apply_torque_impulse(_make_torque())
	
func _make_torque() -> Vector3:
	return Vector3(_make_torque_value(), _make_torque_value(), _make_torque_value())

func _make_torque_value() -> float:
	return randfn(torque_min, torque_max)
	
func _read_face() -> void:
	var up_in_local: Vector3 = global_transform.basis.inverse() * Vector3.UP
	
	var value: int = 0
	var value_dot: float = 0;
	
	for side in sides:
		var dot = up_in_local.dot(sides[side])
		if dot > value_dot:
			value_dot = dot
			value = side
			
	if value_dot < 0.9:
		# TODO need to actually check that this runs correctly still
		throw(last_throw_force)
		return
	
	roll_finished.emit(value)

func _on_sleeping_state_changed() -> void:
	if (sleeping):
		_read_face()
