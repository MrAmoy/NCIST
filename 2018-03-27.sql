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

	[示例]:给DIAOCHAN创建表空间  DCHOME1
	新用户都自动分配到共享表空间USERS中，为了便于管理，用户可以有独占式的表空间
	CREATE TABLESPACE DCHOME1
	DATAFILE 'D:\SPACE1\DCHOME1.DBF'
	SIZE 50m;
	[注]：SPACE1目录要提前创建，否则找不到


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