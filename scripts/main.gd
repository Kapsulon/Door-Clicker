extends Node

const FALL_GUY: PackedScene = preload("res://scenes/fall_guy.tscn")

var dabloons: Dictionary = {}


func _ready() -> void:
    dabloons = Orders.generate_dabloons_store()
    $Path2D.generate_line = true


func _on_click_gui_input(event: InputEvent) -> void:
    if ((event is InputEventMouseButton and event.button_index == 1) or event is InputEventScreenTouch) and event.is_pressed():
        var fall = FALL_GUY.instantiate()
        fall.position = $fall_guys_pos.position
        add_child(fall)
        fall.emitting = true
        $Path2D.advance = !$Path2D.advance
        var tmp = Orders.generate_dabloons_store()
        tmp["u"] = 1
        Orders.add_dabloons(tmp, dabloons)


func _process(delta: float) -> void:
    var tmp: String = Orders.display_num(dabloons)
    $UI/clicks.text = tmp + " Dabloons"


func _on_check_button_pressed() -> void:
    $AudioStreamPlayer.playing = $UI/CheckButton.is_pressed()
