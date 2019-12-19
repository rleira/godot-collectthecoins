Game designed and implemented following the GODOT official tutorial: https://docs.godotengine.org/en/3.1/getting_started/step_by_step/your_first_game.html
Implementation testing and running in GODOT v3.1.1

###Running the game
You can run the game from the godot GUI by selecting the Main.tscn and pressing the play button on it.
Optionally and if you have the godot binary in your PATH you can run the game with the following command:
```
godot Main.tscn
```

####Running exported version from the browser
To run the exported version you need to serve the exported assets.
To do so run the following command from the export folder:
```python -m SimpleHTTPServer 8000```
Then open ```localhost:8000``` and open the .html from the list.
See https://github.com/godotengine/godot/issues/16664 for more details.
