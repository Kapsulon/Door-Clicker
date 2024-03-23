extends Node

const LETTERS: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

var clicks = 0

func getOrders() -> Array[String]:
    var tmp: Array[String] = ["M", "B", "T", "Qua", "Qui", "Se", "Oc", "No"]
    for li in LETTERS:
        for lj in LETTERS:
            tmp.append(li + lj)
    return tmp

func _ready() -> void:
    print(getOrders())

func _on_click_gui_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.is_pressed():
        clicks += 1

func _process(delta: float) -> void:
    $UI/clicks.text = str(clicks)
