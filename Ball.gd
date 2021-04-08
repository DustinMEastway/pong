extends KinematicBody2D
class_name Ball

var _ball_velocity := Vector2(0, 0)

func reset(serving_player: int) -> void:
	var ball_size := GameService.ball_size
	scale = ball_size
	position = GameService.screen_size / 2 - ball_size / 2

	var ball_speed := GameService.ball_speed
	var ball_x: float = ball_speed if (serving_player == 1) else -ball_speed
	var ball_y := RandomService.randf_range(-ball_speed, ball_speed)
	_ball_velocity = Vector2(ball_x, ball_y)

func _physics_process(_delta) -> void:
	if (GameService.state != "play"):
		return

	var collision = move_and_collide(_ball_velocity)
	if (collision != null):
		_ball_velocity = _ball_velocity.bounce(collision.normal)

		if (collision.collider is Paddle):
			# randomize the y a bit to change the angle of the game
			var ball_y = _ball_velocity.y
			_ball_velocity.y += RandomService.randf_range(
				-ball_y / 4,
				ball_y / 2
			)
			_ball_velocity *= GameService.ball_speed_scale
