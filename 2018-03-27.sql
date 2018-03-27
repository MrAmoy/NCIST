*********************************************************
 *Editor:Sublime
 *Description:甲骨文基础
 *Date&Time:2018-03-27 8:30
 *Modify[1]:张帅,2018-03-27,软件开发准备（Oracle）
*********************************************************

一、Oracle学习的流程
	六步法：
		用户管理->表空间管理->匹配管理->权限管理->结构设计->数据处理
	五步法：
		表空间管理->用户管理（同步完成匹配管理）->权限管理->结构设计->数据处理
=============================================================
Step 1：用户管理
	1.1 创建用户
		[格式]：
			CREATE USER 用户 IDENTIFIED BY 密码;
		[示例]：
			CREATE USER xiaojiang IDENTIFIED BY 123456;

	1.2 删除用户
		[格式]：
			DROP USER 用户[CASCADE];
		[示例]：
			DROP USER xiaojiang CASCADE;  --推荐
			DROP USER xiaojiang;

		CASCADE-层级、层叠
		IDENTIFIED-验证

	1.3 查询用户
		1.3.1 查询用户名
			SELECT USERNAME FROM DBA_USERS;

		1.3.2 查询所有用户和账户的状态
			SELECT USERNAME,ACCOUNT_STATUS FROM DBA_USERS;
		1.3.3 查询所有用户、账户状态、默认表空间
			SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE FROM DBA_USERS;

		1.4 修改用户
			[格式]：
			修改用户的状态-解锁：
				ALTER USER 用户名 ACCOUNT UNLOCK;
			修改用户的状态-锁定：
				ALTER USER 用户名 ACCOUNT LOCK;
			修改用户的状态-过期（相当于重置密码）：
				ALTER USER 用户名 IDENTIFIED BY 新密码;

			[示例]：
				解锁：ALTER USER XIENA ACCOUNT UNLOCK; --解锁用户
				锁定：ALTER USER XIENA ACCOUNT LOCK; --锁定用户
				过期：ALTER USER XIENA IDENTIFIED BY 123456; --解决过期、重置密码
Step 2:表空间的管理
	1.创建表空间****
		1.1 通用的表空间
		[格式]：
			CREATE TABLESPACE 表空间名
			DEFAULT '核心数据文件位置/数据文件名.DBF'
			SIZE 初始化大小m;

		[示例]:
		给DIAOCHAN创建表空间  DCHOME1
		新用户都自动分配到共享表空间USERS中，为了便于管理，用户可以有独占式的表空间
		CREATE TABLESPACE DCHOME1
		DATAFILE 'D:\SPACE1\DCHOME1.DBF'
		SIZE 50m;
		[注]：SPACE1目录要提前创建，否则找不到

		1.2 智能扩展的表空间
		[格式]：
		CREATE TABLESPACE 表空间名 
		DATAFILE '核心数据文件位置/数据文件名.DBF'
		SIZE 初始化大小m
		AOTUEXTEND ON[/OFF]
		NEXT 自动扩展的速度m
		MAXSIZE	表空间最大值;

		[示例]:
		给DIAOCHAN创建表空间  DCHOME2
		新用户都自动分配到共享表空间USERS中，为了便于管理，用户可以有独占式的表空间
		CREATE TABLESPACE DCHOME2
		DATAFILE 'D:\SPACE2\DCHOME2.DBF'
		SIZE 50m
		AUTOEXTEND ON
		NEXT 10M
		MAXSIZE 1000M;
		[注意]：表空间最大值一般建议10G-30G


		1.3 细化的智能扩展的表空间
		[格式]：
		CREATE TABLESPACE 表空间名 
		DATAFILE '核心数据文件位置/数据文件名.DBF'
		SIZE 初始化大小m
		AOTUEXTEND ON[/OFF]
		NEXT 自动扩展的速度m
		MAXSIZE	表空间最大值
		EXTENT MANAGEMENT LOCAL UNIFORM SIZE 细化最小快k;

		[示例]:
		给DIAOCHAN创建表空间  DCHOME3
		新用户都自动分配到共享表空间USERS中，为了便于管理，用户可以有独占式的表空间
		CREATE TABLESPACE DCHOME3
		DATAFILE 'D:\SPACE2\DCHOME2.DBF'
		SIZE 50m
		AUTOEXTEND ON
		NEXT 10M
		MAXSIZE 1000M
		EXTENT MANAGEMENT LOCAL UNIFORM SIZE 512k;--默认最小快值为64k

	2.删除表空间
	[格式]：
	DROP TABLESPACE 表空间名 [INCLUDING CONTENTS AND DATAFILES];
	[示例]：
	DROP TABLESPACE DCHOME1 INCLUDING CONTENTS AND DATAFILES;


Step 3:匹配管理

	解决用户与表空间的关联问题
	[格式]：
	ALTER USER 用户 DEFAULT TABLESPACE 要匹配的表空间;
	[示例]：
	ALTER USER DIAOCHAN DEFAULT TABLESPACE DCHOME3;

Step 4:权限管理
	4.1 授予权限
	[格式]：
		GRANT 角色或权限 TO 用户;

	[格式]：
		GRANT CONNECT,RESOURCE TO SCOTT;

	4.2 撤销权限
	[格式]：
		REVOKE 角色或权限 FROM 用户;
	[格式]：
		REVOKE CONNECT FROM SCOTT;

	【比较】：
	角色：ROLE -侧重于群体（士兵）
	用户：USER -侧重于个体（许三多）

	【甲骨文中三大角色】：
	CONNECT  -连接服务器角色 -小
	RESOURCE -资源控制角色   -中
	DBA      -数据库管理员   -大

	【甲骨文中常见权限】：
	READ		-读取
	WRITE		-写入
	CREATE 		-创建、增加（用户，表空间，表，视图……）-外
	ALTER 		-修改（结构）-外
	DROP		-删除（结构）-外
	SELECT		-查询（内容）
	INSERT		-增加（内容）-内
	UPDATE		-修改（内容）-内
	DELETE 		-删除（内容）-内

==============================================================
Step 5：结构设计
数据库的秘诀：
七字秘诀-库列表增删改查
第一阶段：3个字-库列表    （侧重于结构、形式）-外
第二阶段：4个字-增删改查  （侧重于数据、内容）-内

1.数据库
DBCA  -Database Configuration Assistant  数据库配置助手
作用：完成数据库的创建、更新、删除

NCA   -Net Configuration Assistant    网络配置助手
作用：完成监听器的创建、更新、删除

默认匹配：orcl数据库<->LISTENER
推荐匹配：数据库实例名与监听器名要相近或有文字数字关联
(前缀相同、后缀相同、数字匹配)
DDKS  YYDK
DDSS  IIDT
AIDE  DIIS

两个助手的位置：
开始->所有程序->Oracle...->配置和移植工具


2.表、列（同步）
[格式]：
CREATE TABLE 表名 (
	列名1  数据类型1(宽度1)  约束1,
	列名2  数据类型2(宽度2)  约束2,
	列名3  数据类型3(宽度3)  约束3,
	……
);

[示例]：
CREATE TABLE ADMIN (
	AID NUMBER(9)  NOT NULL,
	ANAME VARCHAR(20)  NULL,
	AGE  NUMBER(3)   NULL
);
[提醒]：创建表前，务必要确定用户，及所在的表空间。
技术实现：先show user; 再conn,最后create table!
==============================================================
Step 6：数据处理





【甲骨文的管理视图】：
DBA_USERS;      -管理所有用户的信息（多）15列，关键是 1/4/7/8
USER_USERS;     -管理当前用户的信息（单）10列，关键是 1/3/6/7
USER_TABLES;    -管理当前用户的表（单）54列，关键是   1/2

【甲骨文的用户状态】：（三种）
OPEN    -开启  -只允许此状态下完成数据处理
LOCKED  -锁定  -
EXPIRED -过期  -

【甲骨文命令的显示格式】：
SHOW LINESIZE;  --显示每行的规格（每行最多允许字符数）
				--默认每行最多80字符，40个汉字
SHOW PAGESIZE;  --显示每页的规格（每页最多允许行数）
				--默认每页最多14行，11行记录

SET LINESIZE m;  --设置每行m个字符，m为整数
SET PAGESIZE n;  --设置每页n行记录

【甲骨文涉及的主要文件格式】：
*.DBF  -数据文件（甲骨文核心数据格式-DataFile）
*.CTL  -控制文件（ControlFile）
*.LOG  -日志文件（LogFile）
*.DMP  -转储文件（备份文件格式DumpFile）
*.SQL  -脚本文件（数据库语言-SQL语言 格式Structured Query Language,结构化查询语言）

[关于注释问题]：
常见的：双缸双星/**/  双减号  双斜杠//
快捷键：Ctrl+/（单行）   Ctrl+Shift+/（多行）

【甲骨文的空间逻辑分类】：（从大到小）
表空间    ->段（表）       ->分区  ->块（单元）
TABLESPACE->SEGEMENT(TABLE)->EXTENT->BLOCK(UNIFORM)


===================================================
[实训1]：
创建liubang，xiangyu两个用户，然后查询，找出这两个用户；最后删除liubang，重新查询剩余的用户。

CREATE USER liubang IDENTIFIED BY 123456;
CREATE USER xiangyu IDENTIFIED BY 123456;
SELECT USERNAME FROM DBA_USERS;		--创建用户后的查询
DROP USER liubang CASCADE;
SELECT USERNAME FROM DBA_USERS;		--删除用户后的查询

[实训2]：
将甲骨文中的默认的四个用户全部解锁：SCOTT/PM/BI/HR
ALTER USER SCOTT ACCOUNT UNLOCK;
ALTER USER PM ACCOUNT UNLOCK;
ALTER USER BI ACCOUNT UNLOCK;
ALTER USER HR ACCOUNT UNLOCK;

ALTER USER SCOTT IDENTIFIED BY ROOT;
ALTER USER PM IDENTIFIED BY ROOT;
ALTER USER BI IDENTIFIED BY ROOT;
ALTER USER HR IDENTIFIED BY ROOT;

SELECT USERNAME, ACCOUNT_STATUS FROM DBA_USERS;

【综合实训三】：
1.创建用户XISHI，ZHAOJUN；
2.再创建表空间XSHOME，ZJHOME,两个表空间的初始值大小均为60M，第一个以10m的速度递增，第二个以20m的速度递增，最大表空间大小分别为10G和20G，表空间进行精细化管理，最小单元快分别为0.25m和0.5m；
3.删除ZHAOJUN用户
4.删除ZHAOJUN对应的表空间
5.关联好用户XISHI和她的表空间XSHOME;
6.对西施进行授权，给他三种常用角色

【编码】：
create user xishi identified by 123456;
create user zhaojun identified by 123456;

create TABLESPACE XSHOME
DATAFILE 'F:\app\Amoy\oradata\orcl\XSHOME.DBF'
SIZE 60M
AUTOEXTEND ON
NEXT 10M
MAXSIZE 10240M
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 256k;

create TABLESPACE ZJHOME
DATAFILE 'F:\app\Amoy\oradata\orcl\ZJHOME.DBF'
SIZE 60M
AUTOEXTEND ON
NEXT 10M
MAXSIZE 20480M
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 512k;

DROP USER ZHAOJUN CASCADE;

DROP TABLESPACE ZJHOME;

ALTER USER XISHI DEFAULT TABLESPACE XSHOME;

GRANT CONNECT TO XISHI;
GRANT RESOURCE TO XISHI;
GRANT DBA TO XISHI;














