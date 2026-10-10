source ~/.promptlinex.sh

# opam configuration OCaml
test -r /Users/andyclark1/.opam/opam-init/init.zsh && . /Users/andyclark1/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
# autocompletions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

autoload -Uz compinit
compinit
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

## make prompt cleaner
ZLE_RPTOMPT_INDENT=0

CASE_SENSITIVE="false"

## prompt history 
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
setopt EXTENDED_HISTORY
SAVEHIST=10000
HISTSIZE=10000
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
alias vimdiff='nvim -d'
alias git unreset='git reset 'HEAD@{1}''
alias s="kitty +kitten ssh"
alias exportenv='set -o allexport && source .env && set +o allexport'
alias cat="bat"
alias fzf="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias neofetch="neofetch --ascii ~/Downloads/ascii-art.txt"
alias sshwebsite="ssh -i /Users/clara4/.ssh/personal_id_ed25519 'root@45.63.18.7'"

git-retag() {
  git tag "$1" "$1^{}" -f -a
}

alias retag='git-retag'

# kitty ssh fix
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="TERM=xterm-256color ssh"

# Colorize manpages
export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

# Theming
export BAT_THEME="gruvbox-dark"

# alias gcc="gcc -Wall -Wextra -Werror -Wshadow -Wconversion -v -g -O2 --std=c99 "

# dev: exa is unmaintained and doesn't work with homebrew anymore, can use eza instead
# Remap ls to exa for color in filetype 
# alias ls='exa -al --color=always --group-directories-first' # my preferred listing
# alias la='exa -a --color=always --group-directories-first'  # all files and dirs
# alias ll='exa -l --color=always --group-directories-first'  # long format
# alias lt='exa -aT --color=always --group-directories-first' # tree listing
# alias l.='exa -a | egrep "^\."'

alias ls="lsd -l"
alias l='lsd -l'
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

# autoload -Uz compinit
# compinit
# End of lines added by compinstall

### Zinit
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

source ~/deps/zui/zui.plugin.zsh

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

export CLAUDE_CODE_USE_BEDROCK=1
export AWS_REGION='us-east-1'
export AWS_PROFILE='SSO_BedrockUser-211125608813'
export EDITOR='nvim'
export VISUAL='nvim'
set -o vi

# Re-bind fancy-ctrl-z for vi mode keymaps (set -o vi changes active keymaps away
# from 'main', so the plugin's default bindkey '^Z' no longer fires)
bindkey -M viins '^Z' fancy-ctrl-z
bindkey -M vicmd '^Z' fancy-ctrl-z

code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/clara4/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

. "$HOME/.local/bin/env"
