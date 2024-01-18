# [Eggplant50](https://itch.io/jam/eggplant-50)

We're trying to pack a bunch of games together!

# Theme

📐 Finding Poetry in Geometry

This is for the UFO 50 fan jam or Jamuary as @docky has so aptly dubbed it. We
voted and selected this theme. More details on the
[Jam Page](https://itch.io/jam/eggplant-50).

# Adding your game

1. Clone this repo as a template so you can create your game in Godot 3.5 with this project as your base.
2. Create your game in res://games/your-name-here That way all our games are isolated, so it should be easier to merge them back together.
3. Create a GameDef as res://games/your-name-here/game_yourname.tres
4. Add your GameDef to res://games/eggplant_games.tres

Once the jam is done, we can merge all the different projects, re-add
everyone's GameDef to res://games/eggplant_games.tres, and hopefully the package will
all work!

## Steps I followed

- Make a directory in under `res://games` in the **FileSystem** tab of
  Godot by right clicking on `games` and choosing **New Folder**
- In that same interface right click on the newly created folder and
  selected **New Resource**, search for `GameDef`, click **Create**,
  give the resource a name e.g `bonbon.tres`
- Then open `eggplant_games.tres` again from the **FileSystem** tab,
  then in the **Inspector**, click on the **Array** of the **Games**
  variable in the resource, increase the size by 1, then click the
  **\[empty]** value, scroll down to **Quick Load** and then from the
  large list of files choose your newly created resource file (e.g `bonbon.tres`).
- Realise I haven't configured the resource file at all, open that up
  in the **Inspector** and further realise a game is needed. So I
  create a scene under the earlier created folder, again right click
  on that folder and choose **New Scene**, open that and edit it.
- With something in that scene (I just threw a `ColorRect` and a
  `Label` to show _something_) I then went back to the new resource
  file and set the **Initial Scene** variable to that newly created
  scene, added a name to **Game Name** and put my name in **Game
  Author**
- Then I hit **Play**, a button in the top right that looks like ▶,
  and it worked like a charm!

## Inputs

Use the `move_` inputs for movement:

	# Using get_vector will have a circular deadzone.
	var move := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	print(move.x, move.y)

	# Using get_axis will have a cross deadzone.
	var move_x := Input.get_axis("move_left", "move_right")
	var move_y := Input.get_axis("move_up", "move_down")

Use `action1` and `action2` for actions:

	var jumped = Input.is_action_just_pressed("action1")
	var grabbing = Input.is_action_pressed("action2")


The input mapping is modelled after [pico-8](https://iiviigames.github.io/pico8-api/img/input.png):

* primary action: Z,C,N,Space keys or X,B buttons
* secondary action: X,V,M keys or A,Y buttons
* pause: Enter,p keys or Start,Select buttons


## Returning to Menu

To return to main menu from your game, call:

    Eggplant.return_to_menu()

You could do this from the `pause` input (see games/movement2/World/World.gd)
or something more sophisticated.


## Deploy to itch.io

You should ensure your game works in a web build. The template includes a
script to simplify build creation and itch.io upload.

1. Create an itch.io project called `eggplant50`. Make sure to [enable SharedArrayBuffer](https://itch.io/t/2025776/experimental-sharedarraybuffer-support).
2. To auto-upload to itch.io:
    1. Edit `ci/pushbuild.py` and change "idbrii" to your itch.io name.
    2. [Install and setup butler](https://itch.io/docs/butler/)
2. To manually upload to itch.io:
    1. Edit `ci/pushbuild.py` and set `itch_project = False`
    1. `export_path` will be where to find your files to upload to itch.io.
4. Run pushbuild:

```
pip install -r ci/requirements.txt
python ci/pushbuild.py
```

