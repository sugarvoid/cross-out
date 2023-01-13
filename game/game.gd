extends Node2D


const MAX_LIVES: int = 3
const p_Player: PackedScene = preload("res://game/player/player.tscn")

var player_score: int 
var player_lives: int
var player: Player
var is_game_over: bool = false

onready var tmr_start_player: Timer = get_node("TmrStart")
onready var tmr_move_speed_up: Timer = get_node("TmrSpeedUp")

onready var player_killzone: Area2D = get_node("KillZone")

onready var lbl_score: RichTextLabel = get_node("HUD/LblScore")
onready var lbl_fps: RichTextLabel = get_node("HUD/LblFps")

onready var ani_player: AnimationPlayer = get_node("AnimationPlayer")


func _ready():
	
	self._connect_signals()
	self._drop_in_player()
	
	_update_score(player_score)

func _connect_signals() -> void:
	self.tmr_start_player.connect("timeout", self, "_start_player")
	self.tmr_move_speed_up.connect("timeout", self, "_speed_up_player")
	self.player_killzone.connect("body_entered", self, "_on_player_off_screen")
	

func _start_player() -> void:
	$HUD/LblInfo.visible = false
	self.player.in_play = true

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if self.player.in_play == false:
			self.tmr_move_speed_up.start(10)
			$HazardManager.start_hazard_timer()
			self.player.in_play = true
		else:
			return
	if event.is_action_pressed("restart"):
		if self.is_game_over:
			pass
			# TODO: Add way to restart game
			get_tree().change_scene("res://game/start_screen.tscn")
			# Restart game

func _process(delta):
	self.lbl_fps.text = str("FPS: ", Engine.get_frames_per_second())

func _drop_in_player() -> void:
	var new_player: Player = p_Player.instance()
	new_player.global_position = $PosPlayerSpawn.global_position
	self.add_child(new_player)
	self.player = new_player
	self.player.connect("has_hit_target", self, "_update_score")
	
	# self.ani_player.play("drop_in_player")

func _on_player_off_screen(body: Node) -> void:
	if body.get_class() == "Player":
		print("player off screen.")
		self._gameover()

func _send_info_to_label(s: String) -> void:
	$HUD/LblInfo.visible = true
	$HUD/LblInfo.text = s

func _update_score(score: int):
	#self.player_score += score
	self.player_score = clamp(player_score + score, 0, 9999)
	self.lbl_score.text = str("Score: ", self.player_score)

func _speed_up_player() -> void:
	self.ani_player.play("flash_lbl_speed")
	self.player.increase_speed()

func _gameover() -> void:
	self.is_game_over = true
	_send_info_to_label("Game Over")
	self.player.global_position = $PosPlayerSpawn.global_position
	self.player.in_play = false
	self.tmr_move_speed_up.stop()
	remove_child($HazardManager)
	remove_child($TargetManager)
	remove_child(self.player)
