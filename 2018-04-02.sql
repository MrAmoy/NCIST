*********************************************************
 *Editor:Sublime
 *Description:甲骨文基础2
 *Date&Time:2018-04-02 8:30
 *Modify[1]:张帅,2018-04-02，Oracle与Java综合应用2
*********************************************************
一、DAO
	Data Access Object  数据访问对象
	为了完成数据库各项功能，避免大量代码重复，实现“一次编写，反复利用”的目的，引进了DAO，这种技术可以提高编程效率，增强代码复用性。DAO技术将数据库的功能封装在特定方法中，精简代码，反复利用。

	VO -Value Object  值对象  -根据数据表中的各列产生的对象
	JavaBean  -将表对象的各个属性统一放在一个类中，通过set X()方法设置不同的值，通过getX()方法获取不同的值。各个值、各个属性对应的是表中各列（各字段）！这样可以方便前后台交互。

二、开发示例：
	【实训1】封装表对象GOODS的属性，完成商品表对应的列设值和取值
	统一：在SMART V1.0 工程中，包cn.tedu.vo,类 Goods
	先设计好表对象的各属性，对应表中的列；
	然后再根据这些属性产生方法：
	至少1个构造方法-与类名相同，无参方法1个；有参方法1个
	n个set方法-set开头的方法，后面跟列名
	n个get方法-get开头的方法，后面跟列名

	1.构造方法快速编写的步骤：
	右击类中的空白处->Source->Generate Constructor using Fields(使用字段生成构造方法)->无参构造方法：要点击Deselect All->有参构造方法：要点击Select All
	2.get/set方法快速编写的步骤：
	右击类中的空白处->Source->Generate Getter and Setter(生成get方法和set方法)->Select All->OK


	【实训2】封装表对象INFO的属性，完成信息表对应的列设值和取值
	统一：在SMART V1.0 工程中，包cn.tedu.vo,类 Info

	【实训3】将数据处理的功能封装在类DBUtil中，完成六种常见的功能：连接数据库、关闭对象，增加数据，删除数据、修改数据、查询数据（分别编写不同的方法）
	getConn()
	getClose()
	selects()
	inserts()
	updates()
	deletes()

	统一：在SMART V1.0 工程中，包cn.tedu.dao,类 DBUtil
















