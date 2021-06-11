# Set up the prompt
export LANG="ja_JP.UTF-8"
export PATH="$HOME/.nodenv/bin:$PATH"
source ~/.zsh_profile

# Use modern completion system
autoload -Uz compinit promptinit

# viキーバインド
bindkey -v

# Ctrl+n or Ctrl+p で履歴補完
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^N" up-line-or-beginning-search
bindkey "^P" down-line-or-beginning-search

PROMPT='%m:%~$ '

# 同じコマンドを入れても履歴としては1回しか出ないように
setopt histignorealldups

# 複数のシェルで履歴を共有
setopt sharehistory

# エイリアスで自動補完を切り替える
setopt completealiases

# 履歴を100000確保する
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

# あまりよくわかってないけど補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

# セパレータを設定する
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

# 補完候補が2つ以上なければすぐ補完
zstyle ':completion:*' menu select=2

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

eval "$(nodenv init -)"
