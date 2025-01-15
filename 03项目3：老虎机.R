# 第7章 程序 --------------------------------------------------
get_symbol <- function(){
    wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
    sample(wheel, size = 3, replace = TRUE,
           prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
            # 这一串prob累和等于1.0.
}
get_symbol()
replicate(10, get_symbol())

# play函数
play <- function(){
    symbols <- get_symbols()
    print(symbols)
    score(symbols)
} # 发现：score()函数还没搭好时play()也可执行，但会报错。
play()

# 7.1 策略

# 7.2 if语句
this <- TRUE
that <- "that"
if(this){
    that
}

num <- -2
if(num < 0){
    num <- num * -1
}
num

num <- 4
if(num < 0){
    num <- num * -1
}
num

num <- -1
if(num < 0){
    print("num is negative.")
    print("Don't worry, I'll fix it.")
    num <- num * -1
    print("Now num is positive.")
}
num

x <- -1
if(3 == 3){
    x <- 2
}
x

x <- 1
if(TRUE){
    x <- 2
}
x

x <- 1
if(x == 1){
    x <- 2
    if(x == 1){
        x <- 3
    }
}
x

# 将小数四舍五入
a <- 3.14
decimals <- a - trunc(a)
decimals

if(decimals < 0.5){
    a <- trunc(a) 
}else{
    a <- trunc(a) + 1
}
a

if(decimals >= 0.5){
    a <- trunc(a) + 1
}else{
    a <- trunc(a)
}
a

# if 和 else 结合使用
a <- 1
b <- 1

if(a > b){
    print("A wins!")
}else if(a < b){
    print("B wins!")
}else{
    print("Tie.")
}

# score函数
score <- function(symbols){
    # 识别情形
    same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
    bars <- all(symbols %in% c("B", "BB", "BBB")) 
    
    # 计算中奖金额
    if(same){
        playout <- c("DD" = 100, "7" = 80, "BBB" = 40, 
                     "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
        prize <- unname(playout[symbols[1]])
    }else if(bars){
        prize <- 5
    }else{
        cherries <- sum(symbols == "C")
        prize <- c(0, 2, 5)[cherries + 1]
    }
    
    # 根据钻石的个数调整中奖金额
    diamonds <- sum(symbols == "DD")
    prize * 2 ^ diamonds
}

# 步骤①：判定三个符号相同→实例and简单语言and代码 ====
# 实例非常重要
symbols <- c("7", "7", "7")
symbols[1] == symbols[2] & symbols[2] == symbols[3]
symbols[1] == symbols[2] & symbols[1] == symbols[3]
all(symbols == symbols[1])
unique(symbols)
length(unique(symbols)) == 1

# 步骤③：判定三个符号全是杠→实例and简单语言and代码 ====
# 实例非常重要
symbols <- c("B", "BBB", "BB")
symbols
    # 日常语言描述需求：
    # 名为symbols的对象有三个字符数据，是否每一个(all)元素都是
    # "B","BB","BBB"中的一个（|,any）。
symbols[1]
symbols[1] == "B" | symbols[1] == "BB" | symbols[1] == "BBB" 

symbols == c("B", "BB", "BBB")
symbols[1] %in% c("B", "BB", "BBB")
symbols[2] %in% c("B", "BB", "BBB")
symbols[3] %in% c("B", "BB", "BBB")
symbols %in% c("B", "BB", "BBB")
all(symbols %in% c("B", "BB", "BBB")) 
    # 就是这个！嘿嘿这种逐步积累写出代码的感觉我太爱了！
    # 等价的复杂代码
symbols[1] == "B" | symbols[1] == "BB" | symbols[1] == "BBB" &
symbols[2] == "B" | symbols[2] == "BB" | symbols[2] == "BBB" &
symbols[3] == "B" | symbols[3] == "BB" | symbols[3] == "BBB"

symbols <- c("B", "B", "B")
all(symbols %in% c("B", "BB", "BBB")) 

# 步骤②：三个符号相同时，计算对应金额。 ====
symbol <- symbols[1]
if(symbol == "DD"){
    prize <- 100
}else if(symbol == "7"){
    prize <- 80
}else if(symbol == "BBB"){
    prize <- 40
}else if(symbol == "BB"){
    prize <- 25
}else if(symbol == "B"){
    prize <- 10
}else if(symbol == "C"){
    prize <- 10
}else if(symbol == "0"){
    prize <- 0 # 这种情况容易疏忽！
} # 太麻烦！做个查找表吧！以金额为值，以符号位“names”

playout <- c("DD" = 100, "7" = 80, "BBB" = 40, 
             "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
playout
playout["DD"]
playout["0"]
unname(playout["DD"]) # 哈哈，献上你的名！注意是unname而非uname
symbols <- c("C", "C", "C")
symbols[1]
playout[symbols[1]]
unname(playout[symbols[1]])

# 步骤④：统一分配5美元。 ====

# 步骤⑤：计算樱桃的数量→实例and简单语言and代码 ====
# 实例非常重要
    #日常语言：名为symbols的对象有三个字符数据，(1)有多少个"C"符号，
    #对于(1)不错的理解：symbols的元素 == "C" 是否为真（1）。
    #(2)若有2个，给5美元；若有1个给2美元，若有0个，给0美元
symbols <- c("C", "C", "0")
symbols
prize_C <- function(symbols) {
  num <- 0
  if(symbols[1] == "C"){
      num <- num + 1
  }
  if(symbols[2] == "C"){
      num <- num + 1
  }
  if(symbols[3] == "C"){
      num <- num + 1
  }
  num
  if(num == 2){
      prize <- 5
  }else if(num == 1){
      prize <- 2
  }else if(num == 0){
      prize <- 0
  }
  prize
} # 哈哈，封装成函数了，自定义的第二个函数。

symbols <- c("C", "C", "0")
prize_C(symbols)

    # 呜呜，Garrett的方法更简洁，被吊打了……逻辑判定+强制转化，
    #对逻辑型变量的认识和使用，还是不够深呀！还傻傻用if一个个加~
    #练习到看到TRUE，能头上顶个1；看到FALSE能头上顶个0，就好了。
symbols == "C"
sum(symbols == "C")

# 步骤⑥：根据樱桃树计算中奖金额。 ====
prize_cherris <- c("2" = 5, "1" = 2, "0" = 0) 
    # 现学现卖做了个查找表，用来替代用if计算金额的函数
prize_cherris
unname(prize_cherris[as.character(cherries)])
    # Garrett的查找表更简洁，甚至不用name属性，但我的更通用。
cherries <- 2
c(0, 2, 5)[cherries + 1]


# 步骤⑦：计算钻石的数量（同步骤⑤：计算樱桃的数量） ====
symbols <- c("DD", "C", "B")
sum(symbols == "DD")

# 运行
play()
play()
play()
play()
play()
play()
play()
play()
play()
play() # 这爆率也太低了……我突然明白阴阳师抽卡咋回事了。
replicate(100, play())

# 第8章 S3系统 ====
one_play <- play()
one_play

num <- 1000000000
print(num)
class(num) <- c("POSIXct", "POSIXt")
print(num)

attributes(deck2)
row.names(deck2)
row.names(deck2) <- 101:152
row.names(deck2)
levels(deck2) <- c("Level 1", "Level 2", "Level 3")
attributes(deck2)
deck2


one_play <- play()
one_play
attributes(one_play)
attr(one_play, "symbols") <-c("BB", "B", "0" ) 
attributes(one_play)
attr(one_play, "symbols") 
# attr(deck2, "names") 
one_play
class(one_play)
one_play + 1
class(one_play)

# 优化play函数:
# ①修改 play 函数，使得它在返回中奖金额的同时也能包含相应的老虎机符号信息
# ②这个信息被包含在一个叫作 symbols 的属性中。
# ③将print(symbols)的冗余信息移除。

# play函数2.0 
play <- function(){
    symbols <- get_symbols()
    prize <- score(symbols)
    attr(prize, "symbols") <- symbols
    prize
} 

two_play <- play()
two_play

# play函数3.0 
play <- function(){
    symbols <- get_symbols()
    structure(score(symbols), symbols = symbols, class = "slot")
} 

three_play <- play()
three_play

# 构建slot_display函数
slot_display <- function(prize) {
  symbols <- attr(prize, "symbols")
  symbols <- paste(symbols, collapse = " ")
  string <- paste(symbols, prize, sep = "\n$")
  cat(string)
}
slot_display(play())

# 泛型函数
print(pi)
pi

print(head(deck2))
head(deck2)

print(play())
play()

num <- 1000000000
print(num)

class(num) <- c("POSIXct", "POSIXt")
print(num)
unclass(num)

print
print.POSIXct

fac <- factor()
factor

methods(print)

    #复习因子
gender <- factor(c("male", "female", "female", "male"))
gender
typeof(gender)
attributes(gender)
unclass(gender)

    #继续
class(one_play) <- "slot"
args(print)
print.slot <- function(x, ...) {
    cat("I'm using the print.slots method")
}
print(one_play)
one_play

now <- Sys.time()
now
attributes(now)

print.slot <- function(x,...){
    slot_display(x)
}

class(play())
play()

methods(print)
methods(class = "factor")

play1 <- play()
play1
play2 <- play()
play2
c(play1, play2)
class(c(play1, play2))
play1[1]

# 第9章 循环 ====
DIE <- 1:6
# expand.grid快速列出组合数据框
rolls <- expand.grid(DIE, DIE)
rolls
rollss <- expand.grid(DIE, DIE, DIE)
# 计算点数
rolls$value <- rolls$Var1 + rolls$Var2
head(rolls)

1 == "1"

# 计算概率：使用查找表
prob <- c("1" = 0.125, "2" = 0.125, "3" = 0.125, "4" = 0.125, 
          "5" = 0.125, "6" = 0.375)
# prob <- c("1" = 1/6, "2" = 1/6, "3" = 1/6, "4" = 1/6, 
#           "5" = 1/6, "6" = 1/6)
prob
rolls$Var1
prob[rolls$Var1]
rolls$prob1 <- prob[rolls$Var1]
head(rolls, 12)
rolls$prob2 <- prob[rolls$Var2]
head(rolls)
tail(rolls)
rolls$prob <- rolls$prob1 * rolls$prob2
head(rolls)
tail(rolls)

# 计算期望值
sum(rolls$value * rolls$prob)

# 计算老虎机中奖金额期望值
wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
combs <- expand.grid(wheel, wheel, wheel, stringsAsFactors = FALSE)
head(combs)
prob <- c("DD" = 0.03, "7" = 0.03, "BBB" =0.06, 
          "BB" = 0.1, "B" = 0.25, "C" = 0.01, "0" = 0.52)
combs$prob1 <- prob[combs$Var1]
combs$prob2 <- prob[combs$Var2]
combs$prob3 <- prob[combs$Var3]
head(combs)
combs$prob <- combs$prob1 * combs$prob2 * combs$prob3
head(combs)
sum(combs$prob)

symbols <- c(combs[1, 1], combs[1, 2], combs[1, 3])
symbols <- c(combs$Var1[1], combs$Var2[1], combs$Var3[1])
head(symbols)
score(symbols)

# for 循环
for (value in c("My", "first", "for", "loop")) {
    print("one run")
}

for (value in c("My", "second", "for", "loop")) {
    print(value)
}
value

for (word in c("My", "second", "for", "loop")) {
    print(word)
}
for (string in c("My", "second", "for", "loop")) {
    print(string)
}
for (i in c("My", "second", "for", "loop")) {
    print(i)
}

for (value in c("My", "third", "for", "loop")) {
    value
}

# 整数集和for存储
chars <- vector(length = 4)
word <- c("My", "fourth", "for", "loop")
for (i in 1:4) {
    chars[i] <- word[i]
}
chars

# 计算金额
combs$prize <- NA
head(combs)
for (i in 1:343) {
    symbols <- c(combs[i, 1], combs[i, 2], combs[i, 3])
    combs$prize[i] <- score(symbols)
}
head(combs)

# 计算期望金额
sum(combs$prize * combs$prob)

# 挑战：优化score函数 ====

# 框架→完成
score_DD <- function(symbols) {
  num <- sum(symbols == "DD")
  if(num == 0){
      # 识别情形
      same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
      bars <- all(symbols %in% c("B", "BB", "BBB")) 
      
      # 计算中奖金额
      if(same){
          playout <- c("DD" = 100, "7" = 80, "BBB" = 40, 
                       "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
          prize <- unname(playout[symbols[1]])
      }else if(bars){
          prize <- 5
      }else{
          cherries <- sum(symbols == "C")
          prize <- c(0, 2, 5)[cherries + 1]
      }
      prize
  }else if(num == 1){
      # 判断情形
      judge <- symbols == "DD"
      symbols_else <- symbols[!judge]
      same <- symbols_else[1] == symbols_else[2]
      bars <- all(symbols_else %in% c("BBB", "BB", "B"))
      cherry <- any(symbols_else == "C")
      
      #计算prize
      if(same){
          playout <- c("7" = 80, "BBB" = 40, "BB" = 25, "B" =10, 
                       "C" = 10, "0" = 0)
          prize <- unname(playout[symbols_else[1]])
          prize * 2^num
      }else if(bars){
          prize <- 5
          prize * 2^num
      }else if(cherry){
          prize <- 5
          prize * 2^num
      }else{
          prize <- 0
      }
  }else if(num == 2){
      #判断情形
      judge <- symbols == "DD"
      symbols_else <- symbols[!judge]
      # 必为三个一样，一个查找表搞定prize（注意0）
      playout <- c("DD" = 100, "7" = 80, "BBB" = 40, 
                   "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
      prize <- unname(playout[symbols_else])
      prize * 2^num
  }else if(num == 3){
      prize <- 100
      prize * 2^num
  }
}

# 步骤①，判断DD数量
symbols <- c("DD", "DD", "DD")
symbols <- c("DD", "DD", "0")
symbols <- c("DD", "0", "0")
symbols <- c("0", "0", "0")

num <- sum(symbols == "DD")

# 步骤③，num == 0,计算prize
symbols <- c("0", "B", "BB")
if(num == 0){
    # 识别情形
    same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
    bars <- all(symbols %in% c("B", "BB", "BBB")) 
    
    # 计算中奖金额
    if(same){
        playout <- c("DD" = 100, "7" = 80, "BBB" = 40, 
                     "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
        prize <- unname(playout[symbols[1]])
    }else if(bars){
        prize <- 5
    }else{
        cherries <- sum(symbols == "C")
        prize <- c(0, 2, 5)[cherries + 1]
    }
    prize
}

# 步骤⑤：num == 1，计算prize
symbols <- c("0", "DD", "BBB")
# 判断情形
judge <- symbols == "DD"
symbols_else <- symbols[!judge]
same <- symbols_else[1] == symbols_else[2]
bars <- all(symbols_else %in% c("BBB", "BB", "B"))
cherry <- any(symbols_else == "C")

#计算prize
if(same){
    playout <- c("7" = 80, "BBB" = 40, "BB" = 25, "B" =10, 
                 "C" = 10, "0" = 0)
    prize <- unname(playout[symbols_else[1]])
    prize * 2^num
}else if(bars){
    prize <- 5
    prize * 2^num
}else if(cherry){
    prize <- 5
    prize * 2^num
}else{
    prize <- 0
}

# 步骤⑦：num == 2，计算prize
symbols <- c("C", "DD", "DD")
#判断情形
judge <- symbols == "DD"
symbols_else <- symbols[!judge]
# 必为三个一样，一个查找表搞定prize（注意0）
playout <- c("DD" = 100, "7" = 80, "BBB" = 40, 
             "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
prize <- unname(playout[symbols_else])
prize * 2^num

#步骤⑨：num == 3，计算prize
symbols <- c("DD", "DD", "DD")
num <- sum(symbols == "DD")
if(num == 3){
    prize <- 100
    prize * 2^num
}

# 优化play函数
play_DD <- function(){
    symbols <- get_symbols()
    structure(score_DD(symbols), symbols = symbols, class = "slot")
}

play_DD()

#计算优化后的中奖期望金额
wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
combs <- expand.grid(wheel, wheel, wheel, stringsAsFactors = FALSE)
prob <- c("DD" = 0.03, "7" = 0.03, "BBB" =0.06, 
          "BB" = 0.1, "B" = 0.25, "C" = 0.01, "0" = 0.52)
combs
combs$prob1 <- prob[combs$Var1]
combs$prob2 <- prob[combs$Var2]
combs$prob3 <- prob[combs$Var3]
head(combs)
combs$prob <- combs$prob1 * combs$prob2 * combs$prob3
head(combs)
sum(combs$prob)

combs$prize <- NA
head(combs)
for (i in 1:343) {
    symbols <- c(combs[i, 1], combs[i, 2], combs[i, 3])
    combs$prize[i] <- score_DD(symbols)
}
head(combs)

# 计算期望金额
sum(combs$prize * combs$prob)

# 9.4 While循环
while(condi){
    code
}

plays_till_broke <- function(start_with) {
  cash <- start_with
  n <- 0
  while(cash > 0){
      cash <- cash - 1 + play_DD()
      n <- n + 1
  }
  n
}
plays_till_broke(100)
mean(replicate(100, plays_till_broke(100)))

#  9.5 repeat循环
plays_till_broke_2.0 <- function(start_with) {
    cash <- start_with
    n <- 0
    repeat{
        cash <- cash - 1 + play_DD() #这里之前敲错了cash导致没法结束循环！
        n <- n + 1
        if(cash == 0){
            break
        }
    }
    n
}
plays_till_broke_2.0(100)
mean(replicate(100, plays_till_broke_2.0(100)))

# 第10章 代码提速 ====
# 10.1 向量化代码
abs_loop <- function(vec){
    for (i in 1:length(vec)) {
        if(vec[i] < 0) {
            vec[i] <- -vec[i]
        }
    }
    vec
}

abs_set <- function(vec) {
    negs <- vec < 0
    vec[negs] <- vec[negs] * -1
    vec
}

long <- rep(c(-1, 1), 500000)
system.time(abs_loop(long))
system.time(abs_set(long))
system.time(abs(long))

test <- 1:10
for (i in 1:10) {
    if(test[i] %% 2 == 0){
        test[i] <- test[i] * -1
    }
}
test
test < 0
test[test < 0]
test[test < 0] * -1 # 判断（测试）到选取（取子集）到运算（元素方式执行），一气呵成！
test[test < 0] * -1
test[test < 0] <- test[test < 0] * -1
test
test[test < 0] <- test[test < 0] * -1
test

# 练习，函数优化
change_symbols <- function(vec){
    for (i in 1:length(vec)) {
        if(vec[i] == "DD"){
            vec[i] <- "joker"
        }else if(vec[i] == "C"){
            vec[i] <- "ace"
        }else if(vec[i] == "7"){
            vec[i] <- "king"
        }else if(vec[i] == "B"){
            vec[i] <- "queen"
        }else if(vec[i] == "BB"){
            vec[i] <- "jack"
        }else if(vec[i] == "BBB"){
            vec[i] <- "ten"
        }else{
            vec[i] <- "nine"
        }
    }
    vec
}

vec <- c("DD", "C", "7", "B", "BB", "BBB", "0")
change_symbols(vec)
many <- rep(vec, 1000000)
system.time(change_symbols(many))

change_symbols_faster <- function(vec) {
    vec[vec == "DD"] <- "joker"
    vec[vec == "C"] <- "ace"
    vec[vec == "7"] <- "king"
    vec[vec == "B"] <- "queen"
    vec[vec == "BB"] <- "jack"
    vec[vec == "BBB"] <- "ten"
    vec[vec == "0"] <- "nine"
    vec
}
vec <- c("DD", "C", "7", "B", "BB", "BBB", "0")
change_symbols_faster(vec)
many <- rep(vec, 1000000)
system.time(change_symbols_faster(many))

change_symbols_fastest <- function(vec){
    tb <- c("DD" = "joker", "C" = "ace", "7" = "king", 
            "B" = "queen", "BB" = "jack", "BBB" = "ten", 
            "0" = "nine")
    unname(tb[vec])
}
system.time(change_symbols_fastest(many))

system.time({
    output <- rep(NA, 1000000)
    for (i in 1:1000000) {
    output[i] <- i + 1
    }
})

system.time({
    output <- NA
    for (i in 1:1000000) {
        output[i] <- i + 1
    }
})

# 10.4 向量化编程实战
winnings <- vector(length = 1000000)
for (i in 1:1000000) {
    winnings[i] <- play_DD()
}
mean(winnings)
system.time(for (i in 1:1000000) {
    winnings[i] <- play_DD()
})

get_many_symbols <- function(n){
    wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
    vec <- sample(wheel, 3 * n, replace = TRUE, 
                  prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
    matrix(vec, ncol = 3)
}
get_many_symbols(5)

play_many <- function(n){
    symb_mat <- get_many_symbols(n = n)
    data.frame(w1 = symb_mat[ , 1], w2 = symb_mat[ , 2], 
               w3 = symb_mat[ , 3], prize = score_many(symbols = symb_mat))
}


# rowSums函数功能：
x <- cbind(x1 = 3, x2 = c(4:1, 2:5))
x
rowSums(x)

# 热身及草稿处
symbols <- matrix(c("DD", "7", "BBB", "DD", "7", "BBB", "DD", "7", "BBB"), 
                  ncol = 3)
symbols
prize_list <- vector(length = length(symbols[, 1]))
length(symbols[, 1])

symbols_one <- c(symbols[1, 1],  symbols[1, 2], symbols[1, 3])
score_DD(symbols_one)
rowSums(symbols == "DD")
num <- rowSums(symbols == "DD")
length(symbols[ ,1])
prize <- vector(length = length(symbols[ ,1]))
prize[1] <- 800
symbols[1, ] == "DD"
num[2]
100 * 2^num[1]
# 开写score_many函数
score_many <- function(symbols) {
    num <- rowSums(symbols == "DD")
    for (i in 1:length(symbols[ ,1])) {
        if(num[i] == 0){
            # 识别情形
            same <- symbols[i, 1] == symbols[i, 2] && symbols[i, 2] == symbols[i, 3]
            bars <- all(symbols[i, ] %in% c("B", "BB", "BBB")) 
            
            # 计算中奖金额
            if(same){
                playout <- c("DD" = 100, "7" = 80, "BBB" = 40, 
                             "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
                prize[i] <- unname(playout[symbols[i, 1]])
            }else if(bars){
                prize[i] <- 5
            }else{
                cherries <- sum(symbols[i, ] == "C")
                prize[i] <- c(0, 2, 5)[cherries + 1]
            }
        }else if(num[i] == 1){
            # 判断情形
            judge <- symbols[i, ] == "DD"
            symbols_else <- symbols[i, ][!judge]
            same <- symbols_else[1] == symbols_else[2]
            bars <- all(symbols_else %in% c("BBB", "BB", "B"))
            cherry <- any(symbols_else == "C")
            
            #计算prize
            if(same){
                playout <- c("7" = 80, "BBB" = 40, "BB" = 25, "B" =10, 
                             "C" = 10, "0" = 0)
                prize[i] <- unname(playout[symbols_else[1]]) * 2^num[i]
            }else if(bars){
                prize[i] <- 5 * 2^num[i]
            }else if(cherry){
                prize[i] <- 5 * 2^num[i]
            }else{
                prize <- 0
            }
        }else if(num[i] == 2){
            #判断情形
            judge <- symbols[i, ] == "DD"
            symbols_else <- symbols[!judge]
            # 必为三个一样，一个查找表搞定prize（注意0）
            playout <- c("DD" = 100, "7" = 80, "BBB" = 40, 
                         "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
            prize[i] <- unname(playout[symbols_else]) * 2^num[i]
        }else if(num[i] == 3){
            prize <- 100 * 2^num[i]
        }
    }
    prize
}
symbols <- matrix(c("0", "0", "0", "0", "B", "C", "0", "B", "C"), 
                  ncol = 3)
symbols
score_many(symbols)

play_many(10) 
#这里有bug，当0出现时，有时会返还一个NA，等学了Debug再解决吧！不要停止不前！

num <- rowSums(symbols == "DD")
symbols <- matrix(c("0","BB","0","0","0","BBB","0","0","0"), 
                  byrow = TRUE, ncol = 3)
symbols
score_many(symbols)

# 测验


# 作者答案(不用if和for有点不习惯，甚至难受，但这就是R，慢慢习惯吧！)
symbols <- matrix(c("DD", "DD", "DD", 
                    "C", "DD", "0", 
                    "0", "DD", "B", 
                    "DD", "BB", "BBB", 
                    "C", "C", "0", 
                    "7", "DD", "DD"), nrow = 6, byrow = TRUE)
score_many <- function(symbols) {
    # 第1步：根据樱桃和钻石出现的情况分配基础金额 -------------
    cherries <- rowSums(symbols == "C")
    diamonds <- rowSums(symbols == "DD")
    # 将百搭钻石视为樱桃，计算金额
    prize <- c(0, 2, 5)[cherries + diamonds + 1]
    # 但当一个樱桃都没有时例外
    # 当cherries == 0时，cherries被强制转换为FALSE
    prize[!cherries] <- 0
    
    # 第2步：当符号组合是三个相同的符号时，改变金额 -----------
    same <- symbols[ , 1] == symbols[ , 2] & symbols[ , 2] == symbols[ , 3]
    payoffs <- c("DD" = 100, "7" = 80, "BBB" = 40, 
                "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
    prize[same] <- payoffs[symbols[same, 1]]
    
    # 第3步：当符号组合中全是杠时，改变金额--------------------
    bars <- symbols == "B" | symbols == "BB" | symbols == "BBB"
    all_bars <- bars[ , 1] & bars[ , 2] &  bars[ , 3] & !same
    prize[all_bars] <- 5
    
    # 第4步：处理百搭符号 -------------------------------------
    ## 当有两个钻石时
    two_wilds <- diamonds == 2
    
    ### 识别出剩余符号
    one <- two_wilds & symbols[ , 1] != symbols[ , 2] & symbols[ , 2] == symbols[ , 3]
    two <- two_wilds & symbols[ , 1] != symbols[ , 2] & symbols[ , 1] == symbols[ , 3]
    three <- two_wilds & symbols[ , 1] == symbols[ , 2] & symbols[ , 2] != symbols[ , 3]
    
    ### 当作三个相同的符号处理
    prize[one] <- payoffs[symbols[one, 1]]
    prize[two] <- payoffs[symbols[two, 2]]
    prize[three] <- payoffs[symbols[three, 3]]
    
    ## 当只有一个钻石时
    one_wild <- diamonds == 1
    
    ### 当作全杠来处理（如果合适的话）
    wild_bars <- one_wild & (rowSums(bars) == 2)
    prize[wild_bars] <- 5
    
    ### 当作三个相同的符号处理（如果合适的话）
    one <- one_wild & symbols[ , 1] == symbols[ , 2]
    two <- one_wild & symbols[ , 2] == symbols[ , 3]
    three <- one_wild & symbols[ , 1] == symbols[ , 3]
    prize[one] <- payoffs[symbols[one, 1]]
    prize[two] <- payoffs[symbols[two, 2]]
    three[three] <- payoffs[symbols[three, 3]]
    
    # 第5步：根据组合中出现的钻石个数，加倍金额
    unname(prize * 2^diamonds)
}
play_many(100)
plays <- play_many(1000000)
mean(plays$prize)
system.time(play_many(1000000))

# 附录 ---------------------------------------------
update.packages(c("ggplot2", "reshape2", "dplyr"))

help(package = "datasets")
library(help = "datasets")

iris

getwd()

setwd("/Users/yangzeping/YangZeping's R Files/《R语言入门与实践》")
getwd()

poker

df <- data.frame("card" = c("ace", "king", "queen", "jack", "ten"), 
           "suit" = c("spades", "spades", "spades", "spades", "spades"), 
           "value" = 14:10)
df
write.csv(df, file = "poker.csv", row.names = FALSE)
read.table("poker.csv", sep = ",", header = TRUE)

df <- data.frame("card" = c("ace", "king", "queen", "jack", "ten"), 
                 "suit" = c("spades", "spades", ".", ".", "."), 
                 "value" = 14:10)
df
write.csv(df, file = "poker.csv", row.names = FALSE)
read.table("poker.csv", sep = ",", header = TRUE, na.strings = ".")

df <- read.table("poker.csv", header = TRUE, sep = ",", skip = 3, 
           nrows = 5)
?read.table

write.csv(df, file = bzfile("poker.csv.bz2"), row.names = FALSE)

read.table("poker.csv.bz2")

saveRDS(df,file = "poker.RDS")
poker2 <- readRDS("poker.RDS")
poker2
# 1k行
a <- 1
b <- 2
c <- 3
save(a, b, c, file = "stuff.RData")
load("stuff.RData")
saveRDS(a, "stuff.RDS")
a <- readRDS("stuff.RDS")
a

b <- read.table(pipe("pbpaste"))
b
typeof(b)
class(b)

install.packages("XLConnect")
library(XLConnect) #没能搞定java runtime environment！
vignette("XLConnect")
edit(file = system.file("XLConnect.R", package = "XLConnect"))
help(XLConnect)
?XLConnect

first <- function() second()
second <- function() third()
third <- function() fourth()
fourth <- function() fifth()
fifth <- function() bug()
first()

traceback()

fifth <- function() second()

first()

traceback()

score <- function(symbols){
    # 识别情形
    same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
    bars <- all(symbols %in% c("B", "BB", "BBB")) 
    
    # 计算中奖金额
    if(same){
        playout <- c("DD" = 100, "7" = 80, "BBB" = 40, 
                     "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
        prize <- unname(playout[symbols[1]])
    }else if(bars){
        prize <- 5
    }else{
        cherries <- sum(symbols == "C")
        prize <- c(0, 2, 5)[cherries + 1]
    }
    
    # 根据钻石的个数调整中奖金额
    diamonds <- sum(symbols == "DD")
    prize * 2 ^ diamonds
}

View(play)

play <- function(){
    symbols <- get_symbols()
    structure(score(symbols), symbols = symbols)
}

play()

score_many <- function(symbols) {
    # 第1步：根据樱桃和钻石出现的情况分配基础金额 -------------
    cherries <- rowSums(symbols == "C")
    diamonds <- rowSums(symbols == "DD")
    # 将百搭钻石视为樱桃，计算金额
    prize <- c(0, 2, 5)[cherries + diamonds + 1]
    # 但当一个樱桃都没有时例外
    # 当cherries == 0时，cherries被强制转换为FALSE
    prize[!cherries] <- 0
    
    # 第2步：当符号组合是三个相同的符号时，改变金额 -----------
    same <- symbols[ , 1] == symbols[ , 2] & symbols[ , 2] == symbols[ , 3]
    payoffs <- c("DD" = 100, "7" = 80, "BBB" = 40, 
                 "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
    prize[same] <- payoffs[symbols[same, 1]]
    
    # 第3步：当符号组合中全是杠时，改变金额--------------------
    bars <- symbols == "B" | symbols == "BB" | symbols == "BBB"
    all_bars <- bars[ , 1] & bars[ , 2] &  bars[ , 3] & !same
    prize[all_bars] <- 5
    
    # 第4步：处理百搭符号 -------------------------------------
    ## 当有两个钻石时
    two_wilds <- diamonds == 2
    
    ### 识别出剩余符号
    one <- two_wilds & symbols[ , 1] != symbols[ , 2] & symbols[ , 2] == symbols[ , 3]
    two <- two_wilds & symbols[ , 1] != symbols[ , 2] & symbols[ , 1] == symbols[ , 3]
    three <- two_wilds & symbols[ , 1] == symbols[ , 2] & symbols[ , 2] != symbols[ , 3]
    
    ### 当作三个相同的符号处理
    prize[one] <- payoffs[symbols[one, 1]]
    prize[two] <- payoffs[symbols[two, 2]]
    prize[three] <- payoffs[symbols[three, 3]]
    
    ## 当只有一个钻石时
    one_wild <- diamonds == 1
    
    ### 当作全杠来处理（如果合适的话）
    wild_bars <- one_wild & (rowSums(bars) == 2)
    prize[wild_bars] <- 5
    
    ### 当作三个相同的符号处理（如果合适的话）
    one <- one_wild & symbols[ , 1] == symbols[ , 2]
    two <- one_wild & symbols[ , 2] == symbols[ , 3]
    three <- one_wild & symbols[ , 1] == symbols[ , 3]
    prize[one] <- payoffs[symbols[one, 1]]
    prize[two] <- payoffs[symbols[two, 2]]
    three[three] <- payoffs[symbols[three, 3]]

    # 第5步：根据组合中出现的钻石个数，加倍金额
    unname(prize * 2^diamonds)
}

play_many(100)

debug(sample)
sample(1:6, size = 3, replace = TRUE)
undebug(sample)
isdebugged(sample)
debugonce(sample)

trace("sample", browser, at = 2)

trace(print)
first
head(deck2)

untrace(sample)
untrace(print)

fifth <- function() recover()

first()

options(error = recover)
options(error = NULL)
