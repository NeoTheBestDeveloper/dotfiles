from os import environ, popen, system
from subprocess import run

from libqtile import bar, hook, qtile
from libqtile.widget import GroupBox, Clock, CheckUpdates, TextBox, \
                            Volume,  Spacer, Mpd2, WindowName, GenPollText, Backlight
from libqtile.layout import Floating, MonadTall
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.command import lazy

# Main constants
mod = 'mod4'
terminal = environ.get('TERMINAL', 'st')
browser = environ.get('BROWSER', 'qutebrowser')


# Hooks
@hook.subscribe.client_new
def disable_floating(window):
    rules = [Match(wm_class="mpv")]

    if any(window.match(rule) for rule in rules):
        window.togroup(qtile.current_group.name)
        window.cmd_disable_floating()


def get_radio_state() -> str:
    return popen('radio state').read().replace('\n', '')


def get_battery_status() -> str:
    return popen('status_battery').read().replace('\n', '')


def get_volume_status() -> str:
    return popen('status_volume').read().replace('\n', '')


def toggle_playlist() -> None:
    system('toggle_playlist')


desktops = {
    '': [Match()],
    '': [Match(wm_class=['qutebrowser'])],
    '': [Match()],
    '': [Match(wm_class=['Chromium', 'Navigator'])],
    'ﴬ': [Match(wm_class=['obsidian'])],
    '': [Match(wm_class=['TelegramDesktop'])],
    'ﱘ': [Match(wm_class=['discord'])],
    '': [Match(wm_class=['virt-manager'])],
}
groups = [Group(d, matches=desktops.get(d)) for d in desktops]

# Nord theme colors.
colors = {
    'nord0': '#2E3440',
    'nord1': '#3B4252',
    'nord2': '#434C5E',
    'nord3': '#4C566A',
    'nord4': '#D8DEE9',
    'nord5': '#E5E9F0',
    'nord6': '#ECEFF4',
    'nord7': '#8FBCBB',
    'nord8': '#88C0D0',
    'nord9': '#81A1C1',
    'nord10': '#5E81AC',
    'nord11': '#BF616A',
    'nord12': '#D08770',
    'nord13': '#EBCB8B',
    'nord14': '#A3BE8C',
    'nord15': '#B48EAD',
}

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        'Button1',
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag([mod],
         'Button3',
         lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], 'Button2', lazy.window.bring_to_front()),
]

floating_layout = Floating(
    float_rules=[
        *Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(wm_class='Pinentry-gtk-2'),  # GPG key password entry
        Match(wm_class='Blueman-manager'),
        Match(wm_class='Thunar'),
    ],
    border_focus=colors['nord3'],
    border_normal=colors['nord1'],
)

layouts = [
    MonadTall(
        new_client_position='top',
        fontsize=10,
        margin=20,
        border_width=3,
        ratio=0.55,
        border_focus=colors['nord3'],
        border_normal=colors['nord1'],
    ),
]

widget_defaults = dict(
    font='Fira Code Retina Nerd Font Complete Mono',
    fontsize=25,
    padding=5,
)

extension_defaults = widget_defaults.copy()


def init_widgets_list() -> list:
    """Create a widget list."""
    return [
        Spacer(15),
        GroupBox(
            highlight_method='block',
            disable_drag=True,
            highlight_color=colors['nord11'],
            urgent_alert_method='block',
            urgent_border=colors['nord11'],
        ),
        WindowName(max_chars=150),
        TextBox(text='玲',
                width=25,
                font='Fira Code Nerd Font Mono',
                mouse_callbacks={'Button1': lazy.spawn('mpc prev')}),
        Mpd2(status_format='{play_status} {title}',
             play_states={
                 'pause': '▶',
                 'play': ' ',
                 'stop': '■'
             },
             padding=10,
             mouse_callbacks={'Button2': toggle_playlist}),
        TextBox(text='怜',
                width=25,
                font='Fira Code Nerd Font Mono',
                mouse_callbacks={'Button1': lazy.spawn('mpc next')}),
        Spacer(),
        TextBox(
            text='📻',
            fontsize=25,
            font='Fira Code Nerd Font Mono',
            foreground=colors['nord13'],
            mouse_callbacks={
                'Button1': lazy.spawn('radio toggle'),
                'Button3': lazy.spawn('radio stop'),
                'Button5': lazy.spawn('radio prev'),
                'Button4': lazy.spawn('radio next'),
            },
        ),
        GenPollText(
            update_interval=1,
            func=get_radio_state,
            font='Fira Code Nerd Font Mono',
            foreground=colors['nord13'],
            mouse_callbacks={
                'Button1': lazy.spawn('radio toggle'),
                'Button3': lazy.spawn('radio stop'),
                'Button5': lazy.spawn('radio prev'),
                'Button4': lazy.spawn('radio next'),
            },
        ),
        Spacer(15),
        Clock(
            format='  %b %d %a %I:%M',
            foreground=colors['nord10'],
        ),
        Spacer(15),
        Backlight(
            backlight_name='amdgpu_bl0',
            change_command='brightnessctl set {0}%',
            step=5,
            fmt=' {}',
            update_interval=0.2,
            foreground=colors['nord7'],
        ),
        Spacer(15),
        GenPollText(
            func=get_volume_status,
            update_interval=0.2,
            foreground=colors['nord14'],
        ),
        Spacer(15),
        GenPollText(
            func=get_battery_status,
            update_interval=60,
            foreground=colors['nord14'],
        ),
        Spacer(15),
    ]


def init_screens():
    """Create screens list."""
    return [
        Screen(top=bar.Bar(
            widgets=init_widgets_list(),
            size=50,
            margin=[15, 25, 15, 15],
            background=colors['nord0'],
        ))
    ]


# Some options.
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

auto_fullscreen = True
focus_on_window_activation = 'smart'
reconfigure_screens = True
auto_minimize = True
wmname = 'LG3D'

keys = [
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod], "i", lazy.layout.grow()),
    Key([mod], "m", lazy.layout.shrink()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "o", lazy.layout.maximize()),
    Key([mod, "shift"], "space", lazy.layout.flip()),  # Window managment
    Key([mod], 'q', lazy.window.kill()),
    Key([mod, 'shift'], 'q', lazy.reload_config()),
    Key([mod], 'f', lazy.window.toggle_fullscreen()),
    Key([mod], 'p', lazy.spawn('dmenu_run')),
    Key([mod, 'shift'], 'f', lazy.window.toggle_floating()),
    Key([mod], 'Return', lazy.spawn(terminal)),
]

for index, group in enumerate(groups):
    keys.extend([
        Key([mod], str(index + 1), lazy.group[group.name].toscreen()),
        Key([mod, 'shift'], str(index + 1), lazy.window.togroup(group.name)),
    ])

if __name__ in ['__main__', 'config']:
    screens = init_screens()
