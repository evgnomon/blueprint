if status is-interactive
    if set -q INTERACTIVE_INIT
        return
    end

    set     OPT_PATH    $HOME/opt
    set -x  PYENV_SHELL fish
    set -ax PATH        $HOME/.pyenv/bin
    while set pyenv_index (contains -i -- "$HOME/.pyenv/shims" $PATH)
        set -eg PATH[$pyenv_index]
    end
    set -e pyenv_index
    set -gx PATH "$HOME/.pyenv/shims" $PATH
    set -gx PATH "$HOME/.rbenv/shims" $PATH
    set -gx GEM_HOME "$HOME/.gem"
    set -gx CODE_HOME "$HOME/src"
    set -px PATH     "$GEM_HOME/bin"


    set     CDPATH
    set -x  CDPATH

    for f in (ls -d ~/src/*)
      set -ax CDPATH "$f"
    end

    set -px PATH        $HOME/.cargo/bin
    set -px PATH        $HOME/go/bin
    set -px PATH        $HOME/bin
    set -xa PATH        $HOME/.yarn/bin


    set -x  LIBVIRT_DEFAULT_URI qemu:///system

    set -x  NNN_PLUG    "o:fzopen;c:cdpath;y:cbcopy-mac;"

    alias nnn="nnn -e"

    set -x  FZF_DEFAULT_COMMAND "fd --type f --strip-cwd-prefix --hidden --exclude .git"
    set -x  FZF_CTRL_T_COMMAND  "$FZF_DEFAULT_COMMAND"

    switch (uname)
        case Darwin
            set -ax CDPATH /Volumes
            # macports
            set -x  MACPORTS_HOME $HOME/.macports
            set -xp PATH $HOME/.macports/bin
            set -xp PATH $HOME/.macports/sbin
            set -x  PKG_CONFIG_PATH $MACPORTS_HOME/libexec/openssl3/lib/pkgconfig
        case Linux
            set -ax CDPATH /media/$USER
    end

    eval (ssh-agent -c) > /dev/null
    set -x GPG_TTY $(tty)
    gpg --card-status > /dev/null 2>&1; or true

    set -x EDITOR vim
    set -gx LD_LIBRARY_PATH  $HOME/.pyenv/versions/3.13.7/lib/
    set -px PATH        "$HOME/.local/libexec"
    set -px PATH        "$HOME/.local/bin"

    if string match -q "*WSL2*" -- (uname -r)
      # Windows WSL2
      set -x GPG_AGENT_INFO $HOME/.gnupg/S.gpg-agent:0:1V
    end

    abbr gpu  'git push --set-upstream origin (git branch --show-current)'
    abbr pr   'az repos pr create --target-branch master --title'
    abbr fd   'fd -I --hidden --exclude .git'
    abbr rg   'rg --hidden -i'


    set -x INTERACTIVE_INIT true
end
