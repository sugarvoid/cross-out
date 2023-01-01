class_name Player
extends KinematicBody2D

var jump_speed = -400
var gravity = 700
var velocity = Vector2.ZERO
var jump_next = false
var is_alive = true
var screen_size
var x_movement = 400

func _ready():
	screen_size = get_viewport_rect().size
	self.velocity = Vector2.ZERO

func _input(event):
	if event.is_action_pressed("ui_accept"):
		self.jump_next = true

func _physics_process(delta):
	velocity.y += gravity * delta
	if jump_next:
		jump_next = false
		if velocity.y > 0:
			velocity.y = 0

		velocity.y += jump_speed
		velocity.y = max(velocity.y, -400)

	global_position.x += x_movement * delta
	velocity = move_and_slide(velocity)
	global_position.y = clamp(global_position.y,-10, screen_size.y)

func toggle_x() -> void:
	self.x_movement = x_movement * -1

