@tool
extends VBoxContainer


func _on_convert_button_pressed() -> void:
	
	
	var selection = EditorInterface.get_selection()
	
	for node in selection.get_selected_nodes():
		if node is Node3D:
			var anim_name = node.name
			var kids = node.get_children()
			
			var player = AnimationPlayer.new()
			node.add_child(player)
			player.name = "SequencedFBX"
			player.owner = get_tree().edited_scene_root
			
			var anim = Animation.new()
			var anim_lib = AnimationLibrary.new()
			var frame_rate = 0.0417
			var frame_step = int(str(kids[1].name))
			var anim_length = (kids.size() - 1 + frame_step) * frame_rate 
			
			player.add_animation_library(str(anim_name), anim_lib)
			
			anim_lib.add_animation(str(anim_name), anim)
			
			anim.step = 0.0417
			anim.length = anim_length 
			
			for frame in kids:
				var frame_num = int(str(frame.name))
				var time = frame_num * frame_rate
				anim.add_track(Animation.TYPE_VALUE)
				anim.track_set_interpolation_type(frame_num, Animation.INTERPOLATION_NEAREST)
				anim.track_set_path(frame_num, "./" + kids[frame_num].name + ":visible")
				anim.track_insert_key(frame_num, frame_num * frame_rate, 1)
				
				if frame_num > 0:
					anim.track_insert_key(frame_num, 0, 0)
					anim.track_insert_key(frame_num, (frame_num - 1) * frame_rate, 0)
					
				if frame_num != kids.size() - 1: 
					anim.track_insert_key(frame_num, (frame_num + frame_step) * frame_rate, 0)
			
