extends Node2D


const MAX_LIVES: int = 3

var player_score: int 
var player_lives: int

var player: Player

onready var tmr_start_player: Timer = get_node("TmrStart")
onready var player_killzone: Area2D = get_node("KillZone")
onready var lbl_score: RichTextLabel = get_node("HUD/LblScore")
onready var tmr_move_speed_up: Timer = get_node("TmrSpeedUp")


func _ready():
	self.player = get_node("Player")
	self._connect_signals()
	self.tmr_start_player.start(5)
	self.tmr_move_speed_up.start(10)
	_update_score(player_score)
	


func _connect_signals() -> void:
	self.tmr_start_player.connect("timeout", self, "_start_player")
	self.tmr_move_speed_up.connect("timeout", self, "_speed_up_player")
	self.player_killzone.connect("body_entered", self, "_on_player_off_screen")
	self.player.connect("has_hit_target", self, "_update_score")

func _start_player() -> void:
	self.player.in_play = true

func _process(delta):
	$HUD/LblFps.text = str("FPS: ", Engine.get_frames_per_second())

func _on_player_off_screen(body: Node) -> void:
	if body.get_class() == "Player":
		print("player off screen.")

func _update_score(score: int):
	player_score += score
	lbl_score.text = str("Score: ", player_score)

func _speed_up_player() -> void:
	self.player.increase_speed()
