#!/bin/sh

[ -d /qa ] || ln -s /etc/cortina/iros/qa /qa
chmod 755 /qa/*
[ -f /bin/r ] || ln -s /qa/g3_rw /bin/r
[ -f /bin/w ] || ln -s /qa/g3_rw /bin/w
sed -i /etc/ca-iros.rc  -e "s/ca_init_signal$/ca_init_signal;source \/qa\/iros_lib.tcl/1"

[ -f /dev/ca-sdk-dev ] || { cd /lib/modules/4.4.3/extra/;
  insmod ca-kernel-hook.ko;
  insmod ca-sdk-cb.ko;
  insmod cli-drv.ko;
}

ifconfig eth1 up
ifconfig eth1 192.168.2.1

#download g3_rw and lib
g3l=$1
[ "$g3l" == "" ] && {
  g3l=0                    
  ( hostname | grep g3l > /dev/null ) && g3l=1
}                                                                                   

[ $g3l == 0 ] && {                                                  
  echo G3 Platform is detected!                            
  echo download g3_rw from 192.168.2.123                                    
  wget ftp://r:r@192.168.2.123/script/g3/g3_rw -O /qa/g3_rw                 
  chmod 755 /qa/g3_rw                                                       
  wget ftp://r:r@192.168.2.123/script/g3/libgcc_s.so.1 -O /lib/libgcc_s.so.1
}                                  
                                                               
[ $g3l == 0 ] || {                  
  echo G3-Lite Platform is detected                            
  wget ftp://r:r@192.168.2.123/script/g3/g3_rw.g3l -O /qa/g3_rw
  chmod 755 /qa/g3_rw
}

