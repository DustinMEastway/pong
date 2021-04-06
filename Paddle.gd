extends KinematicBody2D
class_name Paddle

export var key_down: String
export var key_up: String
export var max_y: float = 0
export var min_y: float = 0
export var speed: float = 0
export var start_position := Vector2(0, 0)
export var start_size := Vector2(1, 1)

func move(delta) -> void:
	var paddle_position = position
	if (Input.is_action_pressed(key_down)):
		paddle_position.y += delta * speed
	elif (Input.is_action_pressed(key_up)):
		paddle_position.y -= delta * speed

	paddle_position.y = min(max_y - scale.y, max(min_y, paddle_position.y))
	position = paddle_position

func reset() -> void:
	position = start_position
	scale = start_size
