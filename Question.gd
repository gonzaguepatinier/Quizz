extends Node2D

const GlobalScript = preload("res://Global.gd")
# Assuming "GS" is configured as an Autoload singleton in your project settings.
# If not, use global_script or instantiate it appropriately.

var num = 0
var condition_met = false

var q_data = []
var a_data = []

var Old_data = [
	{
		 "Q": "What is the meaning of life?",
		"A": ["Life is good","Help!","There is Hope","What?"],
		"CA": 1
	 },
	{
		"Q": "What time is it?",
		"A": ["tiger time","Now?","where?","10:00"],
		"CA": 1
	},
	{
		"Q": "What language you speak?",
		"A": ["French","Russian","Italian","Alien"],
		"CA": 1
	},
	{
		"Q": "What car do you drive?",
		"A": ["Audi","BMW","Toyota","Honda"],
		"CA": 4
	},
	{
		"Q": "Where do you live?",
		"A": ["in space","Bangkok","New York","in a cave"],
		"CA": 2
	}
]  

func _writejson_old():
	var file = FileAccess.open("user://saved_game.sav", FileAccess.WRITE)
	if file == null:
		print("Error opening file: ", FileAccess.get_open_error())
		return

	file.store_line(JSON.stringify(q_data))
	# FileAccess closes automatically when it goes out of scope

func _writejson():
	var jsonStr = JSON.stringify(q_data)
	var file = FileAccess.open("user://user_data.json", FileAccess.WRITE)
	if file != null:
		file.store_string(jsonStr)
		print("Data exported to JSON successfully.")
	else:
		print("Failed to open file for writing: ", FileAccess.get_open_error())

func loadFromJson():
	var file = FileAccess.open(GS.quizz_file, FileAccess.READ)
	if file != null:
		var jsonStr = file.get_as_text()
		
		var json = JSON.new()
		var error = json.parse(jsonStr)
		if error == OK:
			var jsonData = json.get_data()
			q_data = jsonData
			if jsonData != null:
				processLoadedData(jsonData)
			else:
				print("Parsed JSON data is empty/null.")
		else:
			print("JSON Parse Error: ", json.get_error_message(), " in line ", json.get_error_line())
	else:
		print("Failed to open file for reading: ", FileAccess.get_open_error())
		
	for _i in range(q_data.size()):
		a_data.append("?")

func processLoadedData(data):
	print("Loaded data:", data)

func _loadquestion(value):
	var n = value
	
	var QN = get_node("QuestionNumber")
	var ANS = get_node("Answer")
	var COR_ANS = get_node("Correct_Answer")
	
	var MaxQString = str(q_data.size())
	var QNString = str(n + 1)
	
	var PB = get_node("ProgressBar")
	PB.min_value = 0
	PB.max_value = q_data.size()
	PB.step = 1
	PB.value = n + 1
	
	QN.text = QNString + "/" + MaxQString
	
	var QT = get_node("QuestionText")
	var NQ = q_data[n].Q
	QT.text = NQ

	var CA = str(q_data[n].CA)
	COR_ANS.text = CA
	
	ANS.text = a_data[n]
	
	var AT = get_node("ANSGRID/ANS A")
	AT.text = q_data[n].A[0]
	
	AT = get_node("ANSGRID/ANS B")
	AT.text = q_data[n].A[1]
	
	AT = get_node("ANSGRID/ANS C")
	AT.text = q_data[n].A[2]
	
	AT = get_node("ANSGRID/ANS D")
	AT.text = q_data[n].A[3]

func _ready():
	num = 0
	loadFromJson()
	periodic_check()
	_loadquestion(num)

func _on_Prev_Q_pressed():
	if (num > 0):
		num = num - 1
	_loadquestion(num)
		
func _on_Next_Q_pressed():
	num = num + 1
	if num == q_data.size():
		num = num - 1
	_loadquestion(num)

func _on_Save_pressed():
	_writejson()

func _on_ANS_A_pressed():
	a_data[num] = "A"
	get_node("Answer").text = a_data[num]

func _on_ANS_B_pressed():
	a_data[num] = "B"
	get_node("Answer").text = a_data[num]

func _on_ANS_C_pressed():
	a_data[num] = "C"
	get_node("Answer").text = a_data[num]

func _on_ANS_D_pressed():
	a_data[num] = "D"
	get_node("Answer").text = a_data[num]

func _on_Submit_pressed():
	check_answers()
	get_tree().change_scene_to_file("res://Score.tscn")

func check_answers():
	GS.good_answer = 0
	for i in range(q_data.size()):
		print(q_data[i].CA, a_data[i])
		# Note: Ensure data types match (int vs string comparison if CA is stored as an integer index vs letter)
		if (str(q_data[i].CA) == a_data[i]):
			GS.good_answer = GS.good_answer + 1
		
	GS.total_question = q_data.size()
	print("Number of Question: ", GS.total_question)
	print("Good Answer: ", GS.good_answer)

func periodic_check():
	var my_node = get_node("Submit")
	while true: 
		condition_met = true
		for i in range(q_data.size()):
			if a_data[i] == "?":
				condition_met = false
		if condition_met:
			print("Condition is met!")
			my_node.disabled = false
		else:
			print("Condition is not met!")
	   
		await get_tree().create_timer(2.0).timeout
