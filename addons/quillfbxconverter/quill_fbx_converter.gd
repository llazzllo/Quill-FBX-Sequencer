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
			
			var last_frame = int(str(kids[kids.size() - 1].name))
			
			var anim = Animation.new()
			var anim_lib = AnimationLibrary.new()
			var frame_rate = 0.0417
			var frame_step = int(str(kids[1].name))
			var anim_length = (last_frame + frame_step) * frame_rate 
			
			
			
			player.add_animation_library(str(""), anim_lib)
			#printt("Library Added", anim_name)
			
			anim_lib.add_animation(str(anim_name), anim)
			#printt("Animation Added", anim_name, anim)
			
			anim.step = 0.0417
			anim.length = anim_length 
			
			var index = 0
			
			for frame in kids:
				var frame_num = int(str(frame.name))
				#var next_frame = int(str(kids[index + 1].name))
				#if index < kids.size() - 1:
					#print(next_frame)
				#print(frame_num)
				var time = frame_num * frame_rate
				anim.add_track(Animation.TYPE_VALUE)
				#print("Track Added")
				anim.track_set_interpolation_type(index, Animation.INTERPOLATION_NEAREST)
				#print("Set Interpolation")
				anim.track_set_path(index, "./" + str(kids[index].name) + ":visible")
				#print("./" + str(kids[index].name) + ":visible")
				#printt("Path Set", index, "./" + kids[frame_num].name + ":visible")
				anim.track_insert_key(index, frame_num * frame_rate, 1)
				#printt("Key Inserted", index, frame_num * frame_rate, 1)
				
				if frame_num > 0:
					anim.track_insert_key(index, 0, 0)
					anim.track_insert_key(index, (frame_num - 1) * frame_rate, 0)
					
				if index != kids.size() - 1: 
					var next_frame = int(str(kids[index + 1].name))
					anim.track_insert_key(index, (next_frame) * frame_rate, 0)
				
				index += 1
			


##()()()## BACKUP CODE---------------------------------------------

##()()()##---------------------------------------------------------
