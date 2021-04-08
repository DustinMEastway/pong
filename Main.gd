extends Node2D

export var display_fps := false

var _ball: Ball = load("res://Ball.tscn").instance()
var _fps_label: Label
var _paddle_offset = Vector2(10, 30)
var _paddle_resource: Resource = load("res://Paddle.tscn")
var _paddle1: Paddle = _paddle_resource.instance()
var _paddle2: Paddle = _paddle_resource.instance()
# player currently serving the ball
var _serving_player: int = 0
var _score1: int = 0
var _score2: int = 0

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

	if (display_fps):
		_fps_label = Label.new()
		add_child(_fps_label)

	_reset_game()

func _physics_process(_delta) -> void:
	if (Input.is_action_just_pressed("ui_cancel")):
		if (GameService.state == "serve"):
			get_tree().quit()
		else:
			_reset_game()
	elif (Input.is_action_just_released("ui_accept")):
		if (GameService.state == "serve"):
			GameService.state = "play"
			_update_labels()

func _process(_delta):
	if (display_fps):
		_fps_label.text = String(Engine.get_frames_per_second()) + ' FPS'

	if (_ball.position.x < 0):
		_update_score(1, _score1, _score2 + 1)
	elif (_ball.position.x > GameService.screen_size.x):
		_update_score(2, _score1 + 1, _score2)

func _reset_game() -> void:
	_update_score(1, 0, 0)
	_paddle1.reset()
	_paddle2.reset()

func _update_labels(main: String = "", help: String = ""):
	$MainMessage.text = main
	$HelpText.text = help

func _update_score(serving_player: int, score1: int, score2: int):
	GameService.state = 'serve'
	_score1 = score1
	_score2 = score2
	_serving_player = serving_player
	_ball.reset(serving_player)
	$Score1.text = String(_score1)
	$Score2.text = String(_score2)
	_update_labels(
		"Player " + String(serving_player) + "'s Serve",
		"Press ENTER to serve!"
	)
