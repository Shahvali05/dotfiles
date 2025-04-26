from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.widget import Volume
from libqtile.widget import Wlan
from libqtile.widget import Battery
from libqtile import hook
from subprocess import Popen, check_output
from pulsectl import Pulse
from os import path
import subprocess
from libqtile.config import Match

home = path.expanduser("~")
qconf = home + "/.config/qtile/"
getlayout = qconf + "getlayout.sh"
# get_microphone_icon = qconf + "microfon.sh"

autostart_sh = "/home/shahvali/.config/qtile/autostart.sh"

mod = "mod4"
terminal = guess_terminal()


@hook.subscribe.startup_once
def autostart():
    Popen([autostart_sh])


# Custom keyboard widget
class KbWidget(widget.TextBox):
    def update_self(self):
        layout = check_output([getlayout]).decode().strip()
        self.text = str(layout)
        self.draw()

    def __init__(self, **config):
        super().__init__("", **config)
        self.update_self()


kbl = KbWidget()

# class MicrophoneWidget(widget.TextBox):
#
#    def update_self(self):
#        microphone_icon = check_output([get_microphone_icon]).decode().strip()
#        self.text = str(microphone_icon)
#        self.draw()
#
#    def __init__(self, **config):
#        super().__init__("", **config)
#        self.update_self()
# microphone_widget = MicrophoneWidget(),

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    # Key([mod], "a", lazy.layout.maximize(), desc="Maximize window"),
    # Key([mod], "s", lazy.spawn("kitty discordo")),
    Key([mod], "a", lazy.spawn("kitty ranger")),
    Key([mod], "p", lazy.spawn("mocp -G")),
    Key([mod], "t", lazy.spawn("telegram-desktop")),
    Key([mod], "Return", lazy.spawn("kitty")),
    Key(
        [mod],
        "m",
        lazy.spawn(
            'rofi -show drun -theme solarized -font "hack 15" -show combi -icon-theme "Papirus" -show-icons'
        ),
    ),
    # Скриншот
    Key([], "Print", lazy.spawn("flameshot gui")),
    # Увеличение яркости
    Key(
        [],
        "ISO_Next_Group",
        lazy.function(lambda q: q.current_screen.top.widgets[kbindex].update_self()),
        desc="Next keyboard layout.",
    ),
    # Key([], "XF86AudioMicMute", lazy.spawn("amixer set Capture toggle"), desc="Toggle Microphone",),
    Key(
        [], "XF86MonBrightnessUp", lazy.spawn("light -A 10")
    ),  # Измените "10" на ваш шаг
    # Уменьшение яркости
    Key(
        [], "XF86MonBrightnessDown", lazy.spawn("light -U 10")
    ),  # Измените "10" на ваш шаг
    Key([mod], "f", lazy.spawn("firefox")),
    Key([mod, "control"], "b", lazy.hide_show_bar()),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q set Master 5%+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set Master 5%-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    # Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

## МАКЕТЫ (в скобках прописываются параметры, толщина бордера, цвета...) -----------
layouts = [
    # layout.Columns(),
    # layout.Max(), # Фуллскрин
    # layout.Stack(num_stacks=2), #Какая то фигня
    layout.Bsp(
        border_focus="#FF0000", border_normal="#263238", border_width=1, margin=10
    ),  # Как в bspwm
    # layout.Matrix(), # В 2 колонки
    # layout.MonadTall(border_focus = "#FF0000", border_normal = "#263238", border_width=1, margin = 10), # Как в dwm
    # layout.MonadWide(border_focus = "#FF0000", border_normal = "#263238", border_width=1, margin = 10), # Как в dwm только по горизонтали
    # layout.RatioTile(border_focus = "#FF0000", border_normal = "#263238", border_width=1, margin = 10), # Окна мазайкой 3х3, 4х4 ...
    # layout.Tile(), # Как в dwm
    # layout.TreeTab(), # Вертикальный монокль с заголовками
    # layout.VerticalTile(), # Окна открываются вертикально
    # layout.Zoomy(), # Как в dwm ток мастер окно большое
]

colors = [
    "#000000",  # Фоновый цвет
    "#ffffff",  # Цвет текста
]

# widget_defaults = dict(
#    font="sans",
#    fontsize=12,
#    padding=3,
# )

# extension_defaults = widget_defaults.copy()

wlan = Wlan(interface="wlp4s0", format="🌐 {essid}")
battery = Battery(
    battery="BAT1",  # Укажите имя вашей батареи (обычно "BAT0" или "BAT1")
    format="{percent:2.0%}",
)

brightness_widget = widget.Backlight(
    backlight_name="amdgpu_bl1",
    step=1,  # Шаг изменения яркости
    max_brightness_file="/sys/class/backlight/amdgpu_bl1/max_brightness",
)

## ОБЩИЕ ПАРАМЕТРЫ ВИДЖЕТОВ НА ПАНЕЛИ ----------------------------------------------
widget_defaults = dict(
    font="JetBrainsMono",
    fontsize=12,
    padding=8,
)

extension_defaults = widget_defaults.copy()


def open_firefox():
    # Замените "firefox" на команду, которой вы обычно запускаете Firefox на вашей системе
    lazy.spawn("bash ./rofi-wifi-menu.sh")


screens = [
    Screen(
        top=bar.Bar(
            [
                # widget.CurrentLayout(),
                # widget.TextBox( text="Py", foreground="#ff0000",),
                widget.TextBox(
                    text="Py",  # Ваш символ
                    fontsize=18,  # Размер шрифта
                    padding=5,  # Отступы
                    # background="FF0000",    # Цвет фона (красный)
                    foreground="9400D3",  # Цвет символа (белый)
                ),
                widget.GroupBox(
                    highlight_method="block",
                    borderwidth=4,
                    this_current_screen_border="#f9f9f9",  # Цвет фона активного воркспейса
                    inactive="#505050",
                    block_highlight_text_color="#263238",  # Цвет текста активного воркспейса
                    rounded=True,
                ),
                widget.Prompt(),
                widget.WindowName(max_chars=30),  # Имя окна
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Systray(),
                widget.TextBox(
                    text="|",
                    foreground="#ff0000",
                ),
                widget.Clock(format="🗓️ %Y-%m-%d %a"),
                widget.TextBox(
                    text="|",
                    foreground="#ff0000",
                ),
                kbl,
                widget.TextBox(
                    text="|",
                    foreground="#ff0000",
                ),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Clock(format="🕒 %H:%M"),
                widget.TextBox(
                    text="|",
                    foreground="#ff0000",
                ),
                widget.TextBox("💡", name="default"),
                brightness_widget,
                widget.TextBox(
                    text="|",
                    foreground="#ff0000",
                ),
                widget.TextBox("🔊", name="default"),
                widget.Volume(),
                widget.TextBox(
                    text="|",
                    foreground="#ff0000",
                ),
                # microphone_widget,
                # widget.TextBox( text="  |  ", foreground="#ff0000",),
                wlan,
                widget.TextBox(
                    text="|",
                    foreground="#ff0000",
                ),
                widget.TextBox("🔋", name="default"),
                battery,
                widget.TextBox(
                    text="|",
                    foreground="#ff0000",
                ),
                widget.QuickExit(
                    default_text="",
                    foreground="#00FF00",
                ),  # Кнопка выключения
            ],
            25,
            # темносиний фон
            border_width=[5, 0, 5, 0],  # Толщина рамок панели
            border_color=["263238", "263238", "263238", "263238"],  # Цвет рамок панели
            margin=5,  # Гапсы бара
            background="#263238",  # Цвет фона панели
            foreground="#FF0000",  # красный текст
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magen
            opacity=0.8,
        ),
    ),
]

kbindex = next(
    (index for index, obj in enumerate(screens[0].top.widgets) if obj == kbl), None
)
# mkindex = next((index for index, obj in enumerate(screens[0].top.widgets) if obj == microphone_widget), None)

# Drag floating layouts.
mouse = [
    #    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    #    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    #    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = True
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
