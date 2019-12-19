extends CanvasLayer

signal start_game

func showMessage(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func showGameOver():
	showMessage("Game Over")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Collect the\nCoins!"
	$MessageLabel.show()
	# TODO move next line to a metod
	yield(get_tree().create_timer(1), 'timeout')
	$StartButton.show()

func updateScore(score):
	$ScoreLabel.text = str(score)

func updateTime(time):
	$TimeLabel.text = str(time)

func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_StartButton_pressed():
	hideStartButton()
	emit_signal("start_game")
	
func hideStartButton():
	$StartButton.hide()
