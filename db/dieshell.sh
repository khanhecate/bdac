#!/bin/bash
grep -v 'include "/etc/bind/zone/nekopoi.lol/nekopoi.conf";' /etc/bind/named.conf.local > db/tmp
