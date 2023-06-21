export LANG="ja_JP.UTF-8"

# viキーバインド
bindkey -v
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


### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

zinit self-update
zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light chrissicool/zsh-256color

# required fzf
zinit light b4b4r07/enhancd

# required: deno, fzf, opitional: ghq
zinit ice lucid depth"1" blockf
zinit light yuki-yano/zeno.zsh

# zeno settings
# if defined load the configuration file from there
# export ZENO_HOME=~/.config/zeno
# if disable deno cache command when plugin loaded
# export ZENO_DISABLE_EXECUTE_CACHE_COMMAND=1
# if enable fzf-tmux
# export ZENO_ENABLE_FZF_TMUX=1
# if setting fzf-tmux options
# export ZENO_FZF_TMUX_OPTIONS="-p"
# Experimental: Use UNIX Domain Socket
# export ZENO_ENABLE_SOCK=1
# if disable builtin completion
# export ZENO_DISABLE_BUILTIN_COMPLETION=1
# default
export ZENO_GIT_CAT="cat"
# git file preview with color
# export ZENO_GIT_CAT="bat --color=always"
# default
export ZENO_GIT_TREE="tree"
# git folder preview with color
# export ZENO_GIT_TREE="exa --tree"
if [[ -n $ZENO_LOADED ]]; then
  bindkey ' '  zeno-auto-snippet
  # fallback if snippet not matched (default: self-insert)
  # export ZENO_AUTO_SNIPPET_FALLBACK=self-insert
  # if you use zsh's incremental search
  # bindkey -M isearch ' ' self-insert
  bindkey '^m' zeno-auto-snippet-and-accept-line
  bindkey '^i' zeno-completion
  # fallback if completion not matched
  # (default: fzf-completion if exists; otherwise expand-or-complete)
  # export ZENO_COMPLETION_FALLBACK=expand-or-complete
  bindkey '^r'   zeno-history-selection
  bindkey '^x^s' zeno-insert-snippet
  bindkey '^x^f' zeno-ghq-cd
fi


source ~/.zsh_profile
source ~/companyutil.sh
