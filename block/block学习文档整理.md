##Block
#### 使用clang 将OC代码转换为C++代码

* xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc -fobjc-arc -fobjc-runtime=ios-8.0.0 main.m


####block的本质：
* block的本质是一个的OC对象，它是封装了函数和函数调用环境，它内部也有一个isa指针。
* block的底层结构图：（待补充）

####block的变量捕获机制
##### 局部变量
##### 静态变量
##### 全局变量
##### block会捕获self吗？

####block的类型
* 可以调用class方法或者isa指针查看block的具体类型，最终都是继承NSBlock类型
* block的3种类型。(在ARC和MRC下的区别)
* 每种block类型存储区域
* 每种类型的block调用了copy之后会有变化吗？

####block的copy
* 在ARC环境下，编译器会根据情况自动将栈上的block复制到堆上
	* block作为参数返回值时
	* block赋值给__strong指针时
	* block作为Cocoa API中方法名含有usingBlock的方法参数时
	* block作为GCD API的方法参数时 

---
####__block的本质
####block的内存管理

问题：捕获了OC对象或者捕获了使用__block修饰的临时变量的block结构体中为什么会有forwaring指针?
