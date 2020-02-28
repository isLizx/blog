# Host: 127.0.0.1  (Version: 5.5.28)
# Date: 2020-01-30 09:36:21
# Generator: MySQL-Front 5.3  (Build 4.214)

/*!40101 SET NAMES utf8 */;

#
# Structure for table "t_tag"
#

DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

#
# Data for table "t_tag"
#

INSERT INTO `t_tag` VALUES (8,'Java基础'),(9,'线程'),(10,'JCF框架'),(11,'spring源码'),(12,'mybatis'),(13,'AOP'),(14,'IOC'),(15,'排序'),(16,'hashmap'),(17,'布局'),(18,'美化');

#
# Structure for table "t_type"
#

DROP TABLE IF EXISTS `t_type`;
CREATE TABLE `t_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

#
# Data for table "t_type"
#

INSERT INTO `t_type` VALUES (30,'生活笔记'),(31,'网络'),(32,'设计模式'),(33,'Java'),(34,'算法'),(35,'学习经验'),(36,'web前端'),(37,'Markdown');

#
# Structure for table "t_user"
#

DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Data for table "t_user"
#

INSERT INTO `t_user` VALUES (2,'https://picsum.photos/id/447/110/110','2017-10-15 12:36:04','hh@163.com','RAYMOND','96e79218965eb72c92a549dd5a330112',1,'2017-10-15 12:36:23','admin');

#
# Structure for table "t_blog"
#

DROP TABLE IF EXISTS `t_blog`;
CREATE TABLE `t_blog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appreciation` bit(1) NOT NULL,
  `commentabled` bit(1) NOT NULL,
  `content` text,
  `createTime` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `firstPicture` varchar(255) DEFAULT NULL,
  `flag` varchar(255) DEFAULT NULL,
  `published` bit(1) NOT NULL,
  `recommend` bit(1) NOT NULL,
  `shareStatement` bit(1) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `views` int(11) DEFAULT NULL,
  `type_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK292449gwg5yf7ocdlmswv9w4j` (`type_id`),
  KEY `FK8ky5rrsxh01nkhctmo7d48p82` (`user_id`),
  CONSTRAINT `FK292449gwg5yf7ocdlmswv9w4j` FOREIGN KEY (`type_id`) REFERENCES `t_type` (`id`),
  CONSTRAINT `FK8ky5rrsxh01nkhctmo7d48p82` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

#
# Data for table "t_blog"
#

INSERT INTO `t_blog` VALUES (55,b'1',b'1','# 1.static、final和常量设计\r\n\r\n## **static**\r\n\r\n* static静态的，Java中特殊的关键字\r\n* Java中的static关键字（可作用在）\r\n  * 变量\r\n  * 方法\r\n  * 类\r\n  * 匿名方法块\r\n* 静态变量，类共有成员\r\n  * static变量只依赖于类存在（通过类即可访问），不依赖于对象实例存在。即可以通过Potato.price即可访问。\r\n  * 所有的对象实例，如例子中的obj1和obj2关于price变量的值都共享存储在一个共同的空间（栈）。\r\n* static方法 \r\n  *  静态方法也无需通过对象来引用，而通过类名可以直 接引用。 \r\n  *  在静态方法中，只能使用静态变量，不能使用非静态 变量。 \r\n  *  静态方法禁止引用非静态方法。 \r\n* static块  \r\n  *  只在类第一次被加载时调用。 \r\n  *  在程序运行期间，这段代码只运行一次。 \r\n  *  static块 > 匿名块 > 构造函数。 \r\n\r\n## **static总结**\r\n\r\n*  static变量：不管有多少个对象，内存中只有一份 \r\n*  static方法：可以用类名直接引用，无需new对象来引用 \r\n*  static块：static块只执行一次，并且static块 >匿名块>构造函数 \r\n\r\n------\r\n\r\n## **单例模式**\r\n\r\n* 单例模式，又名单态模式, Singleton。 \r\n\r\n* 限定某一个类在整个程序运行过程中，只能保留 一个实例对象在内存空间。 \r\n\r\n* 单例模式是GoF的23种设计模式(Design Pattern)中 经典的一种，属于创建型模式类型。 \r\n\r\n  * 设计模式：在软件开发过程中，经过验证的，用于解决 在特定环境下的、重复出现的、特定问题的解决方案。 \r\n  * 1995年Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides(GoF)合著的《设计模式—可复用面向对象软件 基础》总结了常见的23种设计模式，包括：创建型、结 构型和行为型。 \r\n\r\n* 单例模式：保证一个类有且只有一个对象 \r\n\r\n  * 采用static 来共享对象实例 \r\n  * 采用private 构造函数，防止外界new操作 \r\n\r\n* ~~~java\r\n  public class test1 {\r\n  \tpublic static void main(String[] args) {\r\n  \t\tSystem.out.println(Singleton.getInstance().getContent());\r\n  \t}\r\n  }\r\n  \r\n  class Singleton{\r\n  \tprivate static Singleton obj = new Singleton(); // 共享同一个对象\r\n  \tprivate String content;\r\n  \t\r\n  \tprivate Singleton(){\t// 确保只能在类内部调用构造方法\r\n  \t\tthis.content = \"abc\";\r\n  \t}\r\n  \tpublic String getContent() {\r\n  \t\treturn content;\r\n  \t}\r\n  \tpublic void setContent(String content) {\r\n  \t\tthis.content = content;\r\n  \t}\r\n  \tpublic static Singleton getInstance(){\r\n          // 静态方法使用静态变量\r\n          // 另外可以使用方法内的临时变量，但是不能引用非静态的成员变量\r\n  \t\treturn obj;\r\n  \t}\r\n  }\r\n  ~~~','2019-12-12 15:19:04','1.static、final和常量设计。static静态的，Java中特殊的关键字。Java中的static关键字（可作用在变量，方法，类，匿名方法块）','http://img0.imgtn.bdimg.com/it/u=2247329818,668470334&fm=26&gp=0.jpg','原创',b'1',b'1',b'1','Java基础（一）','2019-12-12 15:19:50',27,33,2),(56,b'1',b'1','# **常量池**\r\n\r\n* 作用\r\n  1. 节约内存（保存在编译期间就已经确定的数据）\r\n  2. 共享访问\r\n* Java为很多基本类型的包装类/字符串都建立常量池\r\n* 基本类型的包装类\r\n  * Boolean,Byte,Short,Integer,Long,Character,Float,Double\r\n  * Boolean:true,false\r\n  * Byte,Character:\\u0000--\\u007f(0-127)\r\n  * Short,Int,Long:-128-127\r\n  * Float,Double:没有缓存（常量池）\r\n* 基本类型的包装类和字符串有两种创建方式\r\n  1. 常量式（字面量）赋值创建，放在栈内存[^1]（将被常量化）\r\n  2. new对象进行创建，放在堆内存[^2]（不会常量化）\r\n* 分析Integet类\r\n  * 基本类型和包装类比较，将对包装类自动拆箱\r\n  * 对象比较，比较地址\r\n  * 加法 + 会自动拆箱\r\n* 分析String类\r\n  * 常量赋值（堆内存）和new创建（栈内存）不是用一个对象\r\n  * 编译器只会优化确定的字符串，并缓存\r\n\r\n# **常量设计和常量池总结**\r\n\r\n* Java种的常量：static和final\r\n\r\n* Java接口中的变量都是变量\r\n* 对象生成有两种：常量赋值（栈内存）和new创建（堆内存）\r\n* Java为Boolean,Byte,Character,Short,Int,Long,String的产量赋值建立常量池，没有包括Float和Double\r\n* Java编译器会优化已经确定的变量\r\n\r\n------\r\n\r\n# **不可变对象和字符串**\r\n\r\n* 不可变对象(Immutable Object)  \r\n  * 一旦创建，这个对象（状态/值）不能被更改了 \r\n  * 其内在的成员变量的值就不能修改了。\r\n  * 典型的不可变对象（ 八个基本型别的包装类的对象 ， String，BigInteger和BigDecimal等的对象 ）\r\n* 如何创建不可变对象 \r\n  * immutable对象是不可改变，有改变，请clone/new一个对 象进行修改 \r\n  * 所有的属性都是final和private的 \r\n  * 不提供setter方法 \r\n  * 类是final的（不让其他类继承而使该类不被修改），或者所有的方法都是final \r\n  * 类中包含mutable对象，那么返回拷贝需要深度clone \r\n* 不可变对象(Immutable Object)优点 \r\n  * 只读，线程安全 \r\n  * 并发读，提高性能 \r\n  * 可以重复使用 \r\n* 缺点 \r\n  * 制造垃圾，浪费空间 \r\n\r\n# **不可变对象和字符串总结**\r\n\r\n* 不可变对象提高读效率 \r\n* 字符串append操作速度：StringBuilder>StringBuffer>String \r\n\r\n------\r\n\r\n# **内置数据类型**\r\n\r\n* byte：\r\n  * byte数据类型是8位、有符号的，以二进制补码表示的整数；（256个数字），占1字节\r\n  * 最小值是-128（-2^7）；\r\n  * 最大值是127（2^7-1）；\r\n  * 默认值是0；\r\n  * byte类型用在大型数组中节约空间，主要代替整数，因为byte变量占用的空间只有int类型的四分之一；\r\n  * 例子：byte a = 100，byte b = -50。\r\n* short：\r\n  * short数据类型是16位、有符号的以二进制补码表示的整数，占2字节\r\n  * 最小值是-32768（-2^15）；\r\n  * 最大值是32767（2^15 - 1）；\r\n  * Short数据类型也可以像byte那样节省空间。一个short变量是int型变量所占空间的二分之一；\r\n  * 默认值是0；\r\n  * 例子：short s = 1000，short r = -20000。\r\n* int\r\n  * int数据类型是32位、有符号的以二进制补码表示的整数；占4字节\r\n  * 最小值是-2,147,483,648（-2^31）；\r\n  * 最大值是2,147,485,647（2^31 - 1）；\r\n  * 一般地整型变量默认为int类型；\r\n  * 默认值是0；\r\n  * 例子：int a = 100000, int b = -200000。\r\n* long\r\n  * long数据类型是64位、有符号的以二进制补码表示的整数；占8字节\r\n  * 最小值是-9,223,372,036,854,775,808（-2^63）；\r\n  * 最大值是9,223,372,036,854,775,807（2^63 -1）；\r\n  * 这种类型主要使用在需要比较大整数的系统上；\r\n  * 默认值是0L；\r\n  * 例子： long a = 100000L，int b = -200000L。\r\n* float\r\n  * float数据类型是单精度、32位、符合IEEE 754标准的浮点数；占4字节   -3.4*E38- 3.4*E38。。。浮点数是有舍入误差的\r\n  * float在储存大型浮点数组的时候可节省内存空间；\r\n  * 默认值是0.0f；\r\n  * 浮点数不能用来表示精确的值，如货币；\r\n  * 例子：float f1 = 234.5f。\r\n  * float f=6.26(错误  浮点数默认类型是double类型)\r\n  * float f=6.26F（转换正确，强制）\r\n  * double d=4.55(正确)\r\n* double\r\n  * double数据类型是双精度、64位、符合IEEE 754标准的浮点数；\r\n  * 浮点数的默认类型为double类型；\r\n  * double类型同样不能表示精确的值，如货币；\r\n  * 默认值是0.0d；\r\n  * 例子：double d1 = 123.4。\r\n* boolean\r\n  * boolean数据类型表示一位的信息；\r\n  * 只有两个取值：true和false；\r\n  * 这种类型只作为一种标志来记录true/false情况；\r\n  * 默认值是false；\r\n  * 例子：boolean one = true。\r\n* char\r\n  * char类型是一个单一的16位Unicode字符；用 ‘’表示一个字符。。java 内部使用Unicode字符集。。他有一些转义字符  ，2字节','2019-12-13 08:33:26','常量：一种不会修改的变量。1.Java没后constant关键字。2.不能修改，final。3.不会修改/只读/只要一份，static。一种特殊的产量：接口内定义的变量默认是常量','http://img0.imgtn.bdimg.com/it/u=2247329818,668470334&fm=26&gp=0.jpg','原创',b'1',b'1',b'0','Java基础（二）','2019-12-13 08:34:01',2,33,2),(57,b'0',b'0','#堆排序\r\n* 堆排序是利用堆这种数据结构而设计的一种排序算法，堆排序是一种选择排序，它的最坏，最好，平均时间复杂度均为O(nlogn)，它也是不稳定排序。首先简单了解下堆结构。\r\n#堆排序基本思想及步骤\r\n* 堆排序的基本思想是：将待排序序列构造成一个大顶堆，此时，整个序列的最大值就是堆顶的根节点。将其与末尾元素进行交换，此时末尾就为最大值。然后将剩余n-1个元素重新构造成一个堆，这样会得到n个元素的次小值。如此反复执行，便能得到一个有序序列了','2019-12-13 08:38:49','堆排序是利用堆这种数据结构而设计的一种排序算法，堆排序是一种选择排序，它的最坏，最好，平均时间复杂度均为O(nlogn)，它也是不稳定排序。首先简单了解下堆结构。','https://images2015.cnblogs.com/blog/1024555/201612/1024555-20161217182750011-675658660.png','转载',b'1',b'1',b'0','图解排序算法(三)之堆排序','2019-12-13 08:38:49',0,34,2),(58,b'1',b'1','#一、关于textarea文本域以及高度自适应\r\n* 作为多行文本域功能来讲，textarea满足了我们大部分的需求。然而，textarea有一个不足就是不能像普通div标签一样高度可以跟随内容自适应。textarea总是很自信地显摆它的滚动条，高度固执地岿然不动。所以，有时候，为了增加交互体验想让文本域高度自适应的时候，就会遇到麻烦。并不是不能实现，例如Google的Buzz的输入框就是高度自适应里面的内容的，如下截图：\r\n[![](http://image.zhangxinxu.com/image/blog/201012/2010-12-23_194525.png)](http://image.zhangxinxu.com/image/blog/201012/2010-12-23_194525.png)','2019-12-13 08:42:53','作为多行文本域功能来讲，textarea满足了我们大部分的需求。然而，textarea有一个不足就是不能像普通div标签一样高度可以跟随内容自适应。textarea总是很自信地显摆它的滚动条','https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1415136017,2874306992&fm=26&gp=0.jpg','转载',b'0',b'0',b'0','div模拟textarea文本域轻松实现高度自适应','2019-12-13 08:42:53',0,36,2),(59,b'1',b'0','#评论系统\r\n\t常见的评论系统主要有三种：楼中楼模式、 流模式 和引用模式 （都是我自己起的名字），下面集中介绍这三种的优劣势以及实现方法。\r\n##一、楼中楼模式\r\n\t所谓楼中楼模式，就是每条评论占一楼，针对该评论的所有回复都在该楼里展现，比如百度贴吧、简书的评论系统。\r\n\t优势：回复评论的内容集中展现，易于了解评论引发的对话。 \r\n\t劣势：内容过多时需要做分页处理，较为复杂。 \r\n\t数据表设计：\r\n\r\n* id（自增主键）\r\n* target_id （评论主题的id，可根据需要修改为article_id、course_id等等）\r\n* parent_id(主评论id）\r\n* reply_uid (记录被评论的用户id，回复主评论时可以0）\r\n* uid（发表评论的用户id）\r\n* content （评论内容）\r\n* 其他字段… （时间、状态等）\r\n##二、流模式\r\n##三、引用模式','2019-12-13 08:50:03','常见的评论系统主要有三种：楼中楼模式、 流模式 和引用模式 （都是我自己起的名字），下面集中介绍这三种的优劣势以及实现方法。','http://img3.imgtn.bdimg.com/it/u=193866303,3415224312&fm=26&gp=0.jpg','转载',b'1',b'0',b'1','评论系统--开发总结','2019-12-13 08:50:03',0,32,2);

#
# Structure for table "t_comment"
#

DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `blog_id` bigint(20) DEFAULT NULL,
  `parentComment_id` bigint(20) DEFAULT NULL,
  `adminComment` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKke3uogd04j4jx316m1p51e05u` (`blog_id`),
  KEY `FK49ra5rh6rkwpv5qldcugta78r` (`parentComment_id`),
  CONSTRAINT `FK49ra5rh6rkwpv5qldcugta78r` FOREIGN KEY (`parentComment_id`) REFERENCES `t_comment` (`id`),
  CONSTRAINT `FKke3uogd04j4jx316m1p51e05u` FOREIGN KEY (`blog_id`) REFERENCES `t_blog` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

#
# Data for table "t_comment"
#

INSERT INTO `t_comment` VALUES (71,'https://picsum.photos/id/447/110/110','欢迎大家评论','2019-12-12 15:20:33','hh@163.com','RAYMOND',55,NULL,b'1'),(72,'https://picsum.photos/id/447/110/110','测试评论','2019-12-12 15:20:49','hh@163.com','RAYMOND',55,NULL,b'1'),(73,'https://picsum.photos/id/447/110/110','测试回复博主','2019-12-12 15:21:10','hh@163.com','RAYMOND',55,72,b'1'),(74,'https://picsum.photos/110/110','小白评论','2019-12-12 15:43:38','xiaobai@163.com','小白',55,NULL,b'0'),(75,'https://picsum.photos/110/110','小黑评论','2019-12-12 15:45:20','xiaohei@163.com','小黑',55,NULL,b'0'),(76,'../upload/RA.jpg','测试生成英文头像','2019-12-12 21:22:19','raym@163.com','raym',55,NULL,b'0'),(77,'../upload/li.jpg','测试生成英文头像2','2019-12-12 21:25:05','li@163.com','li',55,NULL,b'0'),(78,'../upload/AL.jpg','测试生成英文头像3','2019-12-12 21:46:51','alia@163.com','alia',55,NULL,b'0'),(79,'../upload/aa.jpg','测试生成英文头像4','2019-12-12 21:47:53','aa@163.com','aa',55,NULL,b'0'),(80,'../upload/aa.jpg','回复aa','2019-12-12 21:48:17','aa@163.com','aa',55,79,b'0'),(81,'../upload/ca.jpg','ca','2019-12-12 21:48:31','ca@163.com','ca',55,NULL,b'0'),(82,'../upload/杰伦.jpg','测试生成中文头像','2019-12-12 21:49:11','jielun@163.com','杰伦',55,NULL,b'0'),(83,'../upload/不败.jpg','测试生成四字中文头像','2019-12-12 21:49:53','dongfangbubai@163.com','东方不败',55,NULL,b'0'),(84,'../upload/li.jpg','回复raym','2019-12-12 21:51:11','li@163.com','li',55,76,b'0'),(85,'../upload/始皇.jpg','测试生成秦始皇中文头像','2019-12-12 21:53:10','qinshihuang@163.com','秦始皇',55,NULL,b'0'),(86,'../upload/TH.jpg','测试回复生成Thomas英文头像','2019-12-12 21:54:14','thomas@163.com','Thomas',55,85,b'0'),(87,'../upload/存储.jpg','存储','2019-12-13 10:14:30','isLizx@163.com','存储',56,NULL,b'0');

#
# Structure for table "t_blog_t_tag"
#

DROP TABLE IF EXISTS `t_blog_t_tag`;
CREATE TABLE `t_blog_t_tag` (
  `blogs_id` bigint(20) NOT NULL,
  `tags_id` bigint(20) NOT NULL,
  KEY `FKhl5bn19gf2sq5o31s7amn0l1t` (`tags_id`),
  KEY `FKk1nf67s05jh2pbvf45gmhvhja` (`blogs_id`),
  CONSTRAINT `FKhl5bn19gf2sq5o31s7amn0l1t` FOREIGN KEY (`tags_id`) REFERENCES `t_tag` (`id`),
  CONSTRAINT `FKk1nf67s05jh2pbvf45gmhvhja` FOREIGN KEY (`blogs_id`) REFERENCES `t_blog` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "t_blog_t_tag"
#

INSERT INTO `t_blog_t_tag` VALUES (55,8),(55,10),(56,8),(56,10),(57,8),(57,15),(57,16),(57,14),(58,18),(58,17),(59,17);
