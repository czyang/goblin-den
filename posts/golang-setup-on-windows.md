---
title: Go语言在windows下面配置的简要流程（gomingw）
author: Chengzhi Yang
createDate: '2011-12-06'
modifyDate: '2011-12-06'
permanent: golang-setup-on-windows
---

# Go语言在windows下面配置的简要流程（gomingw）

Go语言的官网：http://golang.org       Go语言的官网上面就有不少非常好的教程。

推荐云风的Blog的这篇文章：Go语言初步  http://blog.codingnow.com/2010/11/go_prime.html

这里我记录一下在windows环境下配置Go语言的流程，要在windows 下面安装Go语言看这个网页  Go under MS Windows  http://code.google.com/p/go/wiki/WindowsPort  这个网页里面有一个Youtube 上的视频，教你如何做，我下面的步骤只是简单的记录一下这个过程。

在windows下面用go语言目前还没有google官方的直接支持，不过可以用gomingw这个东西，貌似现在只支持32位系统的，64位的也可以试试。

1. 安装gomingw之前应该是需要先安装mingw（这个步骤我不确定是不是必须的，我的电脑之前已经安装了mingw）

2. 下载gomingw http://code.google.com/p/gomingw/downloads/list，把go目录解压出来放到任意目录，这里以D盘根目录作为例子：d:\go

3. 设着 “环境变量”（我的电脑->高级系统设置->环境变量），在系统变量的标签下，以此新建编辑如下几个键值对：

 * 新建 变量名：GOBIN        变量值 ：d:\go\bin
 * 新建 变量名：GOARCH   变量值：386
 * 新建 变量名：GOOS   变量值：windows   ( 注意这对键值，从2010-05-04之后的版本GOOS对应的值是windows，之前GOOS对应的值是mingw)
 * 新建 变量名： GOROOT  变量值：d:\go
 * 编辑 Path 在Path的变量值的最后加上    %GOBIN%   （记得用  ;(分号) 和前面的串隔开 ）

之后就可以用“8g”  “8l” 命令来编译链接hellow world了。
