extends Node

export var ball_size: Vector2 = Vector2(4, 4)
export var ball_speed: float = 5
# Determines how much speed to add each time the ball bounces
export var ball_speed_scale: float = 1.03
export var paddle_size: Vector2 = Vector2(6, 50)
export var paddle_speed: int = 800
export var screen_size = Vector2(1024, 600)
# 'start' for new/reset games or 'play' for in-progress games
export var state := 'start'
