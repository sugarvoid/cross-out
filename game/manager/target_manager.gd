extends Node2D


const p_Target: PackedScene = preload("res://game/object/target/target.tscn")

onready var right_spawn_pos: Position2D = get_node("RightBottom")
onready var left_spawn_pos: Position2D = get_node("LeftTop")
onready var tmr_left: Timer = get_node("TmrLeft")
onready var tmr_right: Timer = get_node("TmrRight")
onready var target_container: Node2D = get_node("Targats")


func _ready():
	self._connect_signals()
	self._start_spawn_timers()

func _start_spawn_timers() -> void:
	self.tmr_left.start(1.5)
	self.tmr_right.start(1.5)

func _connect_signals() -> void:
	self.tmr_left.connect("timeout", self, "_spawn_left")
	self.tmr_right.connect("timeout", self, "_spawn_right")

func _spawn_taget(side: int, direction: int = 1) -> void:
	var new_target: Target = p_Target.instance()

func _spawn_left() -> void:
	var new_target: Target = p_Target.instance()
	new_target.moving_dir = 1
	
	new_target.global_position = self.left_spawn_pos.global_position
	self.target_container.add_child(new_target)
	new_target.remove_child(new_target.left_collision)

func _spawn_right() -> void:
	var new_target: Target = p_Target.instance()
	new_target.moving_dir = -1
	
	new_target.global_position = self.right_spawn_pos.global_position
	self.target_container.add_child(new_target)
	new_target.remove_child(new_target.right_collision)
