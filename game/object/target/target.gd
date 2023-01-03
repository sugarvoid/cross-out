class_name Target
extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const move_speed: int = 60 

var score: int = 10
export var moving_dir: int


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered", self, "_on_player_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_move(self.moving_dir, delta)


func _move(y_direction: int, delta: float) -> void:
	self.global_position.y += (self.move_speed * delta) * y_direction


func _on_player_entered(body: Node2D):
	if body.has_method("hit_target"):
		body.hit_target(self.score)
		$AnimationPlayer.play("flip_over")
