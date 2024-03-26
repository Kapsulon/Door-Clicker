extends Node

const FALL_GUY: PackedScene = preload("res://scenes/fall_guy.tscn")
var UPGRADES: Array[Node]

var dabloons: Dictionary = {}


func click() -> void:
    for i in range(min(UPGRADES[1].level + 1, 10)):
        for j in range(min(UPGRADES[0].level + 1, 10)):
            var fall = FALL_GUY.instantiate()
            fall.position = $fall_guys_pos.position
            add_child(fall)
            fall.emitting = true
        $Path2D.advance = !$Path2D.advance
    var tmp = Orders.generate_dabloons_store()
    tmp["u"] = pow((UPGRADES[0].level + 1) * (UPGRADES[1].level + 1), ((UPGRADES[2].level / 10) + 1))
    Orders.add_dabloons(tmp, dabloons)


func _ready() -> void:
    UPGRADES = $UI/ScrollContainer/VBoxContainer.get_children()
    dabloons = Orders.generate_dabloons_store()
    dabloons["M"] = 5
    $Path2D.generate_line = true


func _on_click_gui_input(event: InputEvent) -> void:
    if ((event is InputEventMouseButton and event.button_index == 1) or event is InputEventScreenTouch) and event.is_pressed():
        click()


func _process(_delta: float) -> void:
    if Input.is_action_pressed("ui_accept"):
        click()
    var tmp: String = Orders.display_num(dabloons)
    $UI/clicks.text = tmp + " Dabloons"


func _on_check_button_pressed() -> void:
    $AudioStreamPlayer.playing = $UI/CheckButton.is_pressed()
