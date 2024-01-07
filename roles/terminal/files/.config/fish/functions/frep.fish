function frep
    argparse -i --name=frep 's/search=' 'r/replace=' -- $argv
    or return 1

    echo "/$(echo $_flag_s | sed -e 's/[/]/\\\\\//g')"
    for f in (rg -. -l -e $_flag_s)
        sed -i "s/$(echo $_flag_s | sed -e 's/[/]/\\\\\//g')/$(echo $_flag_r | sed -e 's/[/]/\\\\\//g')/g" $f
    end

end
