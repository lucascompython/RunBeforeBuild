# IMPORTANT: When changing this values, you need to disable and re-enable the plugin or restart Godot

## Command to execute when building for debug
const DEBUG_CMD := "cargo build"
## Command to execute when exporting
const RELEASE_CMD := "cargo build --release"
## The working directory for running the commands
const CWD := "./rust"

static func get_shell() -> String:
	match OS.get_name():
		"Windows", "UWP":
			return "powershell"
		"Linux", "FreeBSD", "NetBSD", "OpenBSD", "BSD", "macOS":
			return "bash"
		_:
			return "N/A" # basically don't support mobile