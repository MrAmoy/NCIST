*********************************************************
 *Editor:Sublime
 *Description:软件研发基础知识
 *Date&Time:2018-03-26 10:00
 *Modify[1]:张帅,2018-03-26,软件开发准备（Sublime）
 *Modify[2]:张帅,2018-03-26,甲骨文开发环境安装与配置
*********************************************************

一、要掌握的工具
    Sublime
    Eclipse/myeclipse
    HyperSnap/FastStone
    PowerDesigner/Visio

二、技术要点
    Oracle
    Java
    C/S  Software

三、了解软件开发的常识
    1. 软件工程流程:
        获取需求->分析需求->总体设计->详细设计->编程->测试->实施部署->运行维护

    2. 软件架构:
        B/S  -Browser/Server 浏览器/服务器
        特点：开发成本低，实施时间短，升级容易，维护简单

        B/S  -Client/Server 客户端/服务器
        特点：开发成本高，实施时间长，升级麻烦，维护复杂

    3. 数据库全球排名:
        （1）Oracle
        （2）MySql
        （3）MSSQL -SQL Server

四、甲骨文安装流程

    1.下载甲骨文安装包，然后合并包，得到统一的安装包

    2.解压安装包

    3.调用兼容性和权限
        右击Oracle的安装文件setup.exe->属性->兼容性（勾选带有“Server”字样的OS，若无，用win7代替）->特权等级（勾选“以管理员身份运行此程序”）->更改所有用户设置->重复前面两步（兼容性与特权等级）->两次应用和确定

    4.双击安装包 setup.exe

    5.安装并配置相关信息；******
        （1）忽略安全更新，不必填写电子邮件
        （2）创建和配置数据库
        （3）选择系统类型（真实Server，选“服务器类”，台式机和笔记本，选“桌面类”）
        （4）最重要的设置：基目录-推荐安装在非系统盘下，目录用app/db/oracle/orcl/ora/oradata
            版本-企业版EE-Enterprise Edition
            字符集：中国GBK/GB2312/GB18030  国际UTF-8（万国码）
            全局数据库-默认orcl-数据库实例instance-具体的DB对象
            管理口令-密码推荐123456；国际规则：四混合-大写+小写+数字+符号
        （5）先决条件检查-检查您的电脑硬件是否达到了美国Oracle公司标准，如果出现错误，勾中右上角“全部忽略”；
        （6）检查安装前的配置信息-安装概要；若没问题，完成。

    6.配置口令管理；
    sys       -最高权限拥有者     -总司令
    system    -权限仅次于sys      -副总司令
    scott     -权限最小的普通用户 -小兵
    将以上三个用户的口令全部解锁（去掉前面锁定的对号），更改三个用户的口令为123456

    7.检测服务管理

    8.看到“成功”字样，完成

【检测本机有无Oracle环境】：
    方法一：命令法
        win+R->cmd->sqlplus->出现提示：请输入用户名->说明开发环境已经安装成功

    方法二：服务法
        win+R->services.msc->弹出“服务管理”控制台->找到以“Oracle”开头的各种服务->说明Oracle开发环境已经安装成功
    *.msc -microsoft console 微软控制台

    推荐：一机多系统，使用VBOX、VMware虚拟机软件

【服务器】
    操作系统：
        Windows Server 2003/2008/2012
        Linux  RedHat/RedFlag/Kylin/CentOS/Ubuntu

    分类：
        本地服务器remote server
        地址：全球服务器分散在不同城市，每台server不同IP地址

    Oracle产品：
    8i 9i    -internet  互联网
    10g 11g  -grid      网格
    12c      -cloud     云计算

【登录管理】：
方法一：无参法
    Win+R->cmd->sqlplus->输入用户名->输入密码->进入甲骨文数据库服务器中，看到前缀"SQL>"

方法二：有参法
    Win+R->cmd->sqlplus /nolog->自动跳过用户名和密码输入->进入甲骨文数据库服务器中，看到前缀"SQL>"

切换用户：toggle user;
    [格式]：conn[ect] 用户/密码 [as sysdba/sydoper];
    [示例]：
    connect scott/123456;       --普通用户登录
    conn scott/123456;          --简写
    conn sys/123456 as sysdba;  --管理员sys登陆，必须要有身份
    以上命令可简写为：conn / as sysdba;

    甲骨文中，用户有两种身份:
    sysdba: system database administrator
    sysoper: system operator

【协议适配器错误】：（常见面试题）
    解决：只要重新启动甲骨文的核心服务
    甲骨文的主要服务有：
    Console     -控制台    -管理甲骨文的工具EM（企业管理器）
    Listener    -监听器    -与数据库实例配套的监听程序，保障安全
    Service     -核心服务  -控制甲骨文数据库的实例启动和关闭
    默认配对：
    orcl(甲骨文数据库示例)   -Listener（与orcl配对的监听器）

    以上三大核心服务，建议全部启动，也可以只启动两个服务即可


【甲骨文基本命令】
show user;   		--查看当前登录用户
exit;        		--退出甲骨文数据库系统
desc 表名或视图名;  --查看表或视图的结构

【甲骨文中最重要的三张管理视图-特殊的表-虚表】：
Table  -表（物理表）
View   -视图（虚表-基于物理表产生的）

DBA_USERS;      -管理所有用户的信息（多）15列，关键是 1/4/7/8
USER_USERS;     -管理当前用户的信息（单）10列，关键是 1/3/6/7
USER_TABLES;    -管理当前用户的表（单）54列，关键是   1/2


