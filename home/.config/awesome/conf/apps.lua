-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

local apps = {
    editor                      = editor,
    editor_cmd                  = terminal .. " -e " .. editor,
    terminal                    = terminal,

    midnightcommander           = terminal .. " -e mc ",
    ncmpcpp                     = terminal .. " -e ncmpcpp ",
}
return apps
