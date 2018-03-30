*********************************************************
 *Editor:Sublime
 *Description:甲骨文基础2
 *Date&Time:2018-03-28 8:30
 *Modify[1]:张帅,2018-03-28,Oracle技术提高
*********************************************************
一、Oracle学习的流程补充
[准备]：
给DIAOCHAN用户，创建表ADMIN
CREATE TABLE ADMIN (
	AID NUMBER(9)  NOT NULL,
	ANAME VARCHAR2(20)  NULL,
	AGE  NUMBER(3)   NULL
);
[查询当前用户所有的表]：
SELECT TABLE_NAME FROM USER_TABLES;  --查询物理表TABLE

SELECT * FROM TAB;  --查物理表TABLE和视图VIEW

【思考】：
管理员SYS有多少物理表？有多少虚表（视图）？总计多少？
	物理表：SELECT COUNT(TABLE_NAME) FROM USER_TABLES;
	视图：SELECT COUNT(TNAME) FROM TAB WHERE TABTYPE='VIEW';
	总计：SELECT * FROM TAB;

==============================================================
Step 5：结构设计

1.数据表结构修改

1.1 增加列 -ADD
	[格式]：
	ALTER TABLE 表名 ADD 新列名1 数据类型（宽度） 约束;
	[示例]：
	ALTER TABLE ADMIN ADD TEL VARCHAR2(15) NULL; --电话
	ALTER TABLE ADMIN ADD GENDER VARCHAR2(2) NULL;--性别


1.2 删除列 -DROP-要加关键字COLUMN
	[格式]：
	ALTER TABLE 表名 DROP COLUMN 列名;
	[示例]：
	ALTER TABLE ADMIN DROP COLUMN TEL;

1.3 修改列的属性 -MODIFY -针对列的数据类型、宽度、约束
	[格式]：
	ALTER TABLE 表名 MODIFY 列名 新数据类型(新宽度) 新约束;
	[示例]：
	ALTER TABLE ADMIN MODIFY GENDER NUMBER(4) NULL;

1.4 重命名列 -RENAME
	[格式]：
	ALTER TABLE 表名 RENAME COLUMN 旧列名 TO 新列名;
	[示例]：
	ALTER TABLE ADMIN RENAME COLUMN GENDER TO SEX;

1.5 重命名表 -RENAME
	[格式]：
	RENAME 旧表名 TO 新表名;
	[示例]：
	RENAME ADMIN TO ADMIN1;

2.删除表
	[格式]：
	DROP TABLE 表名;
	[示例]：
	DROP TABLE ADMINS;
如何清空删除后产生的垃圾表？
PURGE RECYCLEBIN;  --清空回收站


Column  -列 -Field 字段（纵向）
Row		-行 -Record（横向）
==============================================================
Step 6：数据处理
七字秘诀：库列表+增删改查
orcl->INFO/GOODS->3列/6列 （结构）

1.增加数据
[格式]：
INSERT INTO 表名[(列名1，列名2...)] VALUES();
[示例]：
INSERT INTO INFO VALUES(1,'ZHANG','123456');
INSERT INTO INFO VALUES(2,'WANG','123123');
INSERT INTO INFO VALUES(3,'ZHAO','ROOT');

2.删除数据
[格式]：
DELETE FROM 表名;   --默认全部删除，慎重！！（低效）
DELETE FROM 表名 WHERE 条件子句;  --删除符合指定条件的数据
TRUNCATE TABLE 表名;  --删除全部数据和结构（高效）

TRUNCATE -截断、清空    PURGE-清空  CLEAR-清除
CLEAR SCREEN;  -清屏

[示例]：
DELETE FROM INFO;
DELETE FROM INFO WHERE ID=2;

3.修改数据
[格式]：
3.1 UPDATE 表名 SET 列1=新值1,列2=新值2...;  --修改全部数据（慎用）
3.2 UPDATE 表名 SET 列1=新值1,列2=新值2... WHERE 条件子句; --修改指定数据  
[示例]：
UPDATE INFO SET USERNAME='ZHAOSAN',PASSWORD=654321;
UPDATE INFO SET USERNAME='ZHAOSAN',PASSWORD=654321 WHERE ID=3;

4.查询数据
[格式]：
4.1 查询全部数据(所有列)
SELECT * FROM 表名;
4.2 查询那部分数据（指定列）
SELECT 列1,列2,列3 FROM 表名;

[示例]：
SELECT * FROM INFO;
SELECT USERNAME,PASSWORD FROM INFO;



【补充】：
1.快速备份表的结构和数据
[格式]：
CREATE TABLE 新表 AS SELECT * FROM 旧表;
[示例]：
CREATE TABLE INFO1 AS SELECT * FROM INFO;

2.快速备份表的结构
[格式]：
CREATE TABLE 新表 AS SELECT * FROM 旧表 WHERE 不成立的条件;
[示例]：
CREATE TABLE INFO1 AS SELECT * FROM INFO WHERE 1=2;



=============================================================
【实训1】：
根据系统开发需求，设计两个表的结构：
1.信息表(INFORMATION)
结构如下：
ID    编号  整数(9)     主键
NAME  姓名  字符串(20)  可空
PWD   密码  整数(6)     可空
//建表
CREATE TABLE INFORMATION(
	ID NUMBER(9) PRIMARY KEY,
	NAME VARCHAR2(20) NULL,
	PWD NUMBER(6) NULL
)
//增加一列
ALTER TABLE INFORMATION ADD LEVEL1 NUMBER(1) NULL;
//删除一列
ALTER TABLE INFORMATION DROP COLUMN LEVEL1;
//修改列名
ALTER TABLE INFORMATION RENAME COLUMN NAME TO USERNAME;
ALTER TABLE INFORMATION RENAME COLUMN PWD TO PASSWORD;
//修改表列的类型
ALTER TABLE INFORMATION MODIFY PASSWORD VARCHAR2(10);
//修改表名
RENAME INFORMATION TO INFO;

2.商品表(GOODS)
ID     商品编号  整数(9)     主键
NAME   商品名称  字符串(20)  可空
PRICE  商品价格  小数(6,2)   可空
BRAND  商品品牌  字符串(20)  可空
COLOR  商品颜色  字符串(10)  可空
PLACE  商品产地  字符串(20)  可空
//创建表
CREATE TABLE GOODS(
	ID NUMBER(9) PRIMARY KEY,
	NAME VARCHAR2(20) NULL,
	PRICE NUMBER(6,2) NULL,
	BRAND VARCHAR2(20) NULL,
	COLOR VARCHAR2(10) NULL,
	PLACE VARCHAR2(20) NULL
);
【实训2】：
1.
INSERT INTO INFO VALUES (4,'DIAOCHAN','123456');

2.
INSERT INTO GOODS VALUES (1001,'西瓜','30','甜味','绿色','燕郊');
INSERT INTO GOODS VALUES (1002,'烤鸭','20','美味','绿色','北京');
INSERT INTO GOODS VALUES (1003,'大米','15.5','美味','绿色','成都');
INSERT INTO GOODS VALUES (1004,'黄瓜','24','甜味','绿色','上海');
INSERT INTO GOODS VALUES (1005,'茄子','36','甜味','绿色','重庆');

【实训3】：
通过JAVA编程，完成数据库的连接、关闭、查询！

项目Project：SMART V1.0
包Package：  cn.tedu.db
类Class：    SelectData

SGMS V1.0 -Smart Goods Management System Version 1.0
		  -智能商品管理系统 V1.0

开发环境：JDK7+TOMCAT7+Eclipse 4.3/MyEclipse 10.0以上
推荐：JDK8+TOMCAT8+Eclipse 4.5.2
[数据库]：
Oracle 11g Enterprice Edtion
[辅助工作]：
Sublime Text 3/Editplus/UltrEditor

[关键技术]：
Java技术+JDBC技术+窗体技术

[JDBC]：
Java语言=============JDBC============SQL语言
高级程序语言  ==============  数据库结构化查询语言

JDBC  -架桥 翻译
JDBC的作用：
（1）创建数据库连接
（2）执行不同的SQL语句
（3）输出相应的结果

1.JDBC技术的六步法：
加载驱动->创建连接对象->创建语句对象->执行SQL语句->输出结果->关闭对象

口诀：加-连-语-执-出-关

2.连接不同数据库的六要素：

驱动类型   服务器   端口   数据库   用户   密码
driver     server   port   db       user   password
=========================================================
Step 1:加载驱动
（1）加载驱动包-由不同的数据库提供不同的JAR包
Oracle - ojdbc14.jar -钢铁
MySQL  - mysql-*.jar -石头
SQLServer -sqljdbc.jar -木头

（2）在类中加入不同数据库的驱动类（包名.类名）
流程：
找到包cn.tedu.db->右击创建类SelectData->编写main()方法-程序的主入口->在主方法中编写Class.forName()->加载甲骨文JAR中的数据库驱动主类->添加异常处理代码块，用try...catch代码块环绕

甲骨文驱动程序主类
Class.forName("oracle.jdbc.driver.OracleDriver");

MySQL驱动程序主类：
Class.forName("com.mysql.jdbc.Driver");

MSSQL(SQL Server)驱动程序主类：
Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");


===============================================================
【甲骨文中的数据类型】：
1.NUMBER(m,n)  数字 -m 整数 代表数字的总个数
					-n 整数 代表小数点后的数字个数
					NUMBER 包括 int short long float double
2.VARCHAR2  字符串
	CHAR		-定长字符串，默认2个字符，最大值255
	VARCHAR 	-变长字符串，最大字符个数2000
	VARCHAR2	-变长字符串，最大字符个数4000

	分析：“China”存储在不同数据类型中的情况
	CHAR(20)		-固定长度为20，占内存单元20
	VARCHAR(20)		-可变化长度，占内存单元5  -节约内存空间
	VARCHAR2(20)	-可变化长度，占内存单元5  -节约内存空间

	Variable Character  可变化的字符串

3.CLOB/BLOB  大数据对象
	Character Large OBject   -CLOB
	Binary    Large OBject   -BLOB
	可以存储大数据，适合图片，音频，视频。

4.DATE/TIME   日期/类型

【甲骨文中的约束】：
Primary Key    -主键   PK
Foreign Key    -外键   FK
Check          -检查   CK
Not Null/Null  -非空   NN
Unique         -唯一   UK
Default        -默认   DEF (缺省)

目的：保证数据的完整性，可靠性，减少冗余和错误。

说明或注释：COMMENT ON COLUMN 表名.列名 IS "说明文字";














