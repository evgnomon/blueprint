function mvol
    argparse -i --name=mvol 'h/help' 'd/dst=' 's/src=' 'v/volume=' -- $argv
    or return $status
    # 172.17.0.1

    set -l pub_key (docker run --rm -v rsync-client-ssh:/root/.ssh rsync cat /root/.ssh/id_rsa.pub)
    docker run --rm -d  --name tester -v $_flag_volume:/srv/vol -e AUTHORIZED_KEYS=$pub_key -p 1422:22 rsync
    sleep 2
    docker run --rm -it -v rsync-client-ssh:/root/.ssh -v $_flag_volume:/srv/vol rsync rsync -avzh --rsh='ssh -p1422' /srv/vol root@$_flag_dst:/srv/vol
    docker stop tester
    docker volume rm rsync-client-ssh
    # TODO: remove:
    docker volume rm $_flag_volume
end
