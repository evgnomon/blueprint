function mydbstatus
  ssh db-0.m1de.vpc -t sudo docker exec -it mydb mysqlsh --execute "\"print(dba.getCluster().status())\"" --uri clusteradmin@server-1:3306
end
