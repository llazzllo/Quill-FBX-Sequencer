@tool
extends EditorPlugin

var panel
const QUILL_FBX_CONVERTER = preload("res://addons/quillfbxconverter/quill_fbx_converter.tscn")

func _enter_tree() -> void:
	panel = QUILL_FBX_CONVERTER.instantiate()
	
	
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_BR, panel)

func _exit_tree() -> void:
	remove_control_from_docks(panel)
	
	panel.queue_free()
