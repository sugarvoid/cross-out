class_name Hazard
extends Node2D

signal on_life_timeout(hazard)
signal on_player_collide


onready var _hit_box: Area2D = get_node("Hitbox")
onready var _trm_lifetime: Timer = get_node("TmrLifetime")


var time_on_screen: int = 5

func _ready() -> void:
	self.modulate.a = 0
	self._connect_signals()
	$AnimationPlayer.play("fade_in")

func _physics_process(delta: float) -> void:
	self.rotation_degrees += 25 * delta

func _connect_signals() -> void:
	self._hit_box.connect("body_entered", self, "_on_player_collide")
	self._trm_lifetime.connect("timeout", self, "_on_life_timer_timeout")
	$AnimationPlayer.connect("animation_finished", self, "_on_anim_finished")

func _start_timer() -> void:
	self._trm_lifetime.start(self.time_on_screen)

func _on_player_collide(body: Node) -> void:
	if body.get_class() == "Player":
		body.take_damage()
	
func _on_life_timer_timeout() -> void:
	# TODO: Add a fade out animation 
	### $AnimationPlayer.play_backwards("fade_out")
	self.emit_signal("on_life_timeout", self)
	

func _on_anim_finished(anmi_name: String) -> void:
	match anmi_name:
		"fade_in":
			_start_timer()
			### self.emit_signal("on_life_timeout", self)
