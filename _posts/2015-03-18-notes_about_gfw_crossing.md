---
title: 科学上网笔记
date: 2015-03-18 01:23+0800
tags:
- gfw
- tech
---

科学上网笔记 *(还没写完)*
=======================

我们面对什么问题
----------------
1. 国内的 dns 可能把某些域名解析到错误的 ip 上，或者不解析. (search about "DNS污染")
1. 对某些 ip 的访问可能被阻断.
1. 对某些 ip 的访问可能被丢包.
1. 国际出口非常非常非常拥堵. (需证实)

逐个设法解决
-------------
<!-- more -->

### DNS

#### 改用干净的DNS
- 8.8.8.8 # Google 
- 8.8.4.4 
- 208.67.222.222 # open dns
- 208.67.220.220
- 77.88.8.8 # yandex
- 77.88.8.1

不幸的是，这些 ip 也被干扰了，导致有时候无法解析域名。

#### 加密 dns 查询
为了做加密的dns查询，需要

- 一台可以信任的并且支持dnscrypt的dns服务器
- 在本机配置dnscrypt

首先是dns服务. 支持 dnscrypt 的服务器清单在 https://github.com/jedisct1/dnscrypt-proxy/blob/master/dnscrypt-resolvers.csv , 不幸的是，这个清单上没有合适国内用的选项。  
所以我们只好首先在墙外租一台服务器，然后在上面安装 dnscrypt-wrapper http://cofyc.github.io/dnscrypt-wrapper/ 来把dns请求转交给墙外的公共dns服务。

然后在本机`brew install dnscrypt-proxy`, 按brew的安装说明完成剩下的步骤，然后编辑 `/Library/LaunchDaemons/homebrew.mxcl.dnscrypt-proxy.plist`:

``` xml
<array>
  <string>/usr/local/opt/dnscrypt-proxy/sbin/dnscrypt-proxy</string>
  <string>--user=nobody</string>
  <string>--resolver-address=x.x.x.x:x</string>
  <string>--provider-key=xxx</string>
  <string>--provider-name=xxx</string>
  <string>--local-address=127.0.0.1:40</string>
</array>
```
如果需要，sudo launchctl unload/load一遍来让设置生效。

不幸的是

- 所有域名都到国外dns解析的话，在某些国内服务上会被分配到针对国外优化的CDN，访问起来很慢。
- 每个dns请求都要走一遍隧道的话很慢

#### DNS分发和缓存

在本机架设 https://github.com/snow/pathfinder 来把白名单上的域名交给国内dns, 剩下的都用 dnscrypt-proxy 送出国。不幸的是，目前pathfinder离完工还很远，暂时不太适合非战斗人员使用。

然后在本机架设 dnsmasq 作为缓存, `brew install dnsmasq` 并按brew的安装说明完成剩下的步骤，然后编辑 `/usr/local/etc/dnsmasq.conf`, 确保下面几行:

``` cfg
domain-needed
bogus-priv
no-resolv
server=127.0.0.1#5300
```
并重启dnsmasq.

最后，把操作系统的dns配置为有且仅有`127.0.0.1`, 这样暂时就勉强解决了DNS的问题。


### 流量隧道
目前用着还不错的隧道有

- 曲径的http proxy, 提取方法我不想写在这里。
- 国外买vps自建shadowsocks

### 浏览器
Chrome + swtichy omega, 平时会上的国内网站不超过五个，白名单处理，默认走隧道。

### 命令行和其它应用
proxychains (https://github.com/rofl0r/proxychains-ng) 在ssh上效果显著，原先按一个键要过几秒钟才出字的情况可以缓解到一秒左右就出字。 T_T


*(还没写完...)*