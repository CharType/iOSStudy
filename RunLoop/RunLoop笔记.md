##RunLoop笔记

[toc]

###RunLoop定义
* Runloop：运行循环，在程序运行的过程中循环做一些事情。
* 如果没有RunLoop,程序代码执行完，就直接结束退出了。
* runLoop的作用：保持程序的持续运行，处理App中的各种事件，比如触摸事件，定时器事件，节省cpu资源，提高程序性能。
* iOS中可以通过Foundation库的NSRunLoop和CFFoundation的CFRunLoopRef来访问和使用RunLoop对象。
* NSRunLoop是对CFRunLoopRef的一层封装，CFRunLoopRef是开源的，[CFRunLoop源码点击这里下载](https://opensource.apple.com/tarballs/CF/)

###RunLoop和线程之间的关系
* 每个线程都有唯一的一个与之对应的RunLoop对象。
* RunLoop保存在一个全局的Dictionary里，线程作为key，RunLoop作为value.
* 线程刚刚创建的时候没有RunLoop对象，RunLoop会在第一次获取它的时候创建（会先从字典中查找，如果没有，会创建一个新的对象）
* RunLoop会在线程结束的时候销毁。
* 主线程的RunLoop已经自动创建，子线程默认没有开启RunLoop。



