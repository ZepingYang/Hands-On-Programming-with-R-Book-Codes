# 第3章 R对象 ####
# 3.1 原子型向量
die <- c(1, 2, 3, 4, 5, 6)
die
is.vector(die)

five <- 5
five
is.vector(five)
length(five)
length(die)
    #Length 函数返回原子型向量的长度。
length(diag(4))  # = 16 (4 x 4)
length(options())  # 12 or more
length(y ~ x1 + x2 + x3)  # 3
length(e <- pression(x, {y <- x^2; y+2}, x^y))  # 3

    #书写规范
int <- 1L
text <- "ace"
    #原子向量是单维、同质结构的数据形式。使用c()函数进行定义。
atomic_vector <- c(1L, "vector",2.5)
atomic_vector # 由于字符串型元素的存在,R会把数字也强制转成字符串型
is.vector(atomic_vector)

sum(int)
sum(text)

# 双整型
die <- c(1, 2, 3, 4, 5, 6)
die
typeof(die)
?typeof

# 整型
int <- c(1L, 2L, 4L)
typeof(int)

    # 浮点误差
sqrt(2)^2 - 2

# 字符型
text <- c("Hello", "World")
text
typeof(text)
typeof("Hello")
typeof(1)
typeof("1")
typeof("one")

# 逻辑型
3 > 4
4 > 3
logic <- c(TRUE, FALSE, TRUE)
logic
typeof(logic)
typeof("T")
typeof(T)
typeof(F)

# 复数型
comp <- c(1 + 1i, 1 + 2i, 1 + 3i)
comp
typeof(comp)

# 原始型
raw(3)
typeof(raw(3))

# 扑克牌
hand <- c("ace", "king", "queen", "jack", "ten")
hand
typeof(hand)

# 3.2 属性
attributes(die)

NULL

# 名称属性names
names(die)
names(die) <- c("one", "two", "three", "four", "five", "six")
names(die)
attributes(die)
die
die + 1 # 名称属性不会对向量中实际数值产生影响
names(die) <- c("uno", "dos", "tres", "quatro","cinco", "seis")
die
names(die) <- NULL
die

# 维度属性
dim(die) <- c(2, 3)
die
dim(die) <- c(3, 2)
die
?dim
args(dim)
dim(die) <- c(1, 2, 3)
die
dim(die) <- NULL

    #使用matrix和array来控制行列,比dim更加自由
?matrix
mdat <- matrix(c(1,2,3, 11,12,13), nrow = 2, ncol = 3, byrow = TRUE,
               dimnames = list(c("row1", "row2"),
                               c("C.1", "C.2", "C.3"))) # 可以,学会了
mdat
die_matrix <- matrix(die, nrow = 2, ncol = 3, byrow = TRUE,
                     dimnames = list(c("row1", "row2"),
                                     c("C1", "C2", "C3")))
die_matrix

# 3.3 矩阵
m <- matrix(die, nrow = 2)
m

m <- matrix(die, nrow = 2, byrow = TRUE)
m

# 3.4 数组
?array
    #example
array(1:3, c(2,4)) # recycle 1:3 "2 2/3 times"

ar <- array(c(11:14, 21:24, 31:34), dim = c(2, 2, 3),
            dimnames = list(c("hang1", "hang2"),
                            c("lie1", "lie2"),
                            c("gao1", "gao2", "gao3")))

# 练习
color <- c("spades", "spades", "spades", "spades", "spades")
color

c(hand, color) #发现：c可以嵌套！

m <- matrix(c(hand,color), nrow = 5, ncol = 2, byrow = FALSE, 
            dimnames = list(c(), c("face", "color")))
m <- c(hand, color)
m

matrix(m, nrow = 5)
matrix(m, ncol = 2)
dim(m) <- c(5, 2)
m

hand1 <- c("ace", "king", "queen", "jack", "ten", "spades", 
           "spades", "spades", " spades", "spades")
matrix(hand1, nrow = 5)
matrix(hand1, ncol = 2)
dim(hand1) <- c(5, 2)
hand1

hand2 <- c("ace", "spades", "king", "spades", "queen", "spades", 
           "jack", "spades", "ten", "spades")
matrix(hand2, nrow = 5, byrow = TRUE)
matrix(hand2, ncol = 2, byrow = TRUE)

# 3.5 类
dim(die) <- c(2,3)
die
typeof(die)
class(die)

attributes(die)
names(die)
dim(die)
class(die)

class("Hello")
class(5)
class(TRUE)

now <- Sys.time()
now
typeof(now)
class(now)
unclass(now)

mil <- 1000000
mil
typeof(mil)
class(mil)
class(mil) <- c("POSIXct", "POSIXt")
typeof(mil)
class(mil)
mil

# 因子
gender <- factor(c("male", "female", "female", "male"))
gender
typeof(gender)
class(gender)
attributes(gender)
unclass(gender)

as.character(gender)
gender

    # 练习
card <- c("ace","hearts", "1")
card
typeof(card)

# 3.6 强制转换
sum(c(TRUE, TRUE, FALSE, FALSE))
sum(c(1, 1, 0, 0))

as.character(1)
typeof(as.character(1))

as.numeric(TRUE)
as.numeric(FALSE)

as.logical(1)
as.logical(0)

# 3.7 列表
list1 <- list(100:130, "R", list(TRUE, FALSE))
list1
?list
list1[[1]][17] # 悟道了list的检索方式

card <- list("ace", "hearts", 1)
card
card[[1]]
length(card[[1]])

    #尝试用list存储52张牌 ####
one_hearts_1 <- list("one", "hearts", 1)
one_spades_1 <- list("one", "spades", 1)
one_squares_1 <- list("one", "squares", 1)
one_clubs_1 <- list("one", "clubs", 1)
cards_list <- list(one_hearts_1, one_spades_1, 
                   one_squares_1, one_clubs_1)
    # 太长了,放弃……

# 3.8 数据框
df <- data.frame(face = c("ace", "two", "six"), 
                 suit = c("clubs", "clubs", "clubs"), 
                 value = c(1, 2, 3), stringsAsFactors = TRUE)
df
names(df)
typeof(df)
class(df)
str(df)

?data.frame
    L3 <- LETTERS[1:3]
    char <- sample(L3, 10, replace = TRUE)
    (d <- data.frame(x = 1, y = 1:10, char = char))
    ## The "same" with automatic column names:
    data.frame(1, 1:10, sample(L3, 10, replace = TRUE))

    #可以用同样的格式给列表和向量的数据命名。
list(face = "ace", suit = "hearts", value = 1)
c(face = "ace", suit = "hearts", value = "one")

# 手动录入的一副扑克牌deck ####
deck <- data.frame(
    face = c("king", "queen", "jack", "ten", "nine", 
             "eight", "seven", "six", "five","four", 
             "three", "two", "ace", "king", "queen", 
             "jack", "ten", "nine", 
             "eight", "seven", "six", "five","four", 
             "three", "two", "ace", "king", "queen", 
             "jack", "ten", "nine", 
             "eight", "seven", "six", "five","four", 
             "three", "two", "ace", "king", "queen", 
             "jack", "ten", "nine", 
             "eight", "seven", "six", "five","four", 
             "three", "two", "ace"), 
    suit = c("spades","spades","spades","spades","spades",
             "spades","spades","spades","spades","spades",
             "spades","spades","spades",
             "clubs", "clubs","clubs","clubs","clubs",
             "clubs","clubs","clubs","clubs","clubs",
             "clubs","clubs","clubs", 
             "diamonds", "diamonds", "diamonds", "diamonds", 
             "diamonds", "diamonds", "diamonds", "diamonds", 
             "diamonds", "diamonds", "diamonds", "diamonds", 
             "diamonds", 
             "hearts", "hearts", "hearts", "hearts", "hearts", 
             "hearts", "hearts", "hearts", "hearts", "hearts", 
             "hearts", "hearts", "hearts"), 
    value = c(13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 
              13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 
              13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 
              13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1)
)

# 3.9 导入数据
deck
typeof(deck)
attributes(deck)
names(deck)
dim(deck)
class(deck)
View(deck)

head(deck)
tail(deck)
head(deck, 10)

# 3.10 保存数据
write.csv(deck, file = "card.csv", row.names = FALSE)
?write.csv
    # 查看当前工作路径
?getwd

# 第4章：R的记号体系 ####
# 4.1 值的选取
# 正整数索引
die[5]
df
df[2, c(2, 3)]
head(deck)
deck[1, 1]
deck[1, c(1, 2, 3)]
deck[1, 1:3]
new <- deck[1, c(1, 2, 3)]
new
deck[c(1, 1), c(1, 2, 3)]
vec <- c(6, 1, 3, 6, 10, 5)
vec[1:3]
deck[1:2, 1:2]
deck[1:2, 1]
deck[1:2, 1, drop = FALSE]

# 负整数索引
deck[-(2:52), 1:3]

deck[c(-1, 1), 1]

deck[-1, 1]

# 零索引
deck[0, 0]

# 空格索引
deck[1, ]

# 逻辑值索引
deck[1, c(TRUE, TRUE, FALSE)]
rows <- c(TRUE,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,
          F,F,F,F,F,F,F,F, F,F,F,F,F,F, F,F,F,
          F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F,F)
deck[rows, ]

# 名称索引
deck[1, c("face", "suit", "value")]
deck[ , "value"]

# 4.2 发牌
deal <- function(cards){
    cards[1, ]
}
deal(deck)

deck2 <- deck[1:52, ]
deck2

deck3 <- deck[c(2, 1, 3:53), ]
head(deck3)

# 4.3 洗牌
random <- sample(1:52, size = 52)
random
deck4 <- deck[random, ]
head(deck4)

shuffle <- function(cards) {
  random <- sample(1:52, size = 52)
  cards[random, ]
}
shuffle(deck)

deal(deck)
deck2 <- shuffle(deck)
deal(deck2)

# 4.4 美元符号和双中括号
deck$face
deck$suit
deck$value

mean(deck$value)
mean(deck[ , 3])
mean(deck[ ,-c(1, 2)])
mean(deck[ ,c(F, F, T)])
mean(deck[ , "value"])
median(deck$value)
median(deck[ , 3])
median(deck[ ,-c(1, 2)])
median(deck[ ,c(F, F, T)])
median(deck[ , "value"])

lst <- list(numbers = c(1, 2), logical = TRUE, 
            strings = c("a", "b", "c"))
lst
lst[1]
sum(lst[1])
lst$numbers
sum(lst$numbers)
lst[[1]]
sum(lst[[1]])

lst["numbers"]
lst[["numbers"]]

# 第5章 对象改值 ===============
deck2 <- deck

vec <- c(0, 0, 0, 0, 0, 0)
vec

vec[1] <- 1000
vec

    # 批量改值
vec[c(1, 3, 5)] <- c(1, 1, 1)
vec

vec[4:6] <- vec[4:6] + 1
vec

    #添加及删除新值的方法
vec[7] <- 0
vec

deck2$new <- 1:52
deck2
deck2$old <- 0
deck2$old <- NULL
deck2$new <- NULL
head(deck2)

# War
deck2[c(13, 26, 39, 52), ]

deck2[c(13, 26, 39, 52), 3]
deck2$value[c(13, 26, 39, 52)] # R的记号系统是可以嵌套的！！

deck2$value[c(13, 26, 39, 52)] <- c(14, 14, 14, 14)
deck2$value[c(13, 26, 39, 52)] <- 14
head(deck2, 13)

deck3 <- shuffle(deck)
head(deck3)

vec
vec[c(FALSE, FALSE, FALSE,FALSE ,TRUE, FALSE, FALSE)]

    #逻辑运算符
1 > 2
2 >= 2
1 < 2
1 <= 2
1 == 2
1 != 2
2 %in% c(1, 2, 3)
1 > c(0, 1, 2)
c(1, 2, 3) == c(3, 2, 1)
1 %in% c(3, 4, 5)
c(1, 2) %in% c(3, 4, 5)
c(1, 2, 3) %in% c(3, 4, 5)
c(1, 2, 3, 4) %in% c(3, 4, 5)

    # 练习
deck2$face == "ace"
sum(deck$face == "ace")

head(deck3, 14)
deck3$face == "ace"
deck3$value[deck3$face == "ace"]
deck3$value[deck3$face == "ace"] <- 14
head(deck3, 14)

# Hearts
deck4 <- deck
deck4$value <- 0
head(deck4)
tail(deck4, 13)

    # 逻辑测试
deck4$value[deck4$suit == "hearts"] <- 1
tail(deck4, 13)
deck4$value[deck4$suit == "hearts"]

    # 布尔运算符
deck4[deck4$face == "queen", ]
deck4[deck4$suit == "spades", ]
a <- c(1, 2, 3)
b <- c(1, 2, 3)
c <- c(1, 2, 4)
a == b
b == c
a == b & b == c

deck4$face == "queen" & deck4$suit == "spades"
queenofspases <- deck4$face == "queen" & deck4$suit == "spades"
deck4[queenofspases, ]
deck4$value[queenofspases]
deck4$value[queenofspases] <- 13
deck4[queenofspases, ]

    #练习
w <- c(-1, 0, 1)
x <- c(5, 15)
y <- "February"
z <- c("Monday", "Tuesday", "Friday")
w > 0
x > 10 & x < 20
y == "February"
all(z %in% c("Monday", "Tuesday","Wednesday", "Thursday", 
             "Friday", "Saturday", "Sunday"))

# BlackJack
deck5 <- deck
head(deck5, 13)
facecard <- deck5$face %in% c("king", "queen", "jack")
deck5[facecard, ]
deck5$value[facecard] <- 10
deck5[facecard, ]

# 5.3 缺失信息
1 + NA
NA == 1

c(NA, 1:50)
mean(c(NA, 1:50))
mean(c(NA, 1:50), na.rm = TRUE)

NA == NA
c(1, 2, 3, NA) == NA
is.na(NA)
vec <- c(1, 2, 3, NA)
is.na(vec)

deck5$value[deck5$face == "ace"] <- NA
head(deck5, 13)

# 第6章 R的环境系统 ####
deal(deck)
deal(deck)
deal(deck)

library(pryr)
parenvs(all = TRUE)

as.environment("package:stats")

globalenv()
baseenv()
emptyenv()

# 运行以上3种环境函数产生的结果是一个“environment”类型的【对象】
# 之前所有关于对象的操作均可执行，如检索，改值等。
r <- globalenv()
r
names(r)
dim(r)
class(r)
r$a

parent.env(globalenv())
parent.env(emptyenv())

ls(emptyenv())
ls(globalenv())
rm(model)
ls.str(emptyenv())
ls.str(globalenv())

head(globalenv()$deck, 3)

assign("new", "Hello Global", envir = globalenv())
new
globalenv()$new
assign("new2", TRUE, envir = globalenv())
new2
?assign
assign("new3", "Hello Global Again")

environment()
new <- "Hello Active"
new

    #构造函数显示函数的运行时环境
show_env <- function(){
    list(ran.in = environment(), 
         parent = parent.env(environment()), 
         objects = ls.str(environment()))
}
show_env()
environment(show_env)
environment(parent.env)

show_env <- function(){
    a <- 1
    b <- 2 
    c <- 3 
    list(ran.in = environment(), 
         parent = parent.env(environment()), 
         objects = ls.str(environment()))
}
show_env()

foo <- "take me to your runtime"
show_env <- function(x = foo){
    a <- 1
    b <- 2 
    c <- 3 
    list(ran.in = environment(), 
         parent = parent.env(environment()), 
         objects = ls.str(environment()))
}
show_env()

# 重构deal函数
deal <- function(){
    deck[1, ]
}
deal()
environment(deal)

DECK <- deck
deck <- deck[-1, ]
head(deck)

deal <- function(){
    card <- deck[1, ]
    deck <- deck[-1, ]
    card
}
deal()

deal <- function(){
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = globalenv())
    card
}
deal() # 完成

# 重构shuffle函数
shuffle <- function(cards) {
    random <- sample(1:52, size = 52)
    cards[random, ]
}

head(deck, 3)
a <- shuffle(deck)
head(deck, 3)
head(a, 3)

shuffle <- function() {
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = globalenv())
}
shuffle()
deck
deal()

# 闭包
shuffle()
deal()
setup <- function(deck){
    DECK <- deck
    
    DEAL <- function(){
        card <- deck[1, ]
        assign("deck", deck[-1, ], envir = globalenv())
        card
    }
    
    SHUFFLE <- function() {
        random <- sample(1:52, size = 52)
        assign("deck", DECK[random, ], envir = globalenv())
    }
}

setup <- function(deck){
    DECK <- deck
    
    DEAL <- function(){
        card <- deck[1, ]
        assign("deck", deck[-1, ], envir = globalenv())
        card
    }
    
    SHUFFLE <- function() {
        random <- sample(1:52, size = 52)
        assign("deck", DECK[random, ], envir = globalenv())
    }
    
    list(deal = DEAL, shuffle = SHUFFLE)
} # 这种操作成为闭保（closure）
cards <- setup(deck)
deal <- cards$deal
shuffle <- cards$shuffle
deal
shuffle
environment(deal)
environment(shuffle)

# 完整的闭包整套扑克牌函数
setup <- function(deck){
    DECK <- deck
    
    DEAL <- function(){
        card <- deck[1, ]
        assign("deck", deck[-1, ], envir = parent.env(environment()))
        card
    }
    
    SHUFFLE <- function() {
        random <- sample(1:52, size = 52)
        assign("deck", DECK[random, ], envir = parent.env(environment()))
    }
    
    list(deal = DEAL, shuffle = SHUFFLE)
}
cards <- setup(deck)
deal <- cards$deal
shuffle <- cards$shuffle

rm(deck, DECK)

shuffle()
deal()
deal()

# 后来
deck2
attributes(deck2)
