@tool
extends EditorPlugin

var EXPORT_PLUGIN := preload("res://addons/runbeforebuild/run_before_export.gd").new()
const CONSTANTS := preload("res://addons/runbeforebuild/constants.gd")

func _enter_tree() -> void:
	add_export_plugin(EXPORT_PLUGIN)
	
func _build() -> bool:
	var shell := CONSTANTS.get_shell()
	
	print("[RunBeforeBuild] Executing '%s'..."  % CONSTANTS.DEBUG_CMD)
	
	if shell == "N/A":
		print("[RunBeforeBuild] ERROR: Current operating system is not supported...")
		return false
		
	var output := []
	var exit_code := OS.execute(shell, ["-c", "cd %s && %s" % [CONSTANTS.CWD, CONSTANTS.DEBUG_CMD]], output)
	
	if output[0]:
		print("[RunBeforeBuild] OUTPUT: ", output)
	
	if exit_code == 0:
		print("[RunBeforeBuild] Successfully executed '%s'!" % CONSTANTS.DEBUG_CMD)
		return true

	print("[RunBeforeBuild] ERROR: Something went wrong when executing: '%s'" % CONSTANTS.DEBUG_CMD)	
	return false

func _exit_tree() -> void:
	remove_export_plugin(EXPORT_PLUGIN)