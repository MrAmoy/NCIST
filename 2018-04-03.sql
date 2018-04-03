*********************************************************
 *Editor:Sublime
 *Description:甲骨文基础2
 *Date&Time:2018-04-03 8:30
 *Modify[1]:张帅,2018-04-03，Oracle与Java 综合应用4-DAO
*********************************************************

一、DAO数据库功能的封装
【查询功能】：
1.查询所有
	加载->连接->语句->执行->输出->关闭 

	思路：
	连接功能：（加载驱动-创建链接）-开头getConn()

	中间处理过程：采用预编译对象ps（预设占位符"?"->给占位符赋值->确认并执行，输出结果）

	关闭功能：（关闭对象）-结尾

	【实训1】：完成至少三种查询：
	selectAll()				-无条件
	selectById()			-按编号
	selectByName()			-按品名

	根据系统开发需求，还应该编写出如下方法：
	selectByPrice()			-价格相等
	selectByBigPrice()		-价格大于
	selectBySmallPrice()	-价格小于
	selecyByBrand()			-按品牌
	selectByColor()			-按颜色
	selectByPlace()			-按产地


2.查询-按编号

3.查询-按品名



二、数据泵技术(高级技术)
	常规备份与还原：（低效率）
	EXPORT -EXP
	IMPORT -IMP

	比较数据泵技术：（高效率）
	EXPORT Dump  -EXPDP
	IMPORT Dump  -IMPDP

	DUMP  -转储 
	*.dmp  -转储文件  -甲骨文专用的备份文件

[数据泵关键流程]：
	1.创建逻辑目录->2.创建物理目录-> 3.授权    ->4.备份->5.还原
	  (Oracle)        (DOS)            (Oracle)    (DOS)   (DOS)


	第一阶段：准备阶段（1、2、3）
		1.创建逻辑目录（甲骨文环境）
		[格式]：
			CREATE DIRECTORY 逻辑目录名 AS '磁盘中的位置/物理目录';
		[示例]：
			CREATE DIRECTORY NCDIR AS 'E:/NCDIR';
			CREATE DIRECTORY DIR6 AS 'E:/DIR6';
		[注意]：
			推荐罗辑目录与物理目录相同或相似。
			要求是用甲骨文中的最高管理员SYS登录来处理目录和授权

		2.创建物理目录-（DOS环境下或Windows环境下）
			创建物理目录：
			（1）到Windows系统中，右击空白处，新建文件夹；
			（2）到DOS系统中，使用MD命令创建新目录。
				如：MD NCDIR

		3.授权（解决目录的读写控制权限）-（甲骨文环境）
		[格式]：
			甲骨文环境->GRANT 基于某个目录具有读写权限 TO 用户;
		[示例]：
			甲骨文环境->GRANT READ,WRITE ON DIRECTORY NCDIR TO scott;


	第二阶段：处理阶段（4、5）

		【数据泵备份的模式】：
		[注意]：（与常规命令相同）命令是在DOS下执行的；命令后面没有分号！

		1.完全模式（FULL）-所有用户所有表
		[格式]：
			EXPDP 用户/密码[@数据库实例] DIRECTORY=逻辑目录名 DUMPFILE=数据库备份文件名.DMP LOGFILE=日志文件名.LOG FULL=Y
		[示例]：
			EXPDP scott/tiger@orcl DIRECTORY=NCDIR DUMPFILE=dump20180403145500.DMP LOGFILE=20180403145500.LOG FULL=Y


		2.方案模式（SCHEMAS）-指当前用户匹配的方案
		[格式]：
			EXPDP 用户/密码[@数据库实例] DIRECTORY=逻辑目录名 DUMPFILE=数据库备份文件名.DMP LOGFILE=日志文件名.LOG SCHEMAS=方案名

			方案名SCHEMAS NAME = 用户名 USER NAME
			支持多个方案（多个用户），中间用英文逗号隔开。

		[示例]：
			EXPDP scott/tiger@orcl DIRECTORY=NCDIR DUMPFILE=dump20180403schemas.DMP LOGFILE=20180403schemas.LOG SCHEMAS=scott,diaochan
			相当于：
			EXPDP scott/tiger@orcl DIRECTORY=NCDIR DUMPFILE=dump20180403_1.DMP LOGFILE=20180403_1.LOG SCHEMAS=scott
			EXPDP scott/tiger@orcl DIRECTORY=NCDIR DUMPFILE=dump20180403_2.DMP LOGFILE=20180403_2.LOG SCHEMAS=diaochan
		
		3.表模式（TABLES）
		[格式]：
			EXPDP 用户/密码[@数据库实例] DIRECTORY=逻辑目录名 DUMPFILE=数据库备份文件名.DMP LOGFILE=日志文件名.LOG TABLES=表名

			表名可以有多张表，每个表之间用逗号分隔。

		[示例]：
			EXPDP scott/tiger@orcl DIRECTORY=NCDIR DUMPFILE=dump20180403tables.DMP LOGFILE=20180403tables.LOG TABLES=EMP,SALGRADE



======================================================================================
比较：常规技术与数据泵技术
EXP 用户/密码[@数据库实例] FILE=数据库备份文件名.DMP FULL=Y
=====================================================================================
【数据泵还原】：

	1.完全模式（FULL）-所有用户所有表
		[格式]：
			IMPDP 用户/密码[@数据库实例] DIRECTORY=逻辑目录名 DUMPFILE=数据库备份文件名.DMP LOGFILE=日志文件名.LOG FULL=Y
		[示例]：
			IMPDP scott/tiger@orcl DIRECTORY=NCDIR DUMPFILE=dump20180403145500.DMP LOGFILE=20180403145500.LOG FULL=Y

	2.方案模式（SCHEMAS）-指当前用户匹配的方案
		[格式]：
			（1）不跨用户-默认
			IMPDP 用户/密码[@数据库实例] DIRECTORY=逻辑目录名 DUMPFILE=数据库备份文件名.DMP LOGFILE=日志文件名.LOG REMAP_SCHEMA=用户1:用户1

			（2）跨用户
			IMPDP 用户/密码[@数据库实例] DIRECTORY=逻辑目录名 DUMPFILE=数据库备份文件名.DMP LOGFILE=日志文件名.LOG REMAP_SCHEMA=用户1:用户2

			REMAP_SCHEMA  重绘方案图

		[示例]：
		（1）不跨用户：
			IMPDP scott/tiger@orcl DIRECTORY=NCDIR DUMPFILE=dump20180403schemas.DMP LOGFILE=20180403schemas.LOG REMAP_SCHEMA=SCOTT:SCOTT
		（2）跨用户：
			IMPDP scott/tiger@orcl DIRECTORY=NCDIR DUMPFILE=dump20180403_1.DMP LOGFILE=20180403_1.LOG REMAP_SCHEMA=SCOTT:DIAOCHAN
		
	3.表模式（TABLES）
		[格式]：
			IMPDP 用户/密码[@数据库实例] DIRECTORY=逻辑目录名 DUMPFILE=数据库备份文件名.DMP LOGFILE=日志文件名.LOG TABLES=表名
s
			[注意]表名可以有多张表，每个表之间用逗号分隔。

		[示例]：
			IMPDP scott/tiger[@orcl] DIRECTORY=NCDIR DUMPFILE=dump20180403tables.DMP LOGFILE=20180403tables.LOG TABLES=EMP,SALGRADE


【实训3】：
1.创建一个用户wuzetian，采用默认的表空间USERS，做好匹配、授权管理，查询此用户名下的表；
	CREATE USER WUZETIAN IDENTIFIED BY 123456;
	GRANT CREATE SESSION,RESOURCE,DBA TO WUZETIAN;

2.将SCOTT用户按第二种模式备份E:\BESTDIR\QINGMING.DMP;
	CREATE DIRECTORY BESTDIR AS 'E:/BESTDIR';
	GRANT READ,WRITE ON DIRECTORY BESTDIR TO scott;
	EXPDP scott/tiger@orcl DIRECTORY=BESTDIR DUMPFILE=QINGMING.DMP LOGFILE=QINGMING.LOG SCHEMAS=scott

3.将备份文件 QINGMING.DMP 还给WUZETIAN，再查询武则天所有的表。
	
	IMPDP scott/tiger@orcl DIRECTORY=BESTDIR DUMPFILE=QINGMING.DMP LOGFILE=QINGMING.LOG REMAP_SCHEMA=SCOTT:WUZETIAN

（WUZETIAN和SCOTT拥有相同的表数目、表结构、记录数）

[补充]：
	甲骨文数据库中的序列
	序列：sequence  -自动增加常用于id主键，保障数据安全、有序

	[格式]：
		CREATE SEQUENCE 序列名 
		INCREMENT BY 自动递增整数 
		START WITH 从最早开始的整数
		[MAXVALUE 最大值]
		[MINVALUE 最小值]

	[示例]：
		CREATE SEQUENCE seq1 
		INCREMENT BY 2 
		START WITH 2000
		MAXVALUE 10000
		MINVALUE 2000;
		--要在表结构设计中，加入约束，指定序列。

	--开发中最常用的例子：
	CREATE SEQUENCE seq INCREMENT BY 1 START WITH 0;

	取下一个值： seq.nextval
	取当前值：	 seq.currval

	--查询下一个id值
	select seq.nextval from dual;
	--查询当前id值
	select seq.currval from dual;

	dual  -是甲骨文中的伪表（虚表）
	作用：

	--示例：在数据增加中让主键id自动增加
	insert into info values(seq.nextval,'admin',123456);

