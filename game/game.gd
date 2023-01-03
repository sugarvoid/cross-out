extends Node2D


const MAX_LIVES: int = 3

var player_score: int 
var player_lives: int

var player: Player

onready var tmr_start_player: Timer = get_node("TmrStart")
onready var player_killzone: Area2D = get_node("KillZone")


func _ready():
	self.tmr_start_player.connect("timeout", self, "_start_player")
	player_killzone.connect("body_entered", self, "_on_player_off_screen")
	self.tmr_start_player.start(5)
	_update_score(player_score)
	player = get_node("Player")
	player.connect("has_hit_target", self, "_update_score")

func _start_player() -> void:
	self.player.in_play = true

func _process(delta):
	$HUD/LblFps.text = str("FPS: ", Engine.get_frames_per_second())

func _on_player_off_screen(body: Node) -> void:
	if body.get_class() == "Player":
		print("player off screen.")

func _update_score(score: int):
	player_score += score
	$HUD/LblScore.text = str("Score: ", player_score)
