from libqtile import bar, layout, widget
from libqtile.config import Group, Key, Screen
from libqtile.lazy import lazy
from libqtile.backend.wayland import InputConfig

mod = "mod4"  # Super key

# Keybindings
keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Launch terminal
    Key([mod], "Return", lazy.spawn("alacritty"), desc="Launch terminal"),
    # Reload config
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    # Quit Qtile
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
]

# Groups
groups = [Group(i) for i in "123456789"]

# Layouts
layouts = [
    layout.Columns(border_focus="#d75f5f", border_width=2),
    layout.Max(),
]

# Input configuration for Wayland
wl_input_rules = {
    "type:keyboard": InputConfig(kb_layout="us", kb_variant=""),
    "type:pointer": InputConfig(left_handed=False, pointer_accel=0.0),
}

# Bar (using Waybar as an alternative is recommended)
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.WindowName(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
            ],
            24,
        ),
    ),
]

# Backend-specific settings
from libqtile import qtile

if qtile.core.name == "wayland":
    terminal = "foot"  # Wayland-compatible terminal
else:
    terminal = "xterm"  # Fallback for X11
