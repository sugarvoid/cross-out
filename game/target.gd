extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var score: int = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered", self, "_on_player_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_player_entered(body: Node2D):
	if body.has_method("hit_target"):
		body.hit_target(self.score)
		$AnimationPlayer.play("flip_over")
