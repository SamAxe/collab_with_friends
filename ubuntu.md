---
title:          notes for setting up and running a droplet
subtitle:
author:
keywords:
created:        2025/11/16 08:50
last modified:  2025/12/13 14:43
---

# Ubuntu droplet

    apt update
    apt upgrade
    apt install ufw   # firewall
    apt allow from xx.xx.xx.xx/xx to any port 22   # allow ssh from your subnet of addresses
    ufw enable ufw
    systemctl enable ufw
    systemctl start ufw

    apt install fail2ban
    apt install unattended-upgrades
    systemctl enable unattened-upgrades
    systemctl start unattended-upgrades

    # Intrusion detection
    apt install aide
    aide --init --config /etc/aide/aide.conf
    mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

    # Security Audit
    apt install lynis

    apt install chkrootkit
    apt install rkhunter

# Background/motivation

These notes presume a need for a host to be on the internet and that you might be a hobbiest more than setting up an enterprise platform.  
There are a number of risks of putting a machine on __the internet__ and these notes will attempt to capture some of risks and make some suggestions for consideration for
your trade-offs.

* Assume that the host will eventually become compromised,
  - I.e. there should be backups/recovery method
  - I.e. limit the compromise to the specific platform by not hosting from your house and spreading to other devices.
  - I.e. use a cloud provider, apply security patches, and take advantage of cloud provider infrastructure where it makes sense to do so.
  - I.e. don't put any information on the internet that you want to keep private.
* Limit the attack surface to compromise by limiting the number of ports/services that are open and facing the internet.  For the ports/services that are open,
  consider limiting access with some sort of authentication mechanism.
* There are network scanners that will bombard your platform contineously, usually probing for a follow up attack.
* There are network scrapers that will use what is scraped for many purposes, e.g. indexing, training LLMs, etc.
* Your cloud provider probably charges by a number of metrics including file storage, network traffic (maybe including DNS, routes, etc), and cpu usage.
