source ~/.promptlinex.sh
source ~/.config/zsh_include # API keys and sensitive info

# opam configuration OCaml
test -r /Users/andyclark1/.opam/opam-init/init.zsh && . /Users/andyclark1/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
# autocompletions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

autoload -Uz compinit
compinit
fi

PATH="/usr/local/opt/python@3.8/bin:$PATH"
PATH=$PATH:$HOME/.npm-global/bin

## make prompt cleaner
PROMPT='%~ %# '
RPROMPT='%*'
ZLE_RPTOMPT_INDENT=0

CASE_SENSITIVE="false"

## prompt history 
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
setopt EXTENDED_HISTORY
SAVEHIST=500
HISTSIZE=200
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

# alias for useful things
alias python="python3"
alias py="python3"
alias youtube-dl="yt-dlp"
alias lf="ranger"
alias pip="pip3"
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
alias df='df -h'
alias free='free -mh'
alias gitu='git add . && git commit && git push'
alias vim="nvim"
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias finder='open'
alias dotfiles='git --git-dir=/Users/andyclark1/.dotfiles/.git --work-tree=/'
alias dtig='tig /Users/andyclark1/.dotfiles --GIT-WORK-TREE=/'
alias stock='tstock'
alias ppjson='python3 -m json.tool | pygmentize -l JSON -P style=gruvbox-dark'
alias pytest='python3 -m doctest'
alias gpgverify='gpg --digest-algo SHA256 --verify' # <$1.asc> <$2.dmg>
alias gpgget='gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys'
alias gpgsign='gpg --lsign-key'
alias gtags='ctags -R -f ./.git/tags .'
alias jnotebook='jupyter lab --app-dir /opt/homebrew/share/jupyter/lab'
alias fixvpn='sudo launchctl load /Library/LaunchDaemons/com.cisco.secureclient.vpnagentd.plist'


# alias gcc="gcc -Wall -Wextra -Werror -Wshadow -Wconversion -v -g -O2 --std=c99 "

# meson ninja PATH 
export PATH=$PATH:/Users/andyclark1/Library/Python/3.8/bin

# dev: exa is unmaintained and doesn't work with homebrew anymore, can use eza instead
# Remap ls to exa for color in filetype 
# alias ls='exa -al --color=always --group-directories-first' # my preferred listing
# alias la='exa -a --color=always --group-directories-first'  # all files and dirs
# alias ll='exa -l --color=always --group-directories-first'  # long format
# alias lt='exa -aT --color=always --group-directories-first' # tree listing
# alias l.='exa -a | egrep "^\."'

alias ls="lsd -la"
alias l='lsd -l'
alias ln="lsd"
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'

## substituted out in favor of promptline.vim ('/edkolev/promptline.vim')
## make prompt cleaner
## git status right prompt
#autoload -Uz vcs_info
#precmd_vcs_info() { vcs_info }
#precmd_functions+=( precmd_vcs_info )
#setopt prompt_subst
#RPROMPT=\$vcs_info_msg_0_
#zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
#zstyle ':vcs_info:*' enable git

setopt correct           # Auto correct mistakes
setopt extendedglob      # Extended globbing. Allows using regular expressions with *
setopt nocaseglob        # Case insensitive globbing
setopt rcexpandparam     # Array expension with parameters
setopt nocheckjobs       # Don't warn about running processes when exiting
setopt numericglobsort   # Sort filenames numerically when it makes sense
setopt nobeep            # No beep
setopt appendhistory     # Immediately append history instead of overwriting
setopt histignorealldups # If a new command is a duplicate, remove the older one
setopt autocd            # if only directory path is entered, cd there.
setopt inc_append_history  # save commands are added to the history immediately, otherwise only when shell exits

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"   # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true   # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache.

bindkey '^H' backward-kill-word  # delete previous word with ctrl+backspace
bindkey '^[[Z' undo              # Shift+tab undo last action

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/andyclark1/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

### Zinit
source "$HOME/.zinit//zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

zinit ice wait lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/colorize/colorize.plugin.zsh
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
zinit snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zinit snippet OMZ::plugins/golang/golang.plugin.zsh
zinit snippet OMZ::plugins/archlinux/archlinux.plugin.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh
zinit snippet OMZ::plugins/jsontools/jsontools.plugin.zsh
zinit snippet OMZ::plugins/rand-quote/rand-quote.plugin.zsh
zinit light zsh-users/zsh-completions
# zinit light marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/history-search-multi-word
zinit light zdharma-continuum/fast-syntax-highlighting
# zinit light softmoth/zsh-vim-mode

alias ssh="kitty +kitten ssh"

# bun completions
[ -s "/Users/andyclark1/.bun/_bun" ] && source "/Users/andyclark1/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# use homebrew bison
export PATH="$(brew --prefix bison)/bin:$PATH"

# llvm
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# gpg
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# History
bindkey "^R" history-search-multi-word
# MODE_INDICATOR_VIINS='%F{15}<%F{8}INSERT<%f'
# MODE_INDICATOR_VICMD='%F{10}<%F{2}NORMAL<%f'
# MODE_INDICATOR_REPLACE='%F{9}<%F{1}REPLACE<%f'
# MODE_INDICATOR_SEARCH='%F{13}<%F{5}SEARCH<%f'
# MODE_INDICATOR_VISUAL='%F{12}<%F{4}VISUAL<%f'
# MODE_INDICATOR_VLINE='%F{12}<%F{4}V-LINE<%f'
# bindkey ^R history-incremental-search-backward 
# bindkey ^S history-incremental-search-forward

# notes
# use ctrl + R to view recent commands
#
