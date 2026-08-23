extends Control

@onready var content: MarginContainer = %MarginContainer
@onready var fps_label: Label = %FpsLabel
@onready var project_name: Label = %ProjectName


func _ready() -> void:
	if not OS.is_debug_build():
		queue_free()
		return

	project_name.text = ProjectSettings.get_setting("application/config/name", "")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_debug"):
		content.visible = not content.visible
		get_viewport().set_input_as_handled()


func _process(_delta: float) -> void:
	if not content.visible:
		return

	fps_label.set_text("FPS: " + str(Engine.get_frames_per_second()))
