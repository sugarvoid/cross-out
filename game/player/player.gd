class_name Player
extends KinematicBody2D

signal has_hit_target(score_amount) # int

const STARTING_SPEED: int = 300 
const SPEED_UP_AMOUNT: int = 100 
const MAX_X_SPEED: int = 700

var jump_force = 300
var gravity = 700
var velocity = Vector2.ZERO
var jump_next = false
var is_alive = true
var x_movement: int

var in_play: bool = false
var is_falling: bool = false

func get_class() -> String:
	return "Player"

func _ready():
	self.x_movement = self.STARTING_SPEED

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if !self.is_falling:
			self.jump_next = true

func _is_moving_right() -> bool:
	if self.x_movement < 0:
		return false
	else:
		return true

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
	if self._is_moving_right():
		self.x_movement += self.SPEED_UP_AMOUNT
	else:
		self.x_movement -= self.SPEED_UP_AMOUNT
	
	print(str("Player speed is now ", self.x_movement))


func fall_down() -> void:
	self.is_falling = true
	self.x_movement = 0

