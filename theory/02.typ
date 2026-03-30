#import "@local/sysu-exercise:0.1.0": *
#import "@preview/cetz:0.4.2"

#show: exercise.with(
  title: "第二章作业",
  subtitle: "编译原理（理论）",
  student: (name: "元朗曦", id: "23336294"),
  lang: "zh",
)

#problem[
  令文法 $G[E]$ 为：

  $
    E &-> T | E + T | E - T, \
    T &-> F | T * F | T \/ F, \
    F &-> (E) | i,
  $

  证明 $E + T * (i)$ 是它的一个规范句型，指出这个句型的所有短语、直接短语和句柄．
][
  最右推导：

  $
    E => E + T => E + T * F => \
    E + T * (E) => E + T * (T) => E + T * (F) => E + T * (i).
  $

  因此 $E + T * (i)$ 是一个规范句型．

  该句型的短语有：$E + T * (i)$、$T * (i)$、$(i)$、$i$．其中 $i$ 是唯一的直接短语和句柄．
]

#problem[
  一个上下文无关文法生成句子 $a a b c c d$ 的唯一语法树如下：

  #figure(
    cetz.canvas({
      import cetz.draw: *
      import cetz.tree

      set-style(content: (padding: 0.5em))

      tree.tree(
        (
          $S$,
          ($A$, $a$),
          ($B$, ($A$, $a$), ($B$, $b$), ($C$, $c$)),
          ($C$, ($C$, $c$), $d$),
        ),
      )
    }),
  )

  + 给出该句子相应的最左推导和最右推导．

  + 该文法的产生式集合 $P$ 可能有哪些元素？

  + 找出该句子的所有短语、简单短语和句柄．
][
  最左推导为：

  $
    S => A B C => a B C => a A B C C => \
    a a B C C => a a b C C => a a b c C => a a b c C d => a a b c c d.
  $

  最右推导为：

  $
    S => A B C => A B C d => A B c d => \
    A A B C c d => A A B c c d => A A b c c d => A a b c c d => a a b c c d.
  $

  将语法树读出，可得集合 $P$ 可能包含的产生式：

  $
    S &-> A B C, \
    A &-> a, \
    B &-> A B C | b, \
    C &-> c | C d.
  $

  由语法树可得，句子 $a a b c c d$ 的短语有：

  $
    a a b c c d, a, a b c, c d, b, c.
  $

  其中，简单短语为 $a$、$b$、$c$，句柄为 $a$．
]