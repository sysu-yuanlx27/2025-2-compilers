#import "@local/sysu-exercise:0.1.0": *
#import "@preview/fletcher:0.5.8": diagram, node, edge

#show: exercise.with(
  title: "第三章作业",
  subtitle: "编译原理（理论）",
  student: (name: "元朗曦", id: "23336294"),
  lang: "zh",
)

#problem[
  将下图 DFA 最小化．

  #figure(
    diagram(
      label-sep: 0.1em,
      node-fill: green,
      node-stroke: 0.1em + black,

      node((0, 0), $0$, name: <0>, extrude: (0, 0.2em), outset: 0.2em),
      edge(<0>, <1>, $b$, "->"),
      edge(<0>, <2>, $a$, "->"),
      node((0, 1), $1$, name: <1>),
      edge(<1>, <1>, $b$, "->", bend: 135deg, loop-angle: 270deg),
      edge(<1>, <4>, $a$, "->"),
      node((1, 0), $2$, name: <2>),
      edge(<2>, <3>, $a$, "->", shift: 0.2em),
      edge(<2>, <4>, $b$, "->"),
      node((2, 0), $3$, name: <3>),
      edge(<3>, <2>, $b$, "->", label-side: left, shift: 0.2em),
      edge(<3>, <3>, $a$, "->", bend: 135deg, loop-angle: 0deg),
      node((1, 1), $4$, name: <4>),
      edge(<4>, <0>, $a$, "->"),
      edge(<4>, <5>, $b$, "->", shift: 0.2em),
      node((2, 1), $5$, name: <5>),
      edge(<5>, <4>, $a$, "->", label-side: left, shift: 0.2em),
      edge(<5>, <5>, $b$, "->", bend: 135deg, loop-angle: 0deg),
    ),
  )
][
  按照龙书*算法 3.39*的步骤化简．

  + 将所有状态划分成终态集和非终态集．

    $
      {0}, {1, 2, 3, 4, 5}.
    $

  + 继续划分不等价的状态，直到无法继续划分．

    $
      {0}, {1, 2, 3, 4, 5} =>
      {0}, {1, 2, 3, 5}, {4} =>
      {0}, {1, 5}, {2}, {3}, {4}.
    $

  + 从每一组状态中取一个作为代表，并删除同组的其他状态．

    $
      {0}, {1}, {2}, {3}, {4}.
    $

  + 画出最小 DFA 如下．

    #figure(
      diagram(
        label-sep: 0.1em,
        node-fill: green,
        node-stroke: 0.1em + black,

        node((0, 0), $0$, name: <0>, extrude: (0, 0.2em), outset: 0.2em),
        edge(<0>, <1>, $b$, "->"),
        edge(<0>, <2>, $a$, "->"),
        node((0, 1), $1$, name: <1>),
        edge(<1>, <1>, $b$, "->", bend: 135deg, loop-angle: 270deg),
        edge(<1>, <4>, $a$, "->", shift: 0.2em),
        node((1, 0), $2$, name: <2>),
        edge(<2>, <3>, $a$, "->", shift: 0.2em),
        edge(<2>, <4>, $b$, "->"),
        node((2, 0), $3$, name: <3>),
        edge(<3>, <2>, $b$, "->", label-side: left, shift: 0.2em),
        edge(<3>, <3>, $a$, "->", bend: 135deg, loop-angle: 0deg),
        node((1, 1), $4$, name: <4>),
        edge(<4>, <0>, $a$, "->"),
        edge(<4>, <1>, $b$, "->", label-side: left, shift: 0.2em),
      ),
    )
]