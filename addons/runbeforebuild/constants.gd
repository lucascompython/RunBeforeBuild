# IMPORTANT: When changing this values, you need to disable and re-enable the plugin or restart Godot

## Command to execute when building for debug
const DEBUG_CMD := "cargo build"
## Command to execute when exporting
const RELEASE_CMD := "cargo build --release"
## The working directory for running the commands
const CWD := "./rust"

static func get_shell() -> String:
	var os := OS.get_name()
	var shell: String
	
	match os:
		"Windows", "UWP":
			shell = "powershell"
		"Linux", "FreeBSD", "NetBSD", "OpenBSD", "BSD", "macOS":
			shell = "bash"
		_:
			shell = "N/A" # basically don't support mobile
	return shell