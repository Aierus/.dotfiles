source ~/.promptlinex.sh

# opam configuration OCaml
test -r /Users/andyclark1/.opam/opam-init/init.zsh && . /Users/andyclark1/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
# autocompletions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

autoload -Uz compinit
compinit
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

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
alias youtube-dl="yt-dlp"
alias lf="ranger"
alias pip="pip3"
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
alias df='df -h'                                                # Human-readable sizes
alias free='free -mh'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'
alias bcsync='rsync -vzhr --delete-after clarkui@cslab.bc.edu:/home/clarkui/cs2/ ~/2021/cs2/'  
alias cryptosync='rsync -uvrP --delete-after public/ root@45.77.153.250:/var/www/bcblockchain'
alias vim="nvim"
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias finder='open'
alias dotfiles='git --git-dir=/Users/andyclark1/.dotfiles/.git --work-tree=/'
alias dtig='tig /Users/andyclark1/.dotfiles --GIT-WORK-TREE=/'


# alias gcc="gcc -Wall -Wextra -Werror -Wshadow -Wconversion -v -g -O2 --std=c99 "

# meson ninja PATH 
export PATH=$PATH:/Users/andyclark1/Library/Python/3.8/bin

# Remap ls to exa for color in filetype 
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'

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

setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache.

bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo          					# Shift+tab undo last action

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
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh
zinit snippet OMZ::plugins/jsontools/jsontools.plugin.zsh
zinit snippet OMZ::plugins/rand-quote/rand-quote.plugin.zsh
zinit light zsh-users/zsh-completions
# zinit light marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/history-search-multi-word
zinit light zdharma-continuum/fast-syntax-highlighting

alias ssh="kitty +kitten ssh"
