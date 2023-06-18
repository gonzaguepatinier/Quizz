extends Node2D

var num = 0

var q_data = []

var Old_data = [
	{
		 "Q": "What is the meaning of life?",
		"A": ["Life is good","Help!","There is Hope","What?"],
		"CA":1
	 },
	{
		"Q": "What time is it?",
		"A": ["tiger time","Now?","where?","10:00"],
		"CA":1
	},
	{
		"Q": "What language you speak?",
		"A": ["French","Russian","Italian","Alien"],
		"CA":1
	},
	{
		"Q": "What car do you drive?",
		"A": ["Audi","BMW","Toyota","Honda"],
		"CA":4
	},
	{
		"Q": "Where do you live?",
		"A": ["in space","Bangkok","New York","in a cave"],
		"CA":2
	}
]  

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _writejson_old():
	var file = File.new()
	if file.open("user://saved_game.sav", File.WRITE) != 0:
		print("Error opening file")
		return

	# Save the dictionary as JSON (or whatever you want, JSON is convenient here because it's built-in)
	file.store_line(q_data.to_json())
	file.close()

func _writejson():
	var jsonStr = JSON.print(q_data)
	var file = File.new()
	if file.open("user://user_data.json", File.WRITE) == OK:
		file.store_string(jsonStr)
		file.close()
		print("Data exported to JSON successfully.")
	else:
		print("Failed to open file for writing.")

func loadFromJson():
	var file = File.new()
	if file.open("res://user_data.json", File.READ) == OK:
		var jsonStr = file.get_as_text()
		file.close()
		
		var jsonData = JSON.parse(jsonStr)
		q_data = jsonData.result
		# q_data = jsonData
		if jsonData != null:
			# Data has been loaded successfully
			processLoadedData(jsonData)
		else:
			print("Failed to parse JSON data.")
	else:
		print("Failed to open file for reading.")

func processLoadedData(data):
	# Process the loaded data here
	print("Loaded data:", data)


func _loadquestion(value):
	var n = value
	
	var QN = get_node("QuestionNumber")
	var MaxQString = str(q_data.size())
	var QNString = str(n+1)
	
	QN.set("text",QNString + "/" + MaxQString)
	
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
	num = 0
	loadFromJson()
	
	_loadquestion(num)
	
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Next_Q_pressed():
	num = num + 1
	if num == q_data.size():
		num = 0
	
	_loadquestion(num)
	#pass # Replace with function body.


func _on_Save_pressed():
	_writejson()
	pass # Replace with function body.
