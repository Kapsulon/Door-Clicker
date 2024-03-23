@tool extends Path2D

var guy_in_line = preload("res://scenes/guy_in_line.tscn")

@export var generate_line: bool = false:
    set(n_generate_line):
        for i in range(50):
            var tmp = guy_in_line.instantiate()
            add_child(tmp)
            tmp.progress_ratio = i / 50.0

@export var clear_line: bool = false:
    set(n_clear_line):
        for child in get_children():
            child.queue_free()

@export var advance: bool = false:
    set(n_advance):
        advance = n_advance
        if n_advance == false:
            return
        for child in get_children():
            var tw: Tween = create_tween()
            tw.tween_property(child, "progress_ratio", child.progress_ratio + (1.0 / 50.0), 0.1)
            child.get_node("Guy").z_index = (child.progress_ratio + (1.0 / 50.0)) * 1000
            tw.play()
        get_parent().get_node("Door").frame = 1
        await get_tree().create_timer(0.1).timeout
        get_parent().get_node("Door").frame = 0
        advance = false
