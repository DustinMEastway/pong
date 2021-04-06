extends Node2D

var _ball: KinematicBody2D = load("res://Ball.tscn").instance()
var _ball_velocity = Vector2(0, 0)
var _paddle_offset = Vector2(10, 30)
var _paddle_resource: Resource = load("res://Paddle.tscn")
var _paddle1: Paddle = _paddle_resource.instance()
var _paddle2: Paddle = _paddle_resource.instance()

func _ready() -> void:
	add_child(_ball)

	_paddle1.key_down = "ui_down_01"
	_paddle1.key_up = "ui_up_01"
	_paddle1.start_position = _paddle_offset
	add_child(_paddle1)

	_paddle2.key_down = "ui_down_02"
	_paddle2.key_up = "ui_up_02"
	_paddle2.start_position = (
		GameService.screen_size - _paddle_offset - GameService.paddle_size
	)
	add_child(_paddle2)

	_reset_game()

func _physics_process(delta) -> void:
	if (Input.is_action_pressed("ui_cancel")):
		get_tree().quit()
	elif (Input.is_action_just_released("ui_accept")):
		if (GameService.state == "start"):
			GameService.state = "play"
		else:
			_reset_game()

	if (GameService.state != "play"):
		return

	_paddle1.move(delta)
	_paddle2.move(delta)
	_ball.move_and_collide(_ball_velocity)

func _reset_game() -> void:
	var ball_speed := GameService.ball_speed
	var ball_size := GameService.ball_size
	var ball_x := ball_speed if (RandomService.rand_bool()) else -ball_speed
	var ball_y := RandomService.randi_range(-ball_speed, ball_speed)
	_ball.scale = ball_size
	_ball.position = GameService.screen_size / 2 - ball_size / 2
	_ball_velocity = Vector2(ball_x, ball_y)

	GameService.state = 'start'
	_paddle1.reset()
	_paddle2.reset()
