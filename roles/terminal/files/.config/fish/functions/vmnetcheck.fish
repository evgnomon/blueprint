function vmnetcheck
  ssh db-0.m1de.vpc -t curl --fail clusterlean.com:8080
  ssh db-0.m1fr.vpc -t curl --fail clusterlean.com:8090
  ssh db-0.m1fi.vpc -t curl clusterlean.com:8080
  ssh db-1.m1de.vpc -t curl clusterlean.com:8080
  ssh db-1.m1fr.vpc -t curl clusterlean.com:8080
  ssh db-1.m1fi.vpc -t curl clusterlean.com:8080
end
