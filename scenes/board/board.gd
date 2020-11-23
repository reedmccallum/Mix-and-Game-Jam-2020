extends Node2D

var rand = RandomNumberGenerator.new()
enum GameState {RUNNING, STOPPED}
var _game_state = GameState.RUNNING

#export(Vector2) var board_size = Vector2(10, 20) setget _set_size

var _active_gun

var _gun_types = [
	preload("res://scenes/guns/grenade.tscn"),
	preload("res://scenes/guns/pistols.tscn"),
	preload("res://scenes/guns/cannon.tscn"),
	preload("res://scenes/guns/revolver.tscn"),
	preload("res://scenes/guns/rpg.tscn"),
	preload("res://scenes/guns/shotgun.tscn"),
	preload("res://scenes/guns/sniper.tscn")
]

func _ready():
	rand.randomize()
	_new_gun()
	# generate gun at top of grid

# use a random generator to select an active gun type
func _new_gun():
	_active_gun = _gun_types[rand.randi() % _gun_types.size()].instance()
	_active_gun.move_right(3)
	_active_gun.set_name("gun")
	add_child(_active_gun)
	$Timer.start()

# gun movement
func _input(event):
	if _game_state == GameState.RUNNING:
		if event.is_action_pressed("ui_right") and _can_move_right():
			_active_gun.move_right(1)
		elif event.is_action_pressed("ui_left") and _can_move_left():
			_active_gun.move_left(1)
		elif event.is_action_pressed("ui_up") and _can_rotate_clockwise(): #rework inputs
			_active_gun.rotate_clockwise(1)
		elif event.is_action_pressed("ui_down") and _can_rotate_counterclockwise(): #rework inputs
			_active_gun.rotate_counterclockwise(1)
		elif event.is_action_pressed("ui_select"): #rework inputs
			_land()

#if there's more falling to do, do it. Then dissolve to tiles and make new gun
func _land():
	#TODO: implement logic
#	while _can_move_down():
#		_active_gun.move_down(1)
	#or determine how far down can go and move down that amount
	_new_gun()

func _can_move_down():
	#TODO: implement logic
	return true

func _can_move_left():
	#TODO: implement logic
	return true

func _can_move_right():
	#TODO: implement logic
	return true

func _can_rotate_clockwise():
	#TODO: implement logic
	return true

func _can_rotate_counterclockwise():
	#TODO: implement logic
	return true

func _on_Timer_timeout() -> void:
	if _can_move_down():
		_active_gun.move_down(1)
	else:
		_land()
