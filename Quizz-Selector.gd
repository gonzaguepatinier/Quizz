extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

func button_pressed():
	print ("real button pressed")

func _ready():
	var box_instance = BoxInstance.new()
	
	# Set its position (adjust as needed)
	box_instance.position = Vector2(100, 100)
	
	# Add the box instance to the scene
	add_child(box_instance)
	
	var new_button = TextureButton.new()
	add_child(new_button)
	new_button.rect_size = Vector2(100, 30)
	new_button.rect_global_position = Vector2(80, 80)
	new_button.texture_normal = load("res://icon-button.png")
	new_button.connect("pressed", self, "button_pressed")
	print("enter scene")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
