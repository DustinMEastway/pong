extends Node2D

export var ball_size: Vector2 = Vector2(4, 4)
export var ball_speed: int = 5
export var paddle_size: Vector2 = Vector2(6, 20)
export var paddle_speed: int = 800

var _ball: KinematicBody2D = load("res://Ball.tscn").instance()
var _ball_velocity = Vector2(0, 0)
# 'start' or 'play'
var _game_state: String
var _paddle_offset = Vector2(10, 30)
var _paddle_resource: Resource = load("res://Paddle.tscn")
var _paddle1: Paddle = _paddle_resource.instance()
var _paddle2: Paddle = _paddle_resource.instance()
var _screen_size = Vector2(1024, 600)

func _ready() -> void:
	add_child(_ball)

	_paddle1.key_down = "ui_down_01"
	_paddle1.key_up = "ui_up_01"
	_paddle1.max_y = _screen_size.y
	_paddle1.speed = paddle_speed
	_paddle1.start_position = _paddle_offset
	_paddle1.start_size = paddle_size
	add_child(_paddle1)

	_paddle2.key_down = "ui_down_02"
	_paddle2.key_up = "ui_up_02"
	_paddle2.max_y = _screen_size.y
	_paddle2.speed = paddle_speed
	_paddle2.start_position = _screen_size - _paddle_offset - paddle_size
	_paddle2.start_size = paddle_size
	add_child(_paddle2)

	_reset_game()

func _physics_process(delta) -> void:
	if (Input.is_action_pressed("ui_cancel")):
		get_tree().quit()
	elif (Input.is_action_just_released("ui_accept")):
		if (_game_state == "start"):
			_game_state = "play"
		else:
			_reset_game()

	if (_game_state != "play"):
		return

	_paddle1.move(delta)
	_paddle2.move(delta)
	_ball.move_and_collide(_ball_velocity)

func _reset_game() -> void:
	var ball_x := ball_speed if (RandomService.rand_bool()) else -ball_speed
	var ball_y := RandomService.randi_range(-ball_speed, ball_speed)
	_ball.scale = ball_size
	_ball.position = _screen_size / 2 - ball_size / 2
	_ball_velocity = Vector2(ball_x, ball_y)

	_game_state = 'start'
	_paddle1.reset()
	_paddle2.reset()
