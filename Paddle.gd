extends KinematicBody2D
class_name Paddle

export var key_down: String
export var key_up: String
export var start_position := Vector2(0, 0)

func move(delta) -> void:
	var paddle_position = position
	if (Input.is_action_pressed(key_down)):
		paddle_position.y += delta * GameService.paddle_speed
	elif (Input.is_action_pressed(key_up)):
		paddle_position.y -= delta * GameService.paddle_speed

	paddle_position.y = min(
		GameService.screen_size.y - scale.y,
		max(0, paddle_position.y)
	)
	position = paddle_position

func reset() -> void:
	position = start_position
	scale = GameService.paddle_size
