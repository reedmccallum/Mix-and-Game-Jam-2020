tool
extends Node2D

export(int, 33) var frame setget _set_frame, _get_frame
#export(Vector2) var coords = Vector2() setget _set_coords, _get_coords

func _ready():
	_set_frame(frame)

func _set_frame(value):
	$Sprite.set_frame(value)

func _get_frame():
	return $Sprite.get_frame()

func destroy():
	this.get_parent()
	this.delete()
