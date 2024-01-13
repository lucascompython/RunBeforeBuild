@tool
extends EditorExportPlugin

const CONSTANTS := preload("res://addons/runbeforebuild/constants.gd")

func _export_begin(_features: PackedStringArray, is_debug: bool, _path: String, _flags: int) -> void:
	var shell := CONSTANTS.get_shell()
	var cmd := CONSTANTS.DEBUG_CMD if is_debug else CONSTANTS.RELEASE_CMD
	
	print("[RunBeforeBuild] Executing '%s'..."  % cmd)
	if shell == "N/A":
		print("[RunBeforeBuild] ERROR: Current operating system is not supported...")
		return
	
	var output := []
	var exit_code := OS.execute(shell, ["-c", "cd %s && %s" % [CONSTANTS.CWD, cmd]], output)
	
	if output[0]:
		print("[RunBeforeBuild] OUTPUT: ", output)
	
	if exit_code != 0:
		print("[RunBeforeBuild] ERROR: Something went wrong when executing: '%s'" % cmd)	
	else:
		print("[RunBeforeBuild] Successfully executed '%s'!" % cmd)

func _get_name() -> String: # get rid of error
	return "RunBeforeExport"
