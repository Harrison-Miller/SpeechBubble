extends Node2D

onready var text_node = $Anchor/RichTextLabel
onready var text_bg = $Anchor/ColorRect

const char_time = 0.02
const margin_offset = 8

func _ready() -> void:
	visible = false
	set_text("Hello, [color=red]world[/color]")

func set_text(text, wait_time = 3):
	visible = true

	$Timer.wait_time = wait_time
	$Timer.stop()
	
	text_node.bbcode_text = text
	
	# Duration
	var duration = text_node.text.length() * char_time
	
	# Set the size of the speech bubble
	var text_size = text_node.get_font("normal_font").get_string_size(text_node.text)
	text_node.margin_right = text_size.x + margin_offset
	
	# Animation
	$Tween.remove_all()
	$Tween.interpolate_property(text_node, "percent_visible", 0, 1, duration)
	$Tween.interpolate_property(text_bg, "margin_right", 0, text_size.x + margin_offset, duration)
	$Tween.interpolate_property($Anchor, "position", Vector2.ZERO, Vector2(-text_size.x/2, 0), duration)
	$Tween.start()

func _on_Tween_tween_all_completed() -> void:
	$Timer.start()

func _on_Timer_timeout() -> void:
	visible = false
