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
    screenshot                  = 'scrot -u "%Y-%m-%d-%H%M%S.png"',
    screenshot_and_edit         = 'scrot -u "%Y-%m-%d-%H%M%S.png" -e "gimp $f"',
}
return apps
