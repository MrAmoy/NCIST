*********************************************************
 *Editor:Sublime
 *Description:甲骨文基础2
 *Date&Time:2018-03-29 8:30
 *Modify[1]:张帅,2018-03-29,Oracle与Java综合应用1
*********************************************************
一、JDBC技术之一：数据库连接
1.标准流程：
加载驱动->创建链接->创建语句->执行语句->输出结果->关闭对象

【开头->中间->结尾】
加-连   /语-执-出/  关

2.关键点：
（1）加载驱动：
分两步：在工程中加载数据库JAR包/编程找到驱动的主类

（2）创建链接：
要注意六要素。
要注意三个字符串，通过4+1+1解决赋值。
最后通过六要素连接到指定服务器的数据库上。
Class  -C类   Interface  -I  接口

如果在静态方法static main()中调用变量，变量也必须为static静态的！
-全局变量-定义在类中（推荐）

如果在静态方法static main()中，调用变量时，将变量定义在方法中，无需修饰符static-局部变量-定义在方法中

六要素：4+1+1
通过三个字符串变量解决！
	url  -united resource locator  统一资源定位符
	String url ="jdbc:oracle:thin://127.0.0.1:1521:orcl";//定义统一资源定位符，解决4要素-驱动类型-服务器-端口-服务器
	String user ="DIAOCHAN";//定义第5个要素：用户名
	String password ="123123";//定义第6个要素：密码
	调用六要素：
	DriverManager.getConnection(url,user,password);

（3）创建语句
	//提前定义三个连接对象
    Connection conn = null;  //定义连接对象并初始化为空
    Statement st = null;     //定义语句对象并初始化为空
    ResultSet rs = null;     //定义结果集对象并初始化为空

	//提前定义SQL语句，以方便语句对象去执行
    String sql = "SELECT * FROM GOODS"; //查所有商品
    String sql1 = "SELECT * FROM INFO"; //查所有用户

    三个对象关系：
    conn->st->rs

    连接对象conn：通过获取连接（通过六要素）getConnection()，得到conn语句对象：通过连接对象createStatement()，得到st结果集对象：通过语句对象executeQuery()，得到rs

（4）执行语句
//第四步：执行语句
rs = st.executeQuery(sql);




（5）输出结果
//遍历查询结果集中的每个字段（列），就可以看到所有的数据
//循环
for() -循环次数确定的情况下
while()  -循环次数不确定的情况  ****

rs.next()  -返回布尔值-真或假  真-有值  假-无值
得到是数据结果集中的游标-类似指针，逐条读取结果集中的记录值
每条记录（横向）是由若干列（纵向）合成的！
整个表:是由横向和纵向交叉形成的（一个个单元格-从横交叉）

从结果集中取值:-方法调用是由系统结构设计时表的结构确定
getInt()		getShort()		getLong() 	-获取整数
getDouble()		getFloat()		  			-获取小数
getString()									-获取字符串
getBoolean()								-获取布尔值
getDate()									-获取日期

//1.列索引
System.out.println(rs.getInt(1) + "\t" + rs.getString(2) + "\t" + rs.getDouble(3) + "\t" + rs.getString(4) + "\t" + rs.getString(5) + "\t" + rs.getString(6));
//2.列标签
System.out.println(rs.getInt("ID") + "\t" + rs.getString("NAME") + "\t" + rs.getDouble("PRICE") + "\t" + rs.getString("BRAND") + "\t" + rs.getString("COLOR") + "\t" + rs.getString("PLACE"));

【强调】：
在使用命令行或工具，进行甲骨文数据处理（含增删改查）时，最后一律提交一下，这样，数据就会持久化保存。
（提交命令：commit）
（回滚命令：rollback）

（6）关闭对象

数据处理完毕后，最后应该关闭所有对象，以释放系统资源（CPU/MEMORY）
编程到后期，

【重要内容】：开发系统，需要通过对象调用不同的方法
JDBC技术中，与数据库相关的常用对象
Connection        -连接对象           -conn/con/connection/c
Statnment         -语句对象           -st/stat/statnment/s
PreparedStatement -语句对象（预处理） -ps/prep/p
ResultSet         -结果集对象         -rs/rSet/result/r

具体开发时，可采用两种方案：（只用到两到三个对象）
（1）conn/st/rs -查询   conn/st   -增删改  -基本应用
（2）conn/ps/rs -查询   conn/st   -增删改  -高级应用


二、JDBC技术之二：数据库查询-SelectData
	六步法：加-连-语-执-出-关
	三对象：conn/st/rs
	执行查询方法：executeQuery()
	查询语句属于：DQL  -Data Query Language  数据查询语言

三、JDBC技术之三：数据库增加-InsertData
	五步法：加-连-语-执-出(略)-关
	两对象：conn/st
	执行查询方法：executeUpdate()
	查询语句属于：DML  -Data Manipulation Language  数据操纵语言
	（包括三种操纵：增加、修改、删除）
	Update更新：insert update(修改) delete
	增改删会使记录总数发生变化（变多或变少），记录值发生改变。

	关于异常处理两种措施：
	一是使用try...catch[...finally]环绕
	二是使用throws Exception抛出。

	try{
		//正确编码
	} catch () {
		//异常或错误代码
	} finally {
		//无论对错，都会执行的编码。
	}

	【比较】：执行SQL语句三种方法
	executeQuery()  -返回结果集rs            -查询
	executeUpdate() -返回整数，受影响的行数  -增改删
	execute()       -返回布尔值，真假        -增删改查



四、JDBC技术之四：数据库修改-UpdateData
	参照三。SQL语句不同。

五、JDBC技术之五：数据库删除-DeleteData
	参照三。


==============================================================
【实训1】：
加载甲骨文数据库驱动，并用DIAOCHAN用户连接到数据库orcl。


