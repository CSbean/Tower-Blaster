extends Control


@onready var sprint_t: Label = $MarginContainer/VBoxContainer/sprintT
@onready var health: Label = $MarginContainer/VBoxContainer/health
@onready var time: Label = $time
@onready var timer: Timer = $Timer
@onready var score_label: Label = $MarginContainer/scoreLabel
@onready var victory: CenterContainer = $victory
@onready var label_2: Label = $Label2



signal timeOut

var ST = false
var win = false
var loss = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	time.text = format_time(timer.time_left)
	if win:
		sprint_t.visible = false
		health.visible = false
		time.visible = false
		score_label.visible = false
		victory.visible = true
		label_2.visible = true
	if loss:
		pass
	

func update_health(num)->void:
	health.text = str(num)

func sprint_toggle()-> void:
	if ST == false:
		ST = true
		sprint_t.text = "Sprint:<toggled>"
	elif ST == true:
		ST = false
		sprint_t.text = "Sprint: off"

func format_time(total_seconds: float) -> String:
	var minutes: int = int(total_seconds) / 60
	var seconds: int = int(total_seconds) % 60
	return "%02d:%02d" % [minutes, seconds]
	
func update_score(num: int)->void:
	score_label.text = "Score:" + str(num)
	label_2.text = "Score:" + str(num)

func _on_timer_timeout() -> void:
	timeOut.emit()
