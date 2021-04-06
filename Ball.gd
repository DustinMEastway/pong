extends KinematicBody2D
class_name Ball

var _ball_velocity := Vector2(0, 0)

func reset() -> void:
	var ball_size := GameService.ball_size
	scale = ball_size
	position = GameService.screen_size / 2 - ball_size / 2

	var ball_speed := GameService.ball_speed
	var ball_x := ball_speed if (RandomService.rand_bool()) else -ball_speed
	var ball_y := RandomService.randi_range(-ball_speed, ball_speed)
	_ball_velocity = Vector2(ball_x, ball_y)

func _physics_process(delta) -> void:
	if (GameService.state != "play"):
		return

	move_and_collide(_ball_velocity)
