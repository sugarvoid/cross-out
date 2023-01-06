class_name Target
extends Area2D


var move_speed: int = 120

onready var right_collision: CollisionShape2D = get_node("RightSide")
onready var left_collision: CollisionShape2D = get_node("LeftSide")
onready var vis_noti: VisibilityNotifier2D = get_node("VisibilityNotifier2D")
onready var lbl_value: Label = get_node("Sprite/LblPonits")

var value: int = 10
var moving_dir: int

func _ready():
	self.connect("body_entered", self, "_on_player_entered")
	self.vis_noti.connect("screen_exited", self, "queue_free")
	self._update_lbl_value()
	self._update_sprite()

func _physics_process(delta):
	_move(self.moving_dir, delta)

func set_point_value(n: int) -> void:
	self.value = n

func _update_sprite() -> void:
	if self.value > 0:
		$Sprite.frame = 2
	else:
		$Sprite.frame = 1

func _update_lbl_value() -> void:
	self.lbl_value.text = str(self.value)

func _move(y_direction: int, delta: float) -> void:
	self.global_position.y += (self.move_speed * delta) * y_direction

func _on_player_entered(body: Node2D):
	if body.has_method("hit_target"):
		body.hit_target(self.value)
		$AnimationPlayer.play("flip_over")
