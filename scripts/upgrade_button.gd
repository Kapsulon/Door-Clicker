@tool
extends TextureButton

@export var icon: Texture2D = null:
	set(new_icon):
		icon = new_icon
		$TextureRect.set("texture", icon)

@export var title: String = "":
	set(new_title):
		title = new_title
		$Label.set("text", title)

@export var price: int = 0:
	set(new_price):
		price = new_price
		$Label2.set("text", str(price) + " Dabloons")

func _ready():
	pass

func _process(delta):
	pass
