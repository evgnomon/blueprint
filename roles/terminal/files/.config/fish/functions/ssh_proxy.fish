function ssh_proxy
  ssh -D 1337 -q -C -N debian@next_ssh_proxy &
end
