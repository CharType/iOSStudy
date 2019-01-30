###OC的基础
#####将Objective-C代码转换为C和C++代码的几种方式
* clang -rewrite-objc main.m -o 输出的cpp文件 
* xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc OC源文件 -o 输出的cpp文件 这个方法可以指明平台和架构

####苹果源码地址点击
* 苹果源码地址点击[这里](https://opensource.apple.com/tarballs/)去下载。

####Xcode调试和常用的lldb调试指令
* p (print) 主要功能是用来输出基本数据类型，int,float,double,bool 等
* po(print object) 主要功能是输出objective-c中对象的信息 和p 类似 自己测试 po 对象名 = 新生产的对象 也可以修改某个变量的值。
* expr (expression) 可以用来修改变量的值 expr 变量名 = 要赋的值。也可以在Xcode中右键 Edit Breakpoint 可以编辑断点直接进行调试 ![](编辑断点.png) 在action中输入需要修改的变量的值 如果Automaticall选项，代表运行到这个断点的时候会直接修改变量的值，不进入调试模式，不勾选会直接进入调试模式。action中也可以输入其他指令
* 设置断点的触发条件，在上图中如果在condition中输入断点的触发条件 等于是告诉编译器，符合输入的条件的时候这个断点才能生效。
* bt 显示当前线程的堆栈
* bt all 显示所有线程的堆栈
* image 这个命令可以用来寻址，主要作用是用于寻找栈地址对应的代码位置 如图：![](lldb-image.png) 可以根据栈地址查找到代码对应的位置。
*  memory read  读取内存中的值 格式：memory read 内存地址
*  memory write 修改内存中的值 格式：memory write 内存地址 值

####一个OC对象在内存中如何布局？


