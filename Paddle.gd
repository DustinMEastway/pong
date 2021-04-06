extends KinematicBody2D
class_name Paddle

# Input action used to move the paddle down
export var key_down: String
# Input action used to move the paddle up
export var key_up: String
# Position to move the paddle to on reset
export var start_position := Vector2(0, 0)

func reset() -> void:
	position = start_position
	scale = GameService.paddle_size

func _physics_process(delta) -> void:
	if (GameService.state != "play"):
		return

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
