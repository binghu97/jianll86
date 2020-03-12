#!/bin/bash
find /opt -size +2M  -name "*.log" -exec cp /dev/null {} \;
find /opt  -size +2M -and -mtime +1 -a -name "catalina.*.log" -exec cp /dev/null {} \;
find /opt  -size +2M -and -mtime +1 -a -name "localhost_access_log*" -exec cp /dev/null {} \;
find /opt   -mtime +1 -a -name "*log.zip" -exec rm -f {} \;
find /opt    -mtime +1 -a -name "*201*log*" -exec rm -f {} \;
find /opt  -mtime +1 -a -name "*heapdump.*" -exec rm -f {} \;
find /opt  -mtime +1 -a -name "*core.*dmp*" -exec rm -f {} \;
find /opt  -size +5M -a -name "*.out" -exec cp /dev/null {} \;
find /opt/ -name "*201[1-9]-*" -type d  -mtime +1  -exec rm -rf {} \;
