class_name Hazard
extends Node2D


onready var _hit_box: Area2D = get_node("Hitbox")


func _ready():
	self._connect_signals()

func _connect_signals() -> void:
	self._hit_box.connect("body_entered", self, "_on_player_colide")

func _on_player_colide(body: Node) -> void:
	print(body)
