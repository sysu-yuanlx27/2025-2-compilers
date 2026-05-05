#import "@local/sysu-assignment:0.1.0": *

#show: assignment.with(
  title: "编译原理理论作业",
  subtitle: "第五章作业",
  student: (name: "元朗曦", id: "23336294"),
  lang: "zh",
)

#problem[
  给定 $"LL"(1)$ 文法 $G[S]$ 及其翻译模式：

  ```text
  S -> A b {B.in_num = A.num}
       B {if B.num = 0 then print("Accepted!") else print("Refused!")}
  A -> a A_1 {A.num = A_1.num + 1}
  A -> ε {A.num = 0}
  B -> a {B_1.in_num = B.in_num} B_1 {B.num = B_1.num - 1}
  B -> b {B_1.in_num = B.in_num} B_1 {B.num = B_1.num}
  B -> ε {B.num = B.in_num}
  ```

  试对该翻译模式构造相应的递归下降预测翻译程序．
][
  先观察各属性的含义：

  + `A.num` 是第一个 `b` 前面连续出现的 `a` 的个数；

  + `B.in_num` 把 `A.num` 传给 `B`；

  + `B.num` 是扫描 `B` 所生成串以后剩余的计数值，其中遇到一个 `a` 就减一，遇到一个 `b` 不变．

  因此，在递归下降程序中，可以把综合属性写成返回值，把继承属性写成过程参数：

  + 过程 `A()` 返回 `A.num`；

  + 过程 `B(in_num)` 返回 `B.num`；

  + 过程 `S()` 调用 `A()` 得到计数，匹配中间的 `b`，再把该计数作为参数传给 `B`．

  记当前输入符号为 `lookahead`，`match(t)` 表示当前符号为 `t` 时读入下一个输入符号，否则报告语法错误．递归下降预测翻译程序如下：

  ```text
  procedure S()
      a_num = A()
      match('b')
      b_num = B(a_num)

      if b_num == 0 then
          print("Accepted!")
      else
          print("Refused!")
  ```

  对非终结符 `A`，有

  ```
  FIRST(a A_1) = {a},
  FOLLOW(A) = {b}.
  ```

  所以看到 `a` 时选择第一条产生式，看到 `b` 时选择 `epsilon` 产生式：

  ```text
  function A() returns integer
      if lookahead == 'a' then
          match('a')
          a1_num = A()
          return a1_num + 1
      else if lookahead == 'b' then
          return 0
      else
          error()
  ```

  对非终结符 `B`，有

  ```
    FIRST(a B_1) = {a},
    FIRST(b B_1) = {b},
    FOLLOW(B) = {$}.
  ```

  所以看到 `a` 时选择第一条产生式，看到 `b` 时选择第二条产生式，看到输入结束符 `$` 时选择 `ε` 产生式：

  ```text
  function B(in_num) returns integer
      if lookahead == 'a' then
          match('a')
          b1_num = B(in_num)
          return b1_num - 1
      else if lookahead == 'b' then
          match('b')
          b1_num = B(in_num)
          return b1_num
      else if lookahead == '$' then
          return in_num
      else
          error()
  ```

  最后由主程序初始化输入并调用开始符号对应的过程：

  ```text
  lookahead = next_token()
  S()
  match('$')
  ```

  该程序与原翻译模式中的语义动作等价：`A()` 自右向左综合出第一个 `b` 前的 `a` 的个数；`B(in_num)` 递归扫描第一个 `b` 后的符号串，并在每个 `a` 处把最终结果减一；若最后得到的 `B.num` 为 `0`，则说明第一个 `b` 前后的 `a` 个数相等，输出 `Accepted!`，否则输出 `Refused!`．
]
