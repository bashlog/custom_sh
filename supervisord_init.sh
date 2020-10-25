#!/bin/bash 

yum install python-setuptools 

easy_install pip

pip install -i https://pypi.tuna.tsinghua.edu.cn/simple supervisor

mkdir -p /opt/supervisord
mkdir -p /opt/supervisord/log/
mkdir -p /opt/supervisord/programs
mv /root/py-kms-master /opt/supervisord/programs
mv /root/supervisord.conf /etc
mkdir -p /etc/supervisord.conf.d

useradd -r chrism

chown -R chrism:chrism /opt/supervisord