extends Node2D

var q_data = [
	{
		 "Q": "What is the meaning of life?",
		"A": ["Life is good","Help!","There is Hope","What?"]
	 },
	{
		"Q": "What time is it?",
		"A": ["tiger time","Now?","where?","10:00"]
	}
]  

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _loadquestion(value):
	var n = value
	var QT = get_node("QuestionText")
	QT.set("text","Test Question")
	var NQ = q_data[n].Q
	QT.set("text",NQ)
	
	var AT = get_node("ANS A")
	var AQ = q_data[n].A[0]
	AT.set("text",AQ)
	
	AT = get_node("ANS B")
	AQ = q_data[n].A[1]
	AT.set("text",AQ)
	
	AT = get_node("ANS C")
	AQ = q_data[n].A[2]
	AT.set("text",AQ)
	
	AT = get_node("ANS D")
	AQ = q_data[n].A[3]
	AT.set("text",AQ)

	# pass	

# Called when the node enters the scene tree for the first time.
func _ready():
	_loadquestion(1)
	
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
