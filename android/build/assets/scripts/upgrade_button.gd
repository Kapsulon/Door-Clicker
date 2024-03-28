@tool
class_name UpgradeButton extends TextureButton

@export var icon: Texture2D = null:
	set(new_icon):
		icon = new_icon
		$TextureRect.set("texture", icon)

@export var title: String = "Text":
	set(new_title):
		title = new_title
		$Label.set("text", title)

@export var start_price: Vector2i = Vector2i.ZERO:
	set(new_start_price):
		start_price = new_start_price
		dabloons_price = Big.new(new_start_price.x, new_start_price.y)
		set_price(dabloons_price)

@export var level: int = 0:
	set(new_level):
		level = new_level
		$Label3.set("text", new_level)

var price: String = "0 Dabloons":
	set(new_price):
		price = new_price + " Dabloons"
		var price_label = $Label2
		if (price_label != null):
			price_label.set("text", price)

var dabloons_price: Big = Big.new(0)

func _ready():
	set_price(dabloons_price)

func _process(delta):
	pass

func get_player_dabloons() -> Big:
	return get_node("/root/world").dabloons

func set_price(new_price: Big):
	dabloons_price = new_price
	price = new_price.toAA()

func _on_pressed():
	var money: Big = get_player_dabloons()
	if (money.isGreaterThanOrEqualTo(dabloons_price)):
		get_node("/root/world").dabloons = money.minus(dabloons_price)
		dabloons_price = dabloons_price.times(1.5)
		dabloons_price = Big.roundDown(dabloons_price)
		set_price(dabloons_price)
		level += 1
