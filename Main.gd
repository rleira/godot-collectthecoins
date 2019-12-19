extends Node

export (PackedScene) var Mob

const LEVEL_MAX_TIME = 30

var score
var time

func _ready():
	randomize()
	newGame()

func gameOver():
	$LevelTimer.stop()
	$CoinTimer.stop()
	$HUD.showGameOver()
	$Music.stop()
	$DeathSound.play()
	$HUD.updateTime(LEVEL_MAX_TIME)

func newGame():
	score = 0
	time = LEVEL_MAX_TIME
	$HUD.updateTime(LEVEL_MAX_TIME)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.updateScore(score)
	$HUD.showMessage("Get Ready")
	$HUD.hideStartButton()
	$Music.play()

func _on_CoinTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.set_offset(randi())
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Set the velocity (speed & direction).
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	
	# Connect delete of mobs at game end
	$HUD.connect("start_game", mob, "_on_start_game")

func _on_LevelTimer_timeout():
	time -= 1
	$HUD.updateTime(time)
	if time <= 0:
		gameOver()

func _on_StartTimer_timeout():
	$CoinTimer.start()
	$LevelTimer.start()

func _on_Player_hit():
	if time > 0:
		score += 1
		$HUD.updateScore(score)
