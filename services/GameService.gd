extends Node

export var ball_size: Vector2 = Vector2(4, 4)
export var ball_speed: int = 5
export var paddle_size: Vector2 = Vector2(6, 20)
export var paddle_speed: int = 800
export var screen_size = Vector2(1024, 600)
# 'start' for new/reset games or 'play' for in-progress games
export var state := 'start'
