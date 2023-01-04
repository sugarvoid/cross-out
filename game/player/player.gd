class_name Player
extends KinematicBody2D

signal has_hit_target(score_amount) # int

const STARTING_SPEED: int = 300 
const SPEED_UP_AMOUNT: int = 100 

var jump_force = 300
var gravity = 700
var velocity = Vector2.ZERO
var jump_next = false
var is_alive = true
var screen_size
var x_movement: int
var in_play: bool = false

func get_class() -> String:
	return "Player"

func _ready():
	screen_size = get_viewport_rect().size
	self.x_movement = self.STARTING_SPEED

func _input(event):
	if event.is_action_pressed("ui_accept"):
		self.jump_next = true

func _physics_process(delta):
	if self.in_play:
		velocity.y += gravity * delta
		if jump_next:
			jump_next = false
			if velocity.y > 0:
				velocity.y = 0

			velocity.y -= jump_force
			velocity.y = max(velocity.y, -400)

		global_position.x += x_movement * delta
		velocity = move_and_slide(velocity)

func hit_target(score: int) -> void:
	emit_signal("has_hit_target", score)
	_toggle_x()

func _toggle_x() -> void:
	self.x_movement = x_movement * -1

func increase_speed() -> void:
	self.x_movement += self.SPEED_UP_AMOUNT

#func went_off_screen():
#	print("went off screen")