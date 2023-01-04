class_name Target
extends Area2D


const move_speed: int = 90

onready var right_collision: CollisionShape2D = get_node("RightSide")
onready var left_collision: CollisionShape2D = get_node("LeftSide")

var score: int = 10
var moving_dir: int

func _ready():
	self.connect("body_entered", self, "_on_player_entered")

func _physics_process(delta):
	_move(self.moving_dir, delta)

func _move(y_direction: int, delta: float) -> void:
	self.global_position.y += (self.move_speed * delta) * y_direction

func _on_player_entered(body: Node2D):
	if body.has_method("hit_target"):
		body.hit_target(self.score)
		$AnimationPlayer.play("flip_over")
