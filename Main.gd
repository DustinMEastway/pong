extends Node2D

export var paddle_speed = 800

func _process(delta):
	if (Input.is_action_pressed("ui_cancel")):
		get_tree().quit()

	if (Input.is_action_pressed("ui_down_01")):
		$Paddle1.move_and_collide(Vector2(0, paddle_speed * delta))
	elif (Input.is_action_pressed("ui_up_01")):
		$Paddle1.move_and_collide(Vector2(0, -paddle_speed * delta))

	if (Input.is_action_pressed("ui_down_02")):
		$Paddle2.move_and_collide(Vector2(0, paddle_speed * delta))
	elif (Input.is_action_pressed("ui_up_02")):
		$Paddle2.move_and_collide(Vector2(0, -paddle_speed * delta))
