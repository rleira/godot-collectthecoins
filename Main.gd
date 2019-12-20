extends Node

export (PackedScene) var Coin

const LEVEL_MAX_TIME = 30

var score
var time

func _ready():
	randomize()
	newGame()
	print(GameInput.getKey("version"))

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
	$CoinPath/CoinSpawnLocation.set_offset(randi())
	# Create a Coin instance and add it to the scene.
	var coin = Coin.instance()
	add_child(coin)
	# Set the coin's direction perpendicular to the path direction.
	var direction = $CoinPath/CoinSpawnLocation.rotation + PI / 2
	# Set the coin's position to a random location.
	coin.position = $CoinPath/CoinSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	coin.rotation = direction
	# Set the velocity (speed & direction).
	coin.linear_velocity = Vector2(rand_range(coin.min_speed, coin.max_speed), 0)
	coin.linear_velocity = coin.linear_velocity.rotated(direction)
	
	# Connect delete of coins at game end
	$HUD.connect("start_game", coin, "_on_start_game")

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
