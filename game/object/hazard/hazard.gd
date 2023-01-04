class_name Hazard
extends Node2D

signal on_life_timeout(hazard)


onready var _hit_box: Area2D = get_node("Hitbox")
onready var _trm_lifetime: Timer = get_node("TmrLifetime")

var time_on_screen: int = 5


func _ready() -> void:
	self._connect_signals()
	self._start_timer()

func _connect_signals() -> void:
	self._hit_box.connect("body_entered", self, "_on_player_colide")
	self._trm_lifetime.connect("timeout", self, "_on_life_timer_timeout")

func _start_timer() -> void:
	self._trm_lifetime.start(self.time_on_screen)

func _on_player_colide(body: Node) -> void:
	print(body)
	
func _on_life_timer_timeout() -> void:
	self.emit_signal("on_life_timeout", self)
