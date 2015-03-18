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

不幸的是，每个dns请求都要走一遍隧道的话很慢。

#### DNS缓存
用unbound

- 缓存dns查询结果来改善性能
- 把请求分发到多个dns服务器来改善性能和成功率。
- 把某些域名的解析发到国内的DNS, 使得访问少数国内网站的速度收到的伤害尽可能降低。

用brew安装配置好unbound之后，编辑`/usr/local/etc/unbound/unbound.conf`, 在末尾加上

``` yaml
forward-zone:
  name: "douban.fm"
  forward-addr: 112.124.47.27 # one dns
  forward-addr: 114.215.126.16
  forward-addr: 223.5.5.5 # ali dns
  forward-addr: 223.6.6.6
  forward-addr: 114.114.114.114 # 114 dns
  forward-addr: 114.114.115.115
forward-zone:
  name: "."
  forward-addr: 127.0.0.1@40 # dnscrypt
  forward-addr: 8.8.8.8 # google
  forward-addr: 8.8.4.4
  forward-addr: 208.67.222.222 # open dns
  forward-addr: 208.67.220.220
  forward-addr: 77.88.8.8 # yandex
  forward-addr: 77.88.8.1
```
unload/load之后修改网络设置，设置127.0.0.1为唯一的dns服务器。

### 流量隧道
目前用着还不错的隧道有

- 曲径的http proxy, 提取方法我不想写在这里。
- 国外买vps自建shadowsocks

### 浏览器
Chrome + swtichy omega, 平时会上的国内网站不超过五个，白名单处理，默认走隧道。

### 命令行和其它应用
proxychains (https://github.com/rofl0r/proxychains-ng) 在ssh上效果显著，原先按一个键要过几秒钟才出字的情况可以缓解到一秒左右就出字。 T_T


*(还没写完...)*