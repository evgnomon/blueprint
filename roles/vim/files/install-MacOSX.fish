CDPATH= LDFLAGS="-mmacosx-version-min=13.0" ./configure --with-features=huge --with-ruby-command=$HOME/.rbenv/shims/ruby --disable-nls \
    --enable-multibyte \
    --enable-rubyinterp=yes \
    --enable-python3interp=yes \
    --with-python3-command=$HOME/.pyenv/versions/3.12.0/Library/Frameworks/Python.framework/Versions/3.12/bin/python3 \
    --with-python3-config-dir=$HOME/.pyenv/versions/3.12.0/Library/Frameworks/Python.framework/Versions/3.12/lib/python3.12/config-3.12-darwin \
    --enable-perlinterp=yes \
    --enable-luainterp=yes \
    --enable-cscope \
    --prefix=$HOME/.local \
    --with-luajit

CDPATH= make install
