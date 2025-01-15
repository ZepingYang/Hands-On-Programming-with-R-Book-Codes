# 第1章 R基础 ####
# 1.1 R的用户界面
1 + 1
100:140 # 第二行[22]表明121是返回的数值中的第22个。

5 - 
1

    # 3 % 5 #报错,不认识这个。
3 + 5
2 * 3
4 - 1
6 / (4 - 1)
3 %% 5
5 %% 3

2*3 ## 6
4-1 ## 3
6 / (4 - 1) ## 2

((1999 + 2) * 3 - 6) / 3 
# 练习：每一步都运行无误的话,最后得到的结果应该跟你最先输入的数字一模一样。

# 1.2 对象
a <- 1
a
a + 2
b <- a+2
b
    # c = a + 3 # Q：所以在R中 <- 和 = 有何区别？
    # c

Name <- 1
name <- 0
Name + 1
name + 1

my_number <- 1
my_number
my_number <- 1999
my_number

ls()

die - 1 # 元素方式执行
die / 2
die * die

1:2 # 向量循环
1:4
die + 1:2
die + 1:4

die %*% die #执行内乘法矩阵运算
die %o% die #执行外乘法矩阵运算

# 1.3 函数
round(3.1415)
factorial(3)
round(1)
round(mean(die)) # round (mean (die)) → round (mean (1:6) →round(3.5) → 4 

sample(x = 1:4, size = 2)

sample(x = die, size = 1)

sample(x, size = 1)



args(round)

round(3.1415, digits = 2)

sample(die, 1)
sample(1, die) # 错误示范
sample(size = 1, x = die)

# 1.4 可放回抽样
sample(die, size = 2)
sample(die, size = 2, replace = TRUE)

die
dice <- sample(die, size = 2, replace = TRUE)
dice
sum(dice)

# 1.5 编写自定义函数
die <- 1:6
dice <- sample(die, size = 2, replace = TRUE)
sum(dice)

roll <- function(){
    die <- 1:6
    dice <- sample(die, size = 2, replace = TRUE)
    sum(dice)
}
roll()
args(roll)
roll

dice #会显示结果的函数结尾示例
1 + 1
sqrt(2)

# 1.6 参数
roll2 <- function(){
    dice <- sample(bones, size = 2, replace = TRUE)
    sum(dice)
}
roll2()
# Error in sample(bones, size = 2, replace = TRUE) : 
#     object 'bones' not found

roll2 <- function(bones){
    dice <- sample(bones, size = 2, replace = TRUE)
    sum(dice)
}
args(roll2)
roll2(1:4)
roll2(1:6)
roll2(1:20)
roll2()
# Error in sample(bones, size = 2, replace = TRUE) : 
#     argument "bones" is missing, with no default

roll2 <- function(bones = 1:6){
    dice <- sample(bones, size = 2, replace = TRUE)
    sum(dice)
}
args(roll2)
roll2()

    #自定义的第一个函数,成功！
roll3 <- function(bones = 1:6, times = 2){
    dice <- sample(bones, times, replace = TRUE)
    dice
}
args(roll3)
roll3()
roll3(1:6, times = 3)

    #用Code → Extract Function提取的函数,快捷键Command+option+X
roll4 <- function(bones = 1:6, times = 3) {
  dice <- sample(bones, times, replace = TRUE)
  dice
}
roll4()

dice <- sample(bones, times, replace = TRUE)
dice

# 第2章 R包与帮助文档 ####
install.packages("ggplot2")

# qplot函数
qplot
library(ggplot2)
qplot
x <- c(-1, -0.8, -0.6, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1)
y <- x^3
x
y
qplot(x, y)
# qplot(x, y)Warning message:
#     `qplot()` was deprecated in ggplot2 3.4.0.
plot(x, y)

z <- c(1, 2, 2, 2, 3, 3)
args(qplot)
qplot(z, binwidth = 0.5)
z2 <- c(1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 4)
qplot(z2, binwidth = 0.5)
z3 <- c(0, 1, 1, 2, 2, 2, 3, 3, 4)
qplot(z3, binwidth = 0.5)

# replicate函数
replicate(3, 1 + 1)
replicate(10, roll())

# 模拟一千次掷骰子
rolls <- replicate(1000, roll())
qplot(rolls, binwidth = 0.5)

# 2.2 从帮助页面获取帮助
?sqrt
?log10
?sample
??log #关键词搜索

roll_prob <- function(){
    die <- 1:6
    dice <- sample(die, size = 2, replace = TRUE,
                   prob = c(0.125, 0.125, 0.125, 0.125, 0.125, 0.375))
    sum(dice)
}

rolls_prob <- replicate(1000, roll_prob()) 
qplot(rolls_prob, binwidth = 0.5)
