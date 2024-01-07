function vminspect
  ssh m1de -t virsh list
  ssh m1de -t virsh vol-list --pool clusterlean-ansible
  ssh m1de -t virsh net-dumpxml clusterlean-m1de
  ssh m1de -t virsh net-dumpxml clusterlean-m1fr
  ssh m1de -t virsh net-info clusterlean-m1fr
end
