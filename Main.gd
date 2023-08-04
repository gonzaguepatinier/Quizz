extends Node2D

var global_script = preload("res://Global.gd")
onready var my_node = get_node("VBoxContainer/Start")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Start_pressed():
	
	# GS.quizz_file = 
	get_tree().change_scene("res://Question.tscn")
	


func _on_ItemList_item_selected(index):
	var IL = get_node("VBoxContainer/ItemList")
	var selected_item_text = IL.get_item_text(index)
	my_node.disabled = false
	# var quizz_file = "res://user_data.json"
	GS.quizz_file = "res://" + selected_item_text + "_data.json"
	print (selected_item_text)
	print (GS.quizz_file)
	pass # Replace with function body.
