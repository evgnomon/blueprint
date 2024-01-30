# License-Identifier: HGL
# Copyright (C) <2022-23> Hamed Ghasemzadeh <hg@evgnomon.org>. All rights reserved.

if status is-interactive
    set -px PATH        "$HOME/.local/bin"

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

    set     CDPATH
    set -x  CDPATH

    for f in (ls -d ~/src/*)
      set -ax CDPATH "$f"
    end

    set -px PATH        $HOME/.cargo/bin
    set -px PATH        $HOME/go/bin
    set -px PATH        $HOME/bin
    set -xa PATH        $HOME/.yarn/bin
    set -xa PATH        $HOME/src/github.com/evgnomon/mybag/bin

    set -x  LIBVIRT_DEFAULT_URI qemu:///system

    set -x  NNN_PLUG    "o:fzopen;c:cdpath;y:cbcopy-mac;"

    alias nnn="nnn -e"

    set -x  FZF_DEFAULT_COMMAND "fd --type f --strip-cwd-prefix --hidden --exclude .git"
    set -x  FZF_CTRL_T_COMMAND  "$FZF_DEFAULT_COMMAND"

    set -x SSH_AUTH_SOCK $HOME/.gnupg/S.gpg-agent.ssh

    set -x EDITOR vim
    set -gx LD_LIBRARY_PATH  $HOME/.pyenv/versions/3.12.0/lib/

    switch (uname)
        case Darwin
            # macports
            set -x  MACPORTS_HOME $HOME/.macports
            set -xa PATH $HOME/.macports/bin
            set -xa PATH $HOME/.macports/sbin
           
        case Linux
            eval (ssh-agent -c) > /dev/null
    end

    if string match -q "*WSL2*" -- (uname -r)
      # Windows WSL2
      set -x GPG_TTY $(tty)
      set -x GPG_AGENT_INFO $HOME/.gnupg/S.gpg-agent:0:1V
    end

    abbr gpu 'git push --set-upstream origin (git branch --show-current)'
    abbr npl 'npm ls -g --depth=0 --link=true'


    set -x INTERACTIVE_INIT true
end
