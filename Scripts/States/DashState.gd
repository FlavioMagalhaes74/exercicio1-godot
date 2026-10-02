class_name DashState extends BaseState

var dash_multiplier: float = 20.0
var dash_duration: float = 0.25
var dash_timer: float = 0.0
var original_speed: float = 0.0

func _init(p_knight) -> void:
	knight = p_knight

func enter() -> void:
	print("EnterDash")
	# Store the current speed and increase it immediately
	original_speed = knight.speed
	knight.speed *= dash_multiplier
	dash_timer = dash_duration

func exit() -> void:
	# Reset speed back to normal when dash ends
	knight.speed = original_speed

func tick() -> void:
	dash_timer -= knight.get_physics_process_delta_time()
	knight.velocity = knight.direction_to_cursor.normalized() * knight.speed
	knight.move_and_slide()

func branch() -> BaseState:
	# Return to ChaseState once the dash duration is up
	if dash_timer <= 0.0:
		return ChaseState.new(knight)
	
	# Stay in DashState
	return null
