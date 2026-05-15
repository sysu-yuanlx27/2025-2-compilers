#import "@local/sysu-assignment:0.1.0": *

#show: assignment.with(
  title: "编译原理理论作业",
  subtitle: "第四章作业（二）",
  student: (name: "元朗曦", id: "23336294"),
  lang: "zh",
)

#problem[
  证明文法 $G[S]$：

  $
    S &-> C a | b C e | D e | b D a \
    C &-> d \
    D &-> d
  $

  是 $"LR"(1)$ 而不是 $"LALR"(1)$ 的，构造 $"LR"(1)$ 分析表，并对输入字符串 $b d a dollar$ 进行 $"LR"(1)$ 分析，写出分析的全过程（表格形式）．
][
  设增广文法为 $S' -> S$，并计算 $"LR"(1)$ 项目集如下（部分略）：

  $
    I_5: "GOTO"(I_0, d) = cases(
      C -> d dot & quad a,
      D -> d dot & quad e,
    ) \

    I_9: "GOTO"(I_3, d) = cases(
      C -> d dot & quad e,
      D -> d dot & quad a,
    )
  $

  观察关键项目集，展望符均不相交，无归约-归约冲突，则 $G[S]$ 是 $"LR"(1)$ 文法；而合并同心项目集后，我们得到：

  $
    I_59 = cases(
      C -> d dot & quad {a, e},
      D -> d dot & quad {a, e},
    )
  $

  此时面对 $a$ 和 $e$ 均产生归约-归约冲突，故 $G[S]$ 不是 $"LALR"(1)$ 文法．

  构造 $"LR"(1)$ 分析表如下：

  #figure(table(
    align: horizon,
    columns: 9,
    table.header(
      table.cell(rowspan: 2, [*状态*]),
      table.cell(colspan: 5, [*ACTION*]),
      table.cell(colspan: 3, [*GOTO*]),
      $a$, $b$, $d$, $e$, $dollar$, $S$, $C$, $D$,
    ),
    [0], [], $s_3$, $s_5$, [], [], $1$, $2$, $4$,
    [1], [], [], [], [], $"accept"$, [], [], [],
    [2], $s_6$, [], [], [], [], [], [], [],
    [3], [], [], $s_9$, [], [], [], $7$, $8$,
    [4], [], [], [], $s_10$, [], [], [], [],
    [5], $r(C -> d)$, [], [], $r(D -> d)$, [], [], [], [],
    [6], [], [], [], [], $r(S -> C a)$, [], [], [],
    [7], [], [], [], $s_11$, [], [], [], [],
    [8], $s_12$, [], [], [], [], [], [], [],
    [9], $r(D -> d)$, [], [], $r(C -> d)$, [], [], [], [],
    [10], [], [], [], [], $r(S -> D e)$, [], [], [],
    [11], [], [], [], [], $r(S -> b C e)$, [], [], [],
    [12], [], [], [], [], $r(S -> b D a)$, [], [], [],
  ))

  按照分析表，对输入串 $b d a dollar$ 进行 $"LR"(1)$ 分析，过程如下：

  #figure(table(
    columns: 5,
    table.header(
      [*步骤*], [*状态栈*], [*符号栈*], [*剩余输入*], [*动作*],
    ),
    [1], $s_0$, $hash$, $b d a dollar$, [查 $"ACTION"(0, b) = s_3$，移入 $b$],
    [2], $s_0 s_3$, $hash b$, $d a dollar$, [查 $"ACTION"(3, d) = s_9$，移入 $d$],
    [3], $s_0 s_3 s_9$, $hash b d$, $a dollar$, [查 $"ACTION"(9, a) = r(D -> d)$，归约 $D -> d$],
    [4], $s_0 s_3$, $hash b D$, $a dollar$, [查 $"GOTO"(3, D) = s_8$，转到 $s_8$],
    [5], $s_0 s_3 s_8$, $hash b D$, $a dollar$, [查 $"ACTION"(8, a) = s_12$，移入 $a$],
    [6], $s_0 s_3 s_8 s_12$, $hash b D a$, $dollar$, [查 $"ACTION"(12, dollar) = r(S -> b D a)$，归约 $S -> b D a$],
    [7], $s_0$, $hash S$, $dollar$, [查 $"GOTO"(0, S) = 1$，转到 $s_1$],
    [8], $s_0 s_1$, $hash S$, $dollar$, [查 $"ACTION"(1, dollar) = "accept"$，接受],
  ))

  则输入串 $b d a dollar$ 是文法 $G[S]$ 的合法句子．
]