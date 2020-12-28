#! /bin/bash
installdir=$(cd `dirname $0`; pwd)
cd $installdir
function install_ipserver()
{
  ipserver_install_dir=$(cat ipserver_install_path.txt|grep -v '#')
  echo "ipserver安装路径为 $ipserver_install_dir"
  mkdir -p $ipserver_install_dir
  cp -aR $installdir/ipserver $ipserver_install_dir
  cp -aR $installdir/qqwry.dat $ipserver_install_dir
  yes |cp -aR $installdir/ip-server /etc/init.d/ipserver
  #sed -i -e "s#\/data\/software\/ipserver#\$ipserver_install_dir#" /etc/init.d/ipserver
  #sed -i 's/data\/software\/ipserver/\${ipserver_install_dir}/g' /etc/init.d/ipserver
  sed -i -e "1,20s#\/data\/software\/ipserver#$ipserver_install_dir#" /etc/init.d/ipserver
  chmod +x /etc/init.d/ipserver
  echo "启动ipserver服务"
  /etc/init.d/ipserver start
}
install_ipserver
