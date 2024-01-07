function mydbsh


  # ssh db-0.m1fr.vpc -t sudo docker exec -it mydb mysqlsh --uri clusteradmin@server-2:3307
  ssh db-0.m1fr.vpc -t sudo docker exec -it myrouter mysqlsh --uri clusteradmin@server-2:6546

end
