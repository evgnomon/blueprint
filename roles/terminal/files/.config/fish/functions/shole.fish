function shole
  argparse -s --name=shole 'h/help' 's/shell=' -- $argv
  or return
  set file_path $argv

  function help
    echo "shole: show the contents of a file"
    echo "usage: shole [-h] path"
    echo "  -h, --help  show this help message and exit"
    echo "  -s, --shell shell, shell to use e.g. fish, sh. Default is sh"
    echo "  path, path to the shell script"
    return 0
  end

  if set -q _flag_help
    help
    return 0
  end

  if [ -z "$file_path" ]
    echo "shole: error: the following arguments are required: path"
    return 1
  end

  switch $_flag_shell
    case fish
      set -g shell_str '/usr/bin/env fish'
    case sh
      set -g shell_str /bin/sh
    case python
      set -g shell_str '/usr/bin/env python3'
    case "*"
      set -g shell_str /bin/sh
  end

  echo '#!'$shell_str'
' > $file_path

  chmod +x $file_path
end
