---
layout: post
title: 用U盘安装CentOS5/Debian/Ubuntu
tags:
- linux
- debian
- ubuntu
- centos
---

用U盘安装CentOS5/Debian/Ubuntu
=============================

## 准备
**grub4dos**  
http://download.gna.org/grub4dos/

**安装光盘镜像**  
CentOS的话，最好下全所有镜像，5.4是6cd；Debian只要下第一张就可以了；Ubuntu/Kubuntu则只有一张。

- - -
**U盘或者别的USB存储设备一个**  
MBR必须是空的——如果你不知道MBR是什么，要么假定它已经是空的，要么自己google。如果不想安装过程中发生各种难以预知的意外，最好整个U盘都是空的。

**用来启动安装程序的内核和内存镜像**  
CentOS的在iso1的images/diskboot.img里面，分别是vmlinz和initrd.img
Debian和Ubuntu的则要去服务器找，首先要知道一些debian和ubuntu资源的ftp服务器，参考收集速度快的Debian或者Ubuntu源
然后镜像通常在类似这样的路径下面
  
> dists/squeeze/main/installer-i386/current/images/hd-media/
  
squeeze这一节是版本代号，例如debian的lenny,squezz,etch,sid(unstable分支永远是sid)，ubuntu的intrepid,karmic,hardy,也有可能出现current,指向当前的稳定版本。
installer-i386这一级上根据自己的平台选择，要和iso匹配，例如下的是amd64的iso那么这里也应该选amd64。最终看到hd-media这个目录，就到家了。里面有vmlinz和initrd.gz，就是它们俩了。
  
## 开工
把grub4dos解压到U盘里，然后把vmlinz和initrd还有光盘镜像都丢进去。debian和ubuntu的镜像必须放在根目录，CentOS的不用但是何必多此一举自找麻烦。  
然后用这个U盘开机，通常是在开机自检的时候按f12或者esc会进入选择启动设备的菜单，在那里选择usb-hdd或者在硬盘列表里找到u盘。还不会的话自己google一下。  
启动成功之后就到了grub菜单，按c进入命令行，执行

```sh
kernel /vmlinuz
initrd /initrd.gz #或者.img
boot
```

就会引导安装程序。之后debian/ubuntu的安装程序会自己搜索iso，而centos则需要指定iso所在的设备和路径。
之后就进入正常的轨道了。