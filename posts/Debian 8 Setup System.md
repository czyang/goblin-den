---
title: Debian 8 Setup System
author: Chengzhi Yang
createDate: '2016-12-01'
modifyDate: '2016-12-01'
permanent: debian-8-setup-system
---

# Debian 8 Shadowsocks Setup Pre-steps
## 1. Change SSH Port
Connect `ssh root@host`

Change SSH port. `vi /etc/ssh/sshd_config`

Locate line: `#Port 22`

Remove # and change 22 to other port number like 22233.

Restart the sshd service:  `service sshd restart`


Shortcut connect script file.  
```bash
#!/bin/sh
ssh -p 22233 root@host -o ServerAliveInterval=30
```
You can login with this command:  
`./you_script_file_name`

## 2. Add SSH Public Key to Server
[How to set up ssh that make you not need input password when login](https://www.debian.org/devel/passwordlessssh)

> Run ssh-keygen on your machine, and just hit enter when asked for a password.   
> This will generate both a private and a public key. With older SSH versions, they will be stored in ~/.ssh/identity and ~/.ssh_identity.pub; with newer ones, they will be stored in ~/.ssh/id_rsa and ~/.ssh/id_rsa.pub.  
> Next, add the contents of the public key file into ~/.ssh/authorized_keys on the remote host (the file should be mode 600).   

_This step may need “mkdir .ssh” directory_

## 3. Disable Password Authentication
vi /etc/ssh/sshd_config
```bash
vi /etc/ssh/sshd_config

ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no

service sshd restart
```

## 4. Update System
```bash
apt-get update
apt-get dist-upgrade
```

## 5. Setup Shadowsocks
[Recommand shadowsocks server on Github](https://github.com/shadowsocks/shadowsocks-libev#debian--ubuntu)
