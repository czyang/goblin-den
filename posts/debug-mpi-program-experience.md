---
title: 用gdb调试mpi程序的一些心得
author: Chengzhi Yang
createDate: '2010-09-23'
modifyDate: '2010-09-23'
permanent: debug-mpi-program-experience
---

# 用gdb调试mpi程序的一些心得

Linux下MPI (Message Passage Interface) 的程序不太好调试，在windows下vs2005以上的IDE有集成的简便MPI调试工具，没有用过，有兴趣的可以试验一下。下面总结了一些最近在用MPI和c语言写程序时的调试经验（Ubuntu环境，c语言, mpich 1.2.7）。

需要注意的几个小问题
在编译程序的时候 –g 是一定要加的，不然在gdb调试的时候可能会报类似“source is not available”的错误。开始我调程序的时候我都把我的程序的每个调试版本，分别发送到集群中的每台机器上面，然后在mpirun –machinefile host –np 3 myprogram 运行我的程序，这种方法没有效率，只能在最后记录实验结果的时候或者最后调试阶段才能用。有效率的方式是 mpirun –np 3 myprogram 在本机直接运行程序，这样mpi就会在本机开3个myprogram的进程，这样不接网线都可以方便的调试mpi的程序。这是几个小问题，下面切入关键部分。

用gdb来调试mpi的程序
首先，本文所用的mpich版本为1.2.7，可能跟其他版本有一定的差异，RTFM，看看自己所用版本的使用手册来解决版本上的差异。
Mpi程序运行的时候都是通过mpirun 后接参数和你的程序，gdb也是类似的过程，所以你不可以直接 gdb mpirun –np 3 myprogram，但你可以直接mpirun –gdb –np 3 myprogram。这样你就可以再gdb中调试你的程序了。
不过，这样有个问题，你可以调试在主节点运行的部分，也就是相对于集群而言，你本机所运行的部分，程序运行到子各个节点部分以后，你的gdb就不能继续调下去了，这个就是个问题。Gdb其实可以在程序已经执行了以后，再挂载你的程序，这样你可以在程序执行的期间把gdb挂载进来。简而言之就是把程序暂停起来（比如读个键盘输入getchar()之类的），用gdb myprogram pid （myprogram是你程序的进程名， pid是你程序进程的pid号）如何查看pid号呢？ 在终端里面运行 ps –a 就可以了，这样就可以找到你自己程序的进程名和PID号，gdb myprogram 1234 这样就可以挂载到你要调试的位置了。
但子节点有两种情况，一种情况是子节点运行的那部分程序运行在集群中其他的计算机上面；另一种情况是都在本机运行。第一种情况较容易解决，只要在程序运行后，暂停子节点运行的那部分程序(在子节点就不可以用getchar()了，我用sleep()函数来解决这个问题)，ssh上去子节点计算机上面，在子节点上面ps –a查进程信息 gdb mp 1234 挂载进去调试，不过要确保子节点上面也安装了GDB。第二种情况，因为在本机运行上面开了多个你自己程序的进程，这样会同时出现 3个myprogram，虽然pid各不相同，不过程序名完全一样，占用内存不是有内存泄露也几乎一样，其中一个是主节点的进程，另外几个是子节点的进程，这样要知道哪个进程是子节点部分的，就要在子节点部分获取所对应的进程的pid，很简单，只要在代码中加入：

```cpp
#include <sys/types.h>
#include <unistd.h>
//…
int pid;
pid = getpid();
printf ( “\n%d\n”, pid );
//…
```

这样就可以根据获取的pid信息来确定要挂载到哪个进程里面。补充一点，有种情况，有几个子节点同时运行，程序中某个子节点运行的部分由段错误，会自己终止，这样其他子节点也会跟着那个子节点一起终止，不管你有没有挂载gdb到进程里面，这样可以吧会崩溃的子节点用sleep睡一段足够长的时间，这样可以单独调试某个子节点的部分，而不至于过早终止。

顺便问个问题，怎么让mpi的程序内存转储（core dump），直接运行程序可以，加上mpirun以后就不可以core dump了，麻烦知道的告诉我一下coding.game$gmail.com，非常感激。

推荐大家读这篇：[Using gdb and ddd with MPI](http://users.atw.hu/linuxclusters/highperlinuxc-chp-16-sect-7.html)
