extends Node2D

var _ball: Ball = load("res://Ball.tscn").instance()
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

func _reset_game() -> void:
	GameService.state = 'start'
	_ball.reset()
	_paddle1.reset()
	_paddle2.reset()
