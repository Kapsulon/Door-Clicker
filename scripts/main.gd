extends Node

const FALL_GUY: PackedScene = preload("res://scenes/fall_guy.tscn")
var UPGRADES: Array[Node]

var dabloons: Big


func click() -> void:
    for i in range(min(UPGRADES[1].level + 1, 10)):
        for j in range(min(UPGRADES[0].level + 1, 10)):
            var fall = FALL_GUY.instantiate()
            fall.position = $fall_guys_pos.position
            add_child(fall)
            fall.emitting = true
        $Path2D.advance = !$Path2D.advance
    var tmp: Big = Big.new(0)
    tmp = tmp.plus(UPGRADES[0].level + 1)
    tmp = tmp.times(UPGRADES[1].level + 1)
    tmp = tmp.toThePowerOf((UPGRADES[2].level / 10) + 1)
    dabloons = dabloons.plus(tmp)


func _ready() -> void:
    UPGRADES = $UI/ScrollContainer/VBoxContainer.get_children()
    dabloons = Big.new(0)
    dabloons.setSmallDecimals(1)
    $Path2D.generate_line = true


func _on_click_gui_input(event: InputEvent) -> void:
    if ((event is InputEventMouseButton and event.button_index == 1) or event is InputEventScreenTouch) and event.is_pressed():
        click()


func _process(_delta: float) -> void:
    if Input.is_action_pressed("debug"):
        click()
    print(dabloons.toString())
    $UI/clicks.text = dabloons.toAA() + " Dabloons"


func _on_check_button_pressed() -> void:
    $AudioStreamPlayer.playing = $UI/CheckButton.is_pressed()
