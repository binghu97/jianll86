#!/bin/bash
crontab -l > /tmp/crontab.bak
echo "30 */4 * * * source /home/wasadmin/cleanfeiwas2.sh">>/tmp/crontab.bak
crontab /tmp/crontab.bak

