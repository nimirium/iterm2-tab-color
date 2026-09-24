# zsh plugin for setting iTerm2 tab colors and title overrides
#
# Originally by Andy Gimblett, 2017-2020 (https://github.com/gimbo/iterm2-tabs.zsh)
# Customized: single `iterm2-tab` entry point instead of five separate aliases.
#
# Usage:
#
#   iterm2-tab color rgb <r> <g> <b>
#   iterm2-tab color <name>
#   iterm2-tab color random-rgb
#   iterm2-tab color random
#   iterm2-tab text <text>
#
# All the colour-related commands are handled by a python script (in the same
# directory).
#
# The colors are taken from
# https://github.com/jacaetevha/finna-be-octo-hipster.
#
#
# Note that `iterm2_tab_title` (used by `iterm2-tab text`) simply sets a "tab
# title override" env var, and on its own won't actually affect the tab
# title. Making it change the visible tab title requires extra setup (an
# `iterm2_print_user_vars()` hook + an AutoLaunch script) not included here.


# We expect the python script to be in the same folder as the script
# you're reading now
#
_iterm2_tabs_py=${0:a:h}/iterm2_tabs.py


# Set tab color with r g b triple, e.g.
#
# $ iterm2_tab_color 127 45 98
#
iterm2_tab_color() {
    uv run $_iterm2_tabs_py --rgb $1 $2 $3
}


# Set tab color by name, e.g.
#
# $ iterm2_tab_color_named maroon
#
iterm2_tab_color_named() {
    uv run $_iterm2_tabs_py --color $1
}


# Set tab color to some random RGB value, and echo it, e.g.
#
# $ iterm2_tab_color_random
#
iterm2_tab_color_random() {
    uv run $_iterm2_tabs_py --random-color
}


# Set tab color to some random named color, and echo the name and RGB values,
# e.g.
#
# $ iterm2_tab_color_random_named
#
iterm2_tab_color_random_named() {
    uv run $_iterm2_tabs_py --random-named-color
}


# Set tab title override env var, e.g.
#
# $ iterm2_tab_title hello
# $ iterm2_tab_title Long titles OK
#
iterm2_tab_title () {
    export TAB_TITLE_OVERRIDE="$*"
}


# Single entry point dispatching to the functions above.
#
iterm2-tab() {
    case "$1" in
        color)
            shift
            case "$1" in
                rgb)
                    shift
                    iterm2_tab_color "$1" "$2" "$3"
                    ;;
                random-rgb)
                    iterm2_tab_color_random
                    ;;
                random)
                    iterm2_tab_color_random_named
                    ;;
                "")
                    echo "Usage: iterm2-tab color rgb <r> <g> <b> | iterm2-tab color <name> | iterm2-tab color random-rgb | iterm2-tab color random" >&2
                    return 1
                    ;;
                *)
                    iterm2_tab_color_named "$1"
                    ;;
            esac
            ;;
        text)
            shift
            iterm2_tab_title "$@"
            ;;
        *)
            echo "Usage: iterm2-tab color rgb <r> <g> <b> | iterm2-tab color <name> | iterm2-tab color random-rgb | iterm2-tab color random | iterm2-tab text <text>" >&2
            return 1
            ;;
    esac
}


# Tab completion for `iterm2-tab`
#
_iterm2_tab_completion() {
    local -a subcommands
    subcommands=('color:set tab color' 'text:set tab title override')
    if (( CURRENT == 2 )); then
        _describe 'command' subcommands
    elif (( CURRENT == 3 )) && [[ ${words[2]} == color ]]; then
        _values 'option' rgb random-rgb random $(uv run $_iterm2_tabs_py --list-colors)
    fi
}
compdef _iterm2_tab_completion iterm2-tab
