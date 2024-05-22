extends Node2D

@onready var death_sound = $DeathSound
@onready var game_over_timer = $GameOverTimer

func _ready():
	game_over_timer.connect("timeout", self, "_on_game_over_timer_timeout")

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout():
	spawn_mob()

func _on_player_health_depleted():
	death_sound.play()
	print("Death Sound should play")
	%GameOver.visible = true
	

func _on_game_over_timer_timeout():
	get_tree().paused = true
