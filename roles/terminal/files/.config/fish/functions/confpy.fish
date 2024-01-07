function confpy
    CDPATH= ./configure --prefix=$HOME/opt/python-3.11.2 \
        --enable-framework=$HOME/opt/python-3.11.2 \
        --with-ensurepip=no \
        --enable-loadable-sqlite-extensions \
        --with-openssl=/usr/local/opt/openssl@3 \
        --with-dbmliborder=gdbm:ndbm \
        --enable-optimizations \
        --with-lto \
        --with-system-expat
end
