### Exports ###
HISTFILE=~/.cache/zsh/histfile
HISTSIZE=1000000
SAVEHIST=1000000

### Functions ### 
source $ZDOTDIR/functions.zsh

### Options ###
unsetopt BEEP
setopt appendhistory autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef	
zle_highlight=('paste:none')
_comp_options+=(globdots)


### Completions ###
fpath+=$ZDOTDIR/.zfunc # poetry completions
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)


### Prompt ###
autoload -U promptinit && promptinit

### Colors ###
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

### Key-bindings ###
bindkey -s '^s' 'ncdu --color=dark / ^M'
bindkey -s '^f' 'fzf^M'
bindkey -s '^a' 'tmux^M'
bindkey -s '^h' 'htop^M'
bindkey -s '^p' 'ncmpcpp^M'
bindkey -s '^o' 'ranger^M'
bindkey '^k' up-line-or-beginning-search # Up
bindkey '^j' down-line-or-beginning-search # Down


### Vi mode ###
bindkey -v
export KEYTIMEOUT=1


### Vim keys in complete mode. ### 
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char


### Edit line mode ###
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search


# Edit line in vim with ctrl-e ###
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


### Shell setup. ###
[ -f "$HOME/.config/shell/shortcutrc" ] && source "$HOME/.config/shell/shortcutrc"
[ -f "$HOME/.config/shell/aliasrc" ] && source "$HOME/.config/shell/aliasrc"


### Plugins ###
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-command-not-found/command-not-found.plugin.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $ZDOTDIR/plugins/completion.zsh
source $ZDOTDIR/plugins/key-bindings.zsh

# The next line updates PATH for CLI.
if [ -f '/home/neo/yandex-cloud/path.bash.inc' ]; then source '/home/neo/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/home/neo/yandex-cloud/completion.zsh.inc' ]; then source '/home/neo/yandex-cloud/completion.zsh.inc'; fi
### Some other commands. ###
eval "$(zoxide init zsh)"
