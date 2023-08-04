extends Node2D

var Global_script = preload("res://Global.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var SV = get_node("Score_Value")
	SV.set("text",str(GS.good_answer) + " / " + str(GS.total_question))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
