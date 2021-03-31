extends Node2D

export var paddle_speed = 800

func _process(delta):
	if (Input.is_action_pressed("ui_cancel")):
		get_tree().quit()

	if (Input.is_action_pressed("ui_down_01")):
		$LeftPaddle.move_and_collide(Vector2(0, paddle_speed * delta))
	elif (Input.is_action_pressed("ui_up_01")):
		$LeftPaddle.move_and_collide(Vector2(0, -paddle_speed * delta))

	if (Input.is_action_pressed("ui_down_02")):
		$RightPaddle.move_and_collide(Vector2(0, paddle_speed * delta))
	elif (Input.is_action_pressed("ui_up_02")):
		$RightPaddle.move_and_collide(Vector2(0, -paddle_speed * delta))
