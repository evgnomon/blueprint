function dl16
  aria2c --max-connection-per-server=16 --split=16 --min-split-size=1M $argv
end
