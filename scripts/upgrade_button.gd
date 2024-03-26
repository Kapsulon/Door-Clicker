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

@export var start_price: Dictionary = {}

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

var dabloons_price: Dictionary = {}

func _ready():
    if len(start_price.keys()) == 0:
        start_price = Orders.generate_dabloons_store()
    if start_price.keys()[0] != "u":
        var tmp = Orders.generate_dabloons_store()
        for k in start_price.keys():
            tmp[k] = start_price[k]
        start_price = tmp.duplicate()
    dabloons_price = start_price.duplicate()
    set_price(dabloons_price)

func _process(delta):
    pass

func get_player_dabloons():
    return get_node("/root/world").dabloons

func set_price(new_price: Dictionary):
    dabloons_price = new_price
    price = Orders.display_num(new_price)

func _on_pressed():
    var money: Dictionary = get_player_dabloons()
    if (Orders.compare_dabloons_greater_or_equal(money, dabloons_price)):
        Orders.remove_dabloons(dabloons_price, money)
        Orders.multiply_dabloons(dabloons_price, 1.5)
        set_price(dabloons_price)
        level += 1
