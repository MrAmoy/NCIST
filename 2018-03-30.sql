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
1.完全模式-FULL-所有用户（多）
	[格式]：
	EXP 用户/密码[@数据库实例] FILE=备份的位置/备份文件.DMP  FULL=Y

	[示例]：备份所有用户的所有表结构和数据
	EXP scott/tiger@orcl  FILE=D:/BACKUP/FULL20180330.DMP  FULL=Y


2.用户模式-OWNER-默认导出的模式-指定用户（单）
	[格式]：
	EXP 用户/密码[@数据库实例] FILE=备份的位置/备份文件.DMP OWNER=用户名

	[注意]：
	如果按用户模式，导出多个用户，则在用户之间用英文逗号分隔！

	[示例]：
	EXP scott/tiger@orcl  FILE=D:/BACKUP/FULL20180330.DMP OWNER=scott,xishi
	相当于：
	EXP scott/tiger@orcl  FILE=D:/BACKUP/FULL20180330.DMP OWNER=scott
	EXP scott/tiger@orcl  FILE=D:/BACKUP/FULL20180330.DMP OWNER=xishi

3.表模式-TABLE
	[格式]：
	EXP 用户/密码[@数据库实例] FILE=备份的位置/备份文件.DMP TABLES=表1，表2...

	[注意]：
	如果按表模式，导出多个指定表，则在表之间用英文逗号分隔！

	[示例]：
	推荐：
	EXP scott/tiger[@数据库实例] FILE=D:/backup/FULL20180330.DMP TABLES=EMP,DEPT
	相当于：
	EXP scott/tiger[@数据库实例] FILE=D:/backup/FULL20180330.DMP TABLES=EMP
	EXP scott/tiger[@数据库实例] FILE=D:/backup/FULL20180330.DMP TABLES=DEPT

【甲骨文中用户scott的表分析】：4张表
SQLPLUS /NOLOG
GRANT CONNECT,RESOURCE,DBA TO SCOTT;
CONN SCOTT/tiger;
SHOW USER;
SELECT * FROM TAB;

四张表详情：
1.BONUS		-福利表（奖金、津贴、补助）-4列
	ENAME	-员工姓名
	JOB		-工作岗位
	SAL 	-基本工资
	COMM 	-额外收入

2.DEPT 		-部门表  -Department -3列
	DEPTNO 	-部门编号
	DNAME	-部门名称
	LOC		-部门位置 -Location

3.EMP 		-员工表 	-Employee （重要） -8列
	EMPNO	-员工编号
	ENAME	-员工姓名
	JOB		-员工岗位
	MGR		-上级领导
	HIREDATE-聘用日期
	SAL 	-基本工资
	COMM 	-额外收入
	DEPTTNO -部门编号

4.SALGRADE 	-工资等级表 -Salary Grade -3列
	GRADE 	-工资等级
	LOSAL 	-最低工资 Lowest Salary
	HISAL 	-最高工资 Highest Salary


【甲骨文还原】：

1.完全模式-FULL-所有用户（多）
	[格式]：
	IMP 用户/密码[@数据库实例] FILE=备份的位置/备份文件.DMP  FULL=Y

	[示例]：备份所有用户的所有表结构和数据
	IMP scott/tiger@orcl  FILE=D:/BACKUP/FULL20180330.DMP  FULL=Y


2.用户模式-OWNER-默认导出的模式-指定用户（单）
	[格式]：
	情况一：（不跨用户，还给自己）
	IMP 用户/密码[@数据库实例] FILE=备份的位置/备份文件.DMP FROMUSER=用户名1 TOUSER=用户名1

	情况二：（跨用户，还给他人）
	IMP 用户/密码[@数据库实例] FILE=备份的位置/备份文件.DMP FROMUSER=用户名1 TOUSER=用户名2

	[示例]：
	情况一：（不跨用户，还给自己）
	IMP scott/tiger@orcl  FILE=D:/BACKUP/FULL20180330.DMP FROMUSER=scott TOUSER=scott

	情况二：（跨用户）
	IMP scott/tiger@orcl  FILE=D:/BACKUP/FULL20180330.DMP FROMUSER=scott TOUSER=diaochan


3.表模式-TABLE
	[格式]：
	IMP 用户/密码[@数据库实例] FILE=备份的位置/备份文件.DMP TABLES=表1，表2...

	[注意]：
	如果按表模式，导入多个指定表，则在表之间用英文逗号分隔！

	[示例]：
	推荐：
	IMP scott/tiger[@数据库实例] FILE=D:/backup/FULL20180330.DMP TABLES=EMP,DEPT
	相当于：
	IMP scott/tiger[@数据库实例] FILE=D:/backup/FULL20180330.DMP TABLES=EMP
	IMP scott/tiger[@数据库实例] FILE=D:/backup/FULL20180330.DMP TABLES=DEPT

	[注意]：
	采用什么模式备份，必须采用相应模式还原！
	FULL<->FULL     OWNER<->USER   TABLE<->TABLE

	采用FULL/TABLE格式备份，还原时，只要修改EXP为IMP

	但是，OWNER格式备份后，还原要适当变化！
	FROMUSER=从来源用户   TOUSER=还原给指定目标用户
	分两种情况：
	A. 还给自己     来源用户与目标用户  -相同（不跨用户）
	B. 还给别人     来源用户与目标用户  -不同（跨用户）

	[甲骨文空表导出策略]：
	系统开发中，有些特殊的表，只有结构，没有数据，称为空表。空表是不可忽略的，一旦使用空表，因人为破坏或者自动备份忽略掉了，系统会报错。

	甲骨文为了节省空间，默认是不会导出空表的！
	控制空表导出，依靠一个重要的参数：
	DEFERRED_SEGMENT_CREATION      断延迟创建（延迟，延期）

	查看系统断延迟参数：
	***show parameters deferred_segment_creation;
	修改断延迟参数的值：
	alter system set deferred_segment_creation=false scope=both
	alter system set deferred_segment_creation=true  scope=both
	此参数类型为布尔型，取值分别为真或假。
	默认值为真。
	当参数为真时，不会导出空表。
	当参数为假时，就会导出空表。
	所以，建议在创建表时，提前设置此参数为假FALSE，后面的空表都会导出。

	[scope范围取值问题]：
	scope=memory  内存   -读写速度快，但一断电就消失。  ns-纳秒（速度快）
	scope=spfile  系统进程文件（硬盘） -读写速度慢，持久化存储，断电不会消失  ms-毫秒（保存长久）
	scope=both  兼顾上两种优点，读写既快速又能保存持久****

	解决空表导出的建议：
	1.建表前，先设置断延迟参数为假，保证之后的所有空表导出；
	2.建表后，设置断延迟参数为假，对之前的空表都是无法导出的，只对之后的空表有效。此类情况，建议，在空表中插入任意一条记录，可保留也可删除此纪录。这样，空表就可以导出。
	甲骨文公司规定：表中无值，不会分配空间给表；

	甲骨文逻辑分区：（从大到小）
	Tablespace->segment(Table)->extend->Block(uniform)



【方法二：数据泵技术】：
	命令：
	export dump -导出  -expdp  -备份  -Backup
	import dump -导出  -imdpd  -还原  -Restore/Recovery

	环境：仅适用于服务器
	效率：高级，较快
