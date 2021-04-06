extends Node2D

export var ball_size: Vector2 = Vector2(4, 4)
export var ball_speed: int = 5
export var paddle_size: Vector2 = Vector2(6, 20)
export var paddle_speed: int = 800

var _ball: KinematicBody2D = null
var _ball_resource: Resource = load("res://Ball.tscn")
var _ball_velocity = Vector2(0, 0)
var _paddle_offset = Vector2(10, 30)
var _paddle_resource: Resource = load("res://Paddle.tscn")
var _paddle1: KinematicBody2D = null
var _paddle2: KinematicBody2D = null
var _screen_size = Vector2(1024, 600)

func _ready():
	_create_ball()
	_create_paddles()

func _physics_process(delta):
	if (Input.is_action_pressed("ui_cancel")):
		get_tree().quit()

	var paddle_delta = paddle_speed * delta
	_move_paddle(_paddle1, "ui_down_01", "ui_up_01", paddle_delta)
	_move_paddle(_paddle2, "ui_down_02", "ui_up_02", paddle_delta)
	
	_ball.move_and_collide(_ball_velocity)

func _create_ball():
	_ball = _ball_resource.instance()
	_ball.scale = ball_size
	_ball.position = _screen_size / 2 - ball_size / 2
	add_child(_ball)

	var ball_x = ball_speed if (RandomService.rand_bool()) else -ball_speed
	var ball_y: float = RandomService.randi_range(-ball_speed, ball_speed)
	_ball_velocity = Vector2(ball_x, ball_y)

func _create_paddles():
	_paddle1 = _paddle_resource.instance()
	_paddle1.scale = paddle_size
	_paddle1.position = _paddle_offset
	add_child(_paddle1)
	_paddle2 = _paddle_resource.instance()
	_paddle2.scale = paddle_size
	_paddle2.position = _screen_size - _paddle_offset - paddle_size
	add_child(_paddle2)

func _move_paddle(paddle: KinematicBody2D, down_key: String, up_key: String, distance: float):
	var paddle_position = paddle.position
	if (Input.is_action_pressed(down_key)):
		paddle_position.y += distance
	elif (Input.is_action_pressed(up_key)):
		paddle_position.y -= distance
	paddle.position = paddle_position
