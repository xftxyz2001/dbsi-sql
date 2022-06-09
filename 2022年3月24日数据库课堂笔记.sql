-- 等值连接（内连接）
SELECT * FROM student, dorm
WHERE student.dormno = dorm.dormno;

SELECT * FROM student
INNER JOIN dorm ON student.dormno = dorm.dormno;

-- 左外连接
SELECT * FROM student, dorm
WHERE student.dormno *= dorm.dormno;

SELECT * FROM student
LEFT JOIN dorm ON student.dormno = dorm.dormno;

-- JOIN == INNER JOIN
-- LEFT JOIN == LEFT OUTER JOIN
-- RIGHT JOIN == RIGHT OUTER JOIN

-- 全连接
SELECT * FROM student
LEFT JOIN dorm ON student.dormno = dorm.dormno;
UNION
SELECT * FROM student
RIGHT JOIN dorm ON student.dormno = dorm.dormno;

SELECT * FROM student
FULL JOIN dorm ON student.dormno = dorm.dormno;

/*
结构化查询语言（SQL）的“结构化”怎么理解？
结构化查询语言是查询结构化数据用的计算机语言，结构化数据简单的讲就是把数据设计成便于想象的结构。
在计算机发展早期，硬件是非常贵的，而且性能非常低，当时对数据和程序的一大要求就是尽量小，
到什么程度呢，用字节数，不是K, 更不是M，是字节。
想必大家听说过程序太大改用C从新写，当时是C对于内存都太大，要汇编写，要不C，Pascal之类怎么叫高级语言呢。
有了这个时代背景，说一下“结构化语言”，早期的计算机语言是很难写很难测试的，因为到处都是goto，
没办法呀，这玩意简单粗暴。
后来（70年代）有人提出结构化，就是现在我们熟悉的循环，if-then,之类的。
这样程序就好看多了，一块一块的，逻辑性也很明显了。
随着内存的价格快速下降，大家也可以容忍高级语言了，慢慢的没人用goto了。
结构化数据也是从原始的一片乱糟糟演变来的，开始的数据在内存里就是一坨数据，
地址从这儿到那儿，顶多还有一坨指针，也是地址从这儿到那儿，可想而知查询多麻烦，
一切的一切还是因为内存太贵，CPU cycle 太贵。后来好了，内存大了，CPU也快了，
咱们数据也整理整理吧，于是乎有了结构化。
数据也摆成一块一块的，不但告诉你在哪儿，还告诉你什么类型，每个数据有多大，
再配个索引啥的，看上去很美是吧。
逻辑上还可以关联起来呀... 等等，我就不废话了。
回过头来，这个SQL就是查询结构化数据用的，相对之前的API，
他的两大优势是，不要关心怎么访问内存里的数据，二是可以返回多个结果。
*/

-- 软件需求分析--结构化分析（SA）方法
-- 以数据流为导向，逐步分解、逐步求精的**模块化**过程 

-- C语言的32个关键字
/*
关键字|说明
---|---
auto|声明自动变量
short|声明短整型变量或函数
int|声明整型变量或函数
long|声明长整型变量或函数
float|声明浮点型变量或函数
double|声明双精度变量或函数
char|声明字符型变量或函数
struct|声明结构体变量或函数
union|声明共用数据类型
enum|声明枚举类型
typedef|用以给数据类型取别名
const|声明只读变量
unsigned|声明无符号类型变量或函数
signed|声明有符号类型变量或函数
extern|声明变量是在其他文件正声明
register|声明寄存器变量
static|声明静态变量
volatile|说明变量在程序执行中可被隐含地改变
void|声明函数无返回值或无参数，声明无类型指针
if|条件语句
else|条件语句否定分支（与 if 连用）
switch|用于开关语句
case|开关语句分支
for|一种循环语句
do|循环语句的循环体
while|循环语句的循环条件
goto|无条件跳转语句
continue|结束当前循环，开始下一轮循环
break|跳出当前循环
default|开关语句中的“其他”分支
sizeof|计算数据类型长度
return|子程序返回语句（可以带参数，也可不带参数）循环条件
*/

-- ![](imgs/2022-03-24-11-56-08.png)

