# iterm2-tab

A zsh plugin for setting iTerm2 tab colors, with a single `iterm2-tab`
command instead of a handful of separate aliases.

Fork of [gimbo/iterm2-tabs.zsh](https://github.com/gimbo/iterm2-tabs.zsh) by
Andy Gimblett.

## Installation

Requires [oh-my-zsh](https://ohmyz.sh/) and [uv](https://docs.astral.sh/uv/).

```zsh
git clone git@github.com:nimirium/iterm2-tabs.zsh.git "$ZSH_CUSTOM/plugins/iterm2-tab"
```

Then add this line to `~/.zshrc`, after `source $ZSH/oh-my-zsh.sh`:

```zsh
source "$ZSH_CUSTOM/plugins/iterm2-tab/iterm2-tabs.zsh"
```

Reload your shell (`source ~/.zshrc`, or open a new tab).

## Usage

```zsh
iterm2-tab color rgb <r> <g> <b>   # set tab color to an RGB triple
iterm2-tab color <name>            # set tab color by name
iterm2-tab color random-rgb        # set tab color to a random RGB value
iterm2-tab color random            # set tab color to a random named color
```

Tab completion is available: `iterm2-tab <TAB>` lists subcommands, and
`iterm2-tab color <TAB>` lists `rgb`, `random-rgb`, `random`, plus every
available color name.

Colors may be set either as RGB triples or as named colors, where the list
of color names (from
[jacaetevha/finna-be-octo-hipster](https://github.com/jacaetevha/finna-be-octo-hipster))
is hard-coded but accessible via tab completion.

* `uv run iterm2_tabs.py --show-colors` shows the list of available color
  names, along with a demo of each color
* `uv run iterm2_tabs.py --list-colors` just shows the names; this is what
  tab completion uses

Most of the color-related work is done by
[a python script](iterm2_tabs.py).

## Credits

Original plugin (`iterm2_tab_color`, `iterm2_tab_color_named`,
`iterm2_tab_color_random`, `iterm2_tab_color_random_named`, and the
underlying [python script](iterm2_tabs.py)) by Andy Gimblett,
<andy@barefootcode.com>, 2017-2024.
