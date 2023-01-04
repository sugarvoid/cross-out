extends Control


onready var _btn_start: Button = get_node("BtnStart")


func _ready() -> void:
	self._btn_start.connect("pressed", self, "_start_game")


func _start_game() -> void:
	get_tree().change_scene("res://game/game.tscn")
