extends Node2D

var global_script = preload("res://Global.gd")

# var GS = get_node("res://Global")

var num = 0
var condition_met = false

var q_data = []
var a_data = []

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
	# if file.open("res://user_data.json", File.READ) == OK:
	if file.open(GS.quizz_file, File.READ) == OK:
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
	for _i in range(q_data.size()):
			a_data.append("?")

func processLoadedData(data):
	# Process the loaded data here
	print("Loaded data:", data)


func _loadquestion(value):
	var n = value
	
	var QN = get_node("QuestionNumber")
	var ANS = get_node("Answer")
	var COR_ANS = get_node("Correct_Answer")
	
	var MaxQString = str(q_data.size())
	var QNString = str(n+1)
	
	QN.set("text",QNString + "/" + MaxQString)
	
	var QT = get_node("QuestionText")
	QT.set("text","Test Question")
	var NQ = q_data[n].Q
	QT.set("text",NQ)

	var CA = q_data[n].CA
	COR_ANS.set("text",CA)
	
	ANS.set("text",a_data[n])
	
	var AT = get_node("ANSGRID/ANS A")
	var AQ = q_data[n].A[0]
	AT.set("text",AQ)
	
	AT = get_node("ANSGRID/ANS B")
	AQ = q_data[n].A[1]
	AT.set("text",AQ)
	
	AT = get_node("ANSGRID/ANS C")
	AQ = q_data[n].A[2]
	AT.set("text",AQ)
	
	AT = get_node("ANSGRID/ANS D")
	AQ = q_data[n].A[3]
	AT.set("text",AQ)

	# pass	

# Called when the node enters the scene tree for the first time.
func _ready():
	num = 0
	loadFromJson()
	periodic_check()
	_loadquestion(num)
	
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Prev_Q_pressed():
	if (num > 0):
		num = num - 1
	
	_loadquestion(num)
		
func _on_Next_Q_pressed():
	num = num + 1
	if num == q_data.size():
		num = num -1
	
	_loadquestion(num)
	#pass # Replace with function body.


func _on_Save_pressed():
	_writejson()
	pass # Replace with function body.


func _on_ANS_A_pressed():
	var text_value = "A"
	a_data[num] = text_value
	var ANS = get_node("Answer")
	ANS.set("text",a_data[num])
	pass # Replace with function body.


func _on_ANS_B_pressed():
	var text_value = "B"
	a_data[num] = text_value
	var ANS = get_node("Answer")
	ANS.set("text",a_data[num])
	pass # Replace with function body.



func _on_ANS_C_pressed():
	var text_value = "C"
	a_data[num] = text_value
	var ANS = get_node("Answer")
	ANS.set("text",a_data[num])
	pass # Replace with function body.


func _on_ANS_D_pressed():
	var text_value = "D"
	a_data[num] = text_value
	var ANS = get_node("Answer")
	ANS.set("text",a_data[num])
	pass # Replace with function body.


func _on_Submit_pressed():
	# check all questions answered
	check_answers()
	get_tree().change_scene("res://Score.tscn")
	# Check Responses to Check
	# Update Score
	# change to final scene
	pass # Replace with function body.

func check_answers():
	GS.good_answer = 0
	for i in range(q_data.size()):
		print (q_data[i].CA, a_data[i])
		if (q_data[i].CA == a_data[i]):
				GS.good_answer = GS.good_answer + 1
		
	# global_script.total_question = q_data.size()
	GS.total_question = q_data.size()
	print ("Number of Question: ", GS.total_question)
	print ("Good Answer: ", GS.good_answer)
	#compare asnwer to value
	pass
	
	
func periodic_check():
	var my_node = get_node("Submit")
	while true:  # Infinite loop to continuously check the condition	
		# Check if all questions have been answered.
		condition_met = true
		for i in range(q_data.size()):
			if a_data[i] == "?":
				condition_met = false
		if condition_met:
		# Perform the desired action when the condition is met
			print("Condition is met!")
			my_node.disabled = false
			
		else:
			print("Condition is not met!")
	   
	# Add a delay of 2 seconds (adjust this value to your desired time interval)
		yield(get_tree().create_timer(2.0), "timeout")
