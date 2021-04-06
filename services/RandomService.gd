extends Node

func rand_bool() -> bool:
	return randi_range(0, 2) > 0

func randi_range(from: int, to: int) -> int:
	if (from > to):
		var temp = from
		from = to
		to = temp

	return from + randi() % (to - from)

func _ready():
	randomize()
