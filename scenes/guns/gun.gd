tool
extends Node2D

var size = 4

var active = true

const CELL_SIZE = 24

var _current_orientation

export(Vector2) var block_position = Vector2() setget _set_block_position, _get_block_position
export(int, 3) var block_rotation = 0 setget _set_block_rotation, _get_block_rotation
#export(String) var gun_name

#func _ready():
#	_set_block_rotation(block_rotation)
#	_set_block_position(block_position)

#func shoot():

#func land():

func move_left(value):
	var pos = _get_block_position()
	_set_block_position(Vector2(pos.x - value, pos.y))

func move_right(value):
	var pos = _get_block_position()
	_set_block_position(Vector2(pos.x + value, pos.y))

func move_down(value):
	var pos = _get_block_position()
	_set_block_position(Vector2(pos.x, pos.y + value))

func rotate_clockwise(value):
	_set_block_rotation((_get_block_rotation() + value) % 4)

func rotate_counterclockwise(value):
	_set_block_rotation((_get_block_rotation() - value) % 4)

func _set_block_rotation(value):
	block_rotation = value
	if get_child_count() > 0:
		var real_rotation = wrapi(block_rotation, 0, get_child_count())

		for c in get_children():
			c.visible = c.get_index() == real_rotation
			if c.visible:
				_current_orientation = c

func _get_block_rotation():
	return block_rotation

func _set_block_position(value):
	block_position = value
#	if get_child_count() > 0:
	position = value * CELL_SIZE

func _get_block_position():
#	var result = Vector2()
#
#	if get_child_count() > 0:
#		if _current_orientation:
#			result = position / CELL_SIZE
#		else:
#			result = position / CELL_SIZE

	return block_position

#gets a rectangle sufficient to fully encompass all possible spaces
func get_rect():
	var result = Rect2()
	for c in get_children():
		var rect = c.get_used_rect()
		result.position.x = min(result.position.x, rect.position.x)
		result.position.y = min(result.position.y, rect.position.y)
		result.size.x = max(result.size.x, rect.size.x)
		result.size.y = max(result.size.y, rect.size.y)
	return result


func get_tiles(pos = Vector2(0, 0), rot = block_rotation):
	var real_rotation = wrapi(rot, 0, get_child_count())

	var result = get_child(real_rotation).get_used_cells()
	for i in range(result.size()):
		result[i] += pos

	return result
