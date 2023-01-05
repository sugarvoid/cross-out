class_name HazardManager
extends Node2D



const p_Hazard: PackedScene = preload("res://game/object/hazard/hazard.tscn")

onready var hazard_container: Node2D = get_node("HazardContainer")
onready var tmr_haz_spawner: Timer = get_node("TmrHazardSpawner")


func _ready() -> void:
	self.tmr_haz_spawner.connect("timeout", self, "_on_spawner_timeout")
	tmr_haz_spawner.start(4)

func _get_rand_spawn_pos() -> Vector2:
	randomize()
	var ran_pos: Vector2
	ran_pos.x = rand_range($SpawnZone/Right.global_position.x, $SpawnZone/Left.global_position.x)
	ran_pos.y = rand_range($SpawnZone/Top.global_position.y, $SpawnZone/Bottom.global_position.y)
	return ran_pos

func add_hazard_to_screen(pos: Vector2) -> void:
	self.hazard_container.add_child(_create_hazard(pos))


func _remove_hazard_to_screen(h: Hazard) -> void:
	self.hazard_container.remove_child(h)


func _create_hazard(pos: Vector2) -> Hazard:
	var _new_hazard: Hazard = p_Hazard.instance()
	_new_hazard.global_position = pos
	_new_hazard.connect("on_life_timeout", self, "_remove_hazard_to_screen")
	return _new_hazard 

func _move_checker() -> void:
	randomize()
	$SpawnChecker.global_position = _get_rand_spawn_pos()

func _get_checkers_overlapping() -> Array:
	return $SpawnChecker.get_overlapping_areas()

func _is_spot_okay() -> bool:
	var over_laping_bods: Array = $SpawnChecker.get_overlapping_areas()
	print(over_laping_bods)
	return (over_laping_bods.size() == 0)

func _on_spawner_timeout() -> void:
	_move_checker()
	yield(get_tree().create_timer(0.5), "timeout")
	if _get_checkers_overlapping().size() == 0:
		add_hazard_to_screen($SpawnChecker.global_position)
	else:
		pass

