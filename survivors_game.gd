extends Node2D

@onready var death_sound = $DeathSound
@onready var game_over_timer = $GameOverTimer
@onready var game_over_screen = %GameOver  # Reference to the GameOver node
@onready var path_follow = %PathFollow2D  # Reference to the PathFollow2D node
var game_over = false  # Flag to track game over state

func _ready():
	game_over_timer.connect("timeout", Callable(self, "_on_game_over_timer_timeout"))
	print("Game Over Timer connected")

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	path_follow.progress_ratio = randf()
	new_mob.global_position = path_follow.global_position
	add_child(new_mob)

func _on_timer_timeout():
	spawn_mob()

func _on_player_health_depleted():
	if not game_over:
		game_over = true
		if not death_sound.playing:
			death_sound.play()
			print("Death Sound should play")
		game_over_screen.visible = true  # Make the game over screen visible
		game_over_timer.start(1.5)  # Start the timer with a 1-second delay
		print("Game Over Timer started")
	else:
		print("Game over already triggered, skipping")

func _on_game_over_timer_timeout():
	print("Game Over Timer timeout")
	get_tree().paused = true
	print("Game paused")



