# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# put this file as ~/.zshrc

# Path to your oh-my-zsh installation.
export EDITOR="nvim"
export ZSH="$HOME/.oh-my-zsh"
#export LC_ALL=C

eval "$(zoxide init zsh)"

ZSH_THEME="robbyrussell"


plugins=(
    git
    vi-mode
)

bindkey -v
# 模拟 Vim 插件：快速按 jj 回到 normal 模式（避免按 ESC）
bindkey -M viins 'jj' vi-cmd-mode

source $ZSH/oh-my-zsh.sh

PROMPT="%{$fg_bold[white]%}%m $PROMPT"


#export MACOSX_DEPLOYMENT_TARGET=14.1
#export MACOSX_DEPLOYMENT_TARGET=13.0

#export ANDROID_SDK="/Applications/Unity/Hub/Editor/2022.3.16f1c1/PlaybackEngines/AndroidPlayer/SDK/platform-tools"
export ANDROID_SDK="/Applications/Unity/Hub/Editor/6000.0.41f1/PlaybackEngines/AndroidPlayer/SDK/platform-tools"

export JAVA_HOME="/Users/huangzhuofu/Downloads/Android_Env_2021.3/OpenJDK"


#export ANDROID_SDK_YIMI="/Applications/Unity/Hub/Editor/2020.3.48f1c1/PlaybackEngines/AndroidPlayer/SDK/platform-tools"
#export ANDROID_NDK="/Applications/Unity/Hub/Editor/2022.2.12f1c1/PlaybackEngines/AndroidPlayer/NDK"
#export CMAKE_PATH="/Applications/Unity/Hub/Editor/2022.2.12f1c1/PlaybackEngines/AndroidPlayer/SDK/cmake/3.22.1/bin"

export PATH="$PATH:$ANDROID_SDK"
export PATH="$PATH:$CMAKE_PATH"
export PATH="$PATH:$JAVA_HOME"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

#export LUA_INC="/opt/homebrew/opt/luajit/include/luajit-2.1"


alias python="/usr/bin/python3"
alias py="/usr/bin/python3"
alias nhost="sudo nvim /private/etc/hosts"
alias nssh="sudo nvim ~/.ssh/config"
unalias tls ta 2>/dev/null
tls() {
    local selected session
    selected=$(tmux list-sessions 2>/dev/null \
        | fzf --height=40% --reverse --prompt='tmux session> ') || return
    session=${selected%%:*}

    if [[ -n "$session" ]]; then
        if [[ -n "$TMUX" ]]; then
            tmux switch-client -t "$session"
        else
            tmux attach -t "$session"
        fi
    fi
}
ta() {
    if [[ $# -eq 0 ]]; then
        tls
    else
        tmux attach -t "$@"
    fi
}
alias tn='tmux new -s'
alias trn='tmux rename-session -t'
alias yimiadb="${ANDROID_SDK_YIMI}/adb"
alias addr2line="/Applications/Unity/Hub/Editor/6000.0.20f1c1/PlaybackEngines/AndroidPlayer/NDK/toolchains/llvm/prebuilt/darwin-x86_64/bin/llvm-addr2line"
alias addr2line_g01="addr2line -f -C -e /Users/huangzhuofu/Documents/Projects/MainVersion/Symbols/arm64-v8a/libunity.sym.so "
alias buildId="/opt/homebrew/opt/binutils/bin/readelf -n "


export host_id="Mac"

export PATH=":$PATH"

# export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
# export PATH=$JAVA_HOME/bin:$PATH
