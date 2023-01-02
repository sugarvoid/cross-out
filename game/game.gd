extends Node2D


const MAX_LIVES: int = 3

var player_score: int 
var player_lives: int

var player: Player


func _ready():
	_update_score(player_score)
	player = get_node("Player")
	player.connect("has_hit_target", self, "_update_score")


func _process(delta):
	$HUD/LblFps.text = str("FPS: ", Engine.get_frames_per_second())


func _update_score(score: int):
	player_score += score
	$HUD/LblScore.text = str("Scrore: ", player_score)
