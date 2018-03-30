*********************************************************
 *Editor:Sublime
 *Description:甲骨文基础2
 *Date&Time:2018-03-30 8:30
 *Modify[1]:张帅,2018-03-30，Oracle与Java综合应用2
*********************************************************
一、预编译技术（企业级软件开发常用）
	conn->st->rs   （标准处理的三个对象）
	conn->st->rs   （预处理三个对象）

	1.通用的语句对象
	Statement  st = null;   //声明并初始化为空
	st = conn.createStatement();  //由连接对象创建语句对象
	st.executeQuery(sql);   //执行SQL语句   -DQL
	st.executeUpdate(sql);  //执行SQL增删改语句  -DML

	2.预处理的语句对象
	PreparedStatement ps = null;
	ps = conn.prepareStatement(sql);
	ps.executeQuery();  //执行查询     DQL
	ps.executeQuery();  //执行增删改   DML

	ps与st在设置SQL语句时，写法不一样
	ps处理SQL语句时，其中有英文的问号-预设占位符'?'
	String sql = "SELECT * FROM INFO WHERE ID=?";

	st处理SQL语句时，不用提前预设占位符'?'
	String sql = "SELECT * FROM INFO WHERE ID=1000";

	为了完成前后台交互，要多使用ps预处理对象！
	占位符可以是常量，也可以是变量。

	//使用预编译技术时，要考虑两个步骤
	//1.给SQL语句中预设的占位符？完成赋值
	取值： getX()
	设置： getX()
	X-代表数据类型  int/double/float/String/boolean...

	setInt(1,6);//给第1个占位符？赋值为整数66
	setInt(2,"西瓜") 
	//给第二个占位符赋值为字符串"西瓜"

	【如果定义的SQL中没有占位符'?'，无需使用setX()设值。】
	
	//2.再执行相关操作（执行查询或执行更新）
	ps.executeQuery();
	ps.executeUpdate();



	[补充]：SQL语句的分类
	1.DDL -Data Definition Language      数据定义语言
	2.DML -Data Manipulation Language    数据操纵语言
	3.DQL -Data Query Language           数据查询语言
	4.DCL -Data Control Language         数据控制语言
	5.TCL -Transaction Control Language  事务控制语言

	分析：
	1.DDL：
	作用：定义数据库中用户、表空间、表、角色、视图等对象
	关键词：CREATE  ALTER  DROP

	2.DML:
	作用：控制数据处理，完成增加、修改和删除操作
	关键词：INSERT  UPDATE  DELETE

	3.DQL:
	作用：数据的查询
	关键词：SELECT

	4.DCL:
	作用：完成授权与撤销工作
	关键词：GRANT  REVOKE

	5.TCL:
	作用：完成事务管理工作，包括提交、回滚、保存点
	关键词：COMMIT  ROLLBACK  SAVEPOINT

	【实训1】：
	工程：SMART V1.0
	包：cn.tedu.pre
	类：PreSelect

	最终文档结构：
	cn.tedu.db  包中应有四个类：(适用标准语句对象 st)
	SelectData/InsertData/UpdateData/DeleteData

	cn.tedu.pre  包中应有四个类：(使用预处理对象 ps)
	查询类：PreSelect
	增加类：PreInsert
	修改类：PreUpdate
	删除类：PreDelete

二、甲骨文备份与还原技术
[注意]：
甲骨文的备份与还原都是基于DOS环境完成的。
命令后面不能有分号
主要使用命令如下：
import 和 export      -缩写  imp/exp  (简单)
import dump 和 export dump -缩写  imddp/expdp (复杂)

建议备份时，先在DOS系统下，用CD命令跳转到保存备份文件的目录下
CD.			-跳转到当前目录下
CD..		-跳转到上级目录下
CD\			-跳转到根目录下（磁盘）
CD 目录名	-跳转到指定的目录下

MD -创建目录 -Make Directory
RD -删除目录 -Remove Directory
CD -更改目录 -Change Directory -(跳转目录)
DIR -显示目录及其中的子目录和文件，Directory


【方法一：常规技术】：
命令：
export -导出  -备份  -Backup
import -导入  -还原  -Restore/Recovery
环境：仅适用于服务器
效率：一般，较慢
【甲骨文备份】：
1.完全模式-FULL
[格式]：
EXP 用户/密码[@数据库实例] FILE=备份的位置/备份文件.DMP  FULL=Y
[示例]：备份所有用户的所有表结构和数据
EXP scott/tiger@orcl  FILE=D:/BACKUP/FULL20180330.DMP  FULL=Y


2.用户模式-OWNER
[格式]：
EXP 用户/密码[@数据库实例] FILE=备份的位置/备份文件.DMP OWNER=用户名

[示例]：
EXP scott/tiger@orcl  FILE=D:/BACKUP/FULL20180330.DMP OWNER=scott

3.表模式-TABLE
[格式]：
EXP 用户/密码[@数据库实例] FILE=备份的位置/备份文件.DMP TABLES=表1，表2...

[示例]：
EXP scott/tiger[@数据库实例] FILE=D:/backup/FULL20180330.DMP TABLES=EMP,DEPT



【方法二：数据泵技术】：
命令：
export dump -导出  -expdp  -备份  -Backup
import dump -导出  -imdpd  -还原  -Restore/Recovery

环境：仅适用于服务器
效率：高级，较快























