function renametool
    argparse -i --name=renametool 's/search=' 'r/replace=' -- $argv
    or return 1
    for f in (rg "$_flag_search" -l)
        sed -i 's/'$_flag_search'/'$_flag_replace'/g' $f
    end
end
