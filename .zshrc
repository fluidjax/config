autoload -U compinit

mkdir -p ~/.vim/undodir

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/.p10k.zsh ]] || source ~/.config/.p10k.zsh


export PATH=$PATH:/usr/local/bin/
export PATH=$PATH:$HOME/bin:$HOME/scripts:/usr/local/bin:$HOME/gocode/config/bin:.:$HOME/gocode/src/code.qredo.net/up/chris:/usr/local/sbin:$HOME/.asdf/installs/ruby/2.6.5/bin/ruby
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GOPATH=$GOPATH
export GOBIN=$HOME/go/bin
export GOROOT=/usr/local/Cellar/go/1.14.2_1/libexec
export ZSH_TMUX_AUTOSTART='true'
export TERM=xterm-256color
export EDITOR=vim
export TMUXINATOR_CONFIG=$HOME/.config/tmuxinator
export VISUAL=vim
export HOMEBREW_AUTO_UPDATE_SECS=60000


# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
source ~/.zplug/init.zsh

zplug "plugins/vi-mode",  from:oh-my-zsh
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/autojump",   from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "hlissner/zsh-autopair", defer:2
zplug load

#VIM
bindkey -v

# Keybindings for substring search plugin. Maps up and down arrows.
bindkey -M main '^[OA' history-substring-search-up
bindkey -M main '^[OB' history-substring-search-down
bindkey -M main '^[[A' history-substring-search-up
bindkey -M main '^[[B' history-substring-search-up


ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#505050,bg=black"

#Colors
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

#For Qredo SSH from Yubikey
export GPG_TTY="$(tty)"
gpg-connect-agent updatestartuptty /bye > /dev/null
unset SSH_AGENT_PID
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
source $HOME/.asdf/asdf.sh

source $HOME/.config/aliases

#History
export HISTFILE=~/.config/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000


## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data



function run() {
    number=$1
    shift
    for n in $(seq $number); do
      $@
    done
}

netpid() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

unalias g
g(){
    touch ${1}; goland ${1}
}
