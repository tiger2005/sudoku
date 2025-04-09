#import "../../../template-experiment/report.typ": *

#show: report.with(
  title: "从算法到⼯程 开发报告",
  subtitle: "",
  name: "陈景泰",
  stdid: "23336001",
  classid: "计科七班",
  major: "计算机科学与技术",
  school: "计算机学院",
  time: "2024~2025 学年第二学期",
  banner: "./images/sysu.png",
)

首先是整个开发流程的时间节点表格：

#table(
  columns: (40pt, 2fr, 60pt, 2fr, 0.8fr, 1.2fr),
  align: center,
  inset: 6pt,
  [分类], [任务名称], [起⽌时间], [详情], [难点], [改进想法],
  [分析], [阅读数独 Wiki 上的介绍，了解需要实现的两个基本数独推理], [00:00 $->$ 02:56], [在 sudokuwiki.org 的“基本策略”栏目中学习两个推理策略的方法], [无], [无],
  [分析], [确定文件结构，并利用 Copilot 搭建了一个基本的测试函数], [02:56 $->$ 05:40], [本次实验的工程由 `main.js`（调用和测试）和 `helper.js`（逻辑编写）组成], [无], [无],
  [编码], [根据 OOP 想法，新建 `SudokuManager` 类管理数组信息], [05:40 $->$ 07:13], [考虑到两种算法均需要进行若干共同的判断，故可以考虑进行封装管理，提供判定填入、给出候选集等功能], [无], [无],
  [编码], [为 `SudokuManager` 编写构造函数], [07:13 $->$ 10:24], [构造函数需要预处理每行、每列、每个宫格存在的数字集合], [无], [无],
  [编码], [为 `SudokuManager` 编写 `regions` 函数], [10:24 $->$ 14:38], [在构造函数初始化用于枚举的区域位置序列，并通过 `regions` 函数暴露], [无], [对于正规数独规则而言，可以将 `regions` 的返回值设定为静态常量],
  [编码], [完成 `SudokuManager` 的剩余两个函数], [14:38 $->$ 18:15], [利用预处理的数字集合可以迅速判断一个位置能够填写某个数字，以及某个位置的候选集], [无], [无],
  [编码], [完成 `LRC` 函数的主体], [18:15 $->$ 22:38], [枚举所有区域后，对每个数字确定可以填写的位置，如果只有一个，则可以确定这一数字的位置], [无], [无],
  [编码], [完成 `PN` 函数的主体], [22:38 $->$ 23:25], [直接调用已经写好的候选集方法即可], [无], [无],
  [编码], [完成对 `SudokuManager` 类的注释补全], [23:40 $->$ 28:40], [仿仿照已有的注释风格填写各个方法的功能注释], [无], [对于大型工程而言，这一行为可能要比编写实际算法早],
  [测试], [根据 PDF 需求获取数独测试，完成基本的调用框架], [28:40 $->$ 32:46], [从 PDF 的例子中摘录两个数独的信息，分别作为参数调用 `LRC` 和 `PN` 算法], [无], [此时理论上就可以加入完成的测试内容],
  [调试], [解决 JavaScript 中使用 ES6 风格导入的问题], [32:46 $->$ 33:22], [加入 `package.json` 并添加 `"type": "module"` 字段], [无], [在熟悉开发环境后可以避免这一错误],
  [调试], [发现并定位枚举区域时的非期望现象], [33:22 $->$ 38:05], [对 `JavaScript` 的 `Array` 进行 `for in` 类型枚举时发现元素并非位置序列], [无], [在熟悉开发环境后可以避免这一错误],
  [调试], [回忆枚举 `Array` 可以使用 `forEach` 并进行实现替换], [38:05 $->$ 40:30], [通过查阅资料回忆 `Array` 的元素枚举应当使用 `forEach`，随后对实现进行替换], [无], [在熟悉开发环境后可以避免这一错误],
  [调试], [回忆 JavaScript 的 lambda 函数性质并修复初始化异常], [40:30 $->$ 43:20], [定位到一些变量的初始化异常，随后回忆应当在 lambda 函数中使用 `return` 返回信息，并进行修复], [无], [在熟悉开发环境后可以避免这一错误],
  [#underline([*异常*])], [本地环境过旧导致无法使用较新特性，临时升级环境], [43:20 $->$ 50:26], [JavaScript 中 `Set` 的交集方法在 2024 年才开始推广，而本地的 Node.js 版本不足，故需要临时升级], [无], [无],
  [调试], [改写 lambda 函数使用], [50:26 $->$ 51:48], [JavaScript 中 lambda 函数的主体可以使用表达式而不是代码块，可以据此可以优化代码结构], [无], [在熟悉开发环境后可以提前完成这一工作],
  [调试], [跑通后从输出捕获到没有候选值的问题，修复无果], [51:48 $->$ 53:20], [在修复如上问题后，程序正常运行，但是可以从 `console.log` 的结果中捕捉到一些位置的候选集为空的问题，随后找到错误位置后修复], [无], [个人认为这属于 VS Code 带来的问题（见下一栏目），不过也确实可以自行保存],
  [测试], [为问题编写测试，并发现因为出错是由于文件自动保存不及时], [53:20 $->$ 55:41], [为空候选集的问题编写测试后立即测试，结果发现空候选集的问题消失了，初步判断为上一次测试时 VS Code 未能及时自动保存], [无], [见上文],
  [测试], [对每个函数给出若干个位置的期望值，测试后通过], [55:41 $->$ 59:33], [根据文档要求对若干个位置的候选集进行测试，结果均正确，故大致认为算法正确，开发结束], [无], [对于更细致的要求，可能需要将整个返回值进行检测],
)

其次是对整个开发过程的思想整理：

- 在阅读要求后，我首先意识到这是一次较为轻量的开发工作，并且其中运用的算法较为直接，可以尽情使用较为优秀的方案进行代码设计。

- 考虑到我在高中时期拥有 JavaScript 项目的编写经验，加上自己也从未认真实现 JavaScript 的 OOP 思路（也体现了曾经构思项目时的不足），本次便考虑采用和函数提示同样的语言编写开发任务。不过在实际编程任务中，由于本人深受 C/C++、Rust 和 Python 开发的影响，导致对 JavaScript 的一些属性出现淡忘，加上本地环境也停滞在相对古老的版本，故本次的开发流程并没有达到设想中的流畅度。

- 在编写任务前，我发现 `LRC` 算法和 `PN` 算法在某些层面存在共性——在预处理每行、每列以及每个宫格包含的位置和数字后，可以通过少量代码实现剩余的细节。因此，我打算利用一个新的类实现这些共同的逻辑，预处理出位置和数字的集合，并通过对应的接口暴露给 `LRC` 和 `PN` 算法。在实际的编写情况中，这一方案的确为整个算法提供了清晰的实现思路。

- 在整个编写流程中，我意识到自己对 OOP 设计的理念仍然不够清晰，对类的内部变量和成员函数在设计上仍然处于较为稚嫩的阶段，还需要通过进一步的软件工程学习进行完善。

如下是最终的代码（相较视频而言，对注释使用的类型进行了少量修改）：

```js
/**
 * 对一个数独进行管理，并提供基础的访问功能。
 * 主要的功能包括：
 * - 提供用于枚举的区域列表；
 * - 判定一个数字能否在一个数字填写；
 * - 给出一个位置的可填写数字集合
 */
class SudokuManager {
  /**
   * 管理类的构造函数，接受一个 9 * 9 的⼆维棋盘数组，
   * 在这个类的生命周期内，你不应当修改这个数组
   * @param {Array<Array<number>>} grid 数独棋盘, 9 * 9的⼆维数组，元素为0-9的数字，0表示未填写
   */
  constructor(grid) {
    this.grid = grid
    this.row_set = Array.from({ length: 9 }, (_, idx) => {
      let temp = new Set()
      for (let j = 0; j < 9; j ++) {
        if (grid[idx][j] != 0) {
          temp.add(grid[idx][j])
        }
      }
      return temp
    })
    this.col_set = Array.from({ length: 9 }, (_, idx) => {
      let temp = new Set()
      for (let j = 0; j < 9; j ++) {
        if (grid[j][idx] != 0) {
          temp.add(grid[j][idx])
        }
      }
      return temp
    })
    this.blk_set = Array.from({ length: 3 }, (_, i) => {
      return Array.from({ length: 3 }, (_, j) => {
        let temp = new Set()
        for (let x = 3 * i; x < 3 * i + 3; x ++) {
          for (let y = 3 * j; y < 3 * j + 3; y ++) {
            if (grid[x][y] != 0) {
              temp.add(grid[x][y])
            }
          }
        }
        return temp
      })
    })

    this.region_list = []
    for (let i = 0; i < 9; i ++) {
      let row_region = []
      for (let j = 0; j < 9; j ++) {
        row_region.push([i, j])
      }
      this.region_list.push(row_region)
    }

    for (let j = 0; j < 9; j ++) {
      let col_region = []
      for (let i = 0; i < 9; i ++) {
        col_region.push([i, j])
      }
      this.region_list.push(col_region)
    }
    
    for (let sx = 0; sx < 9; sx += 3) {
      for (let sy = 0; sy < 9; sy += 3) {
        let blk_region = []
        for (let i = 0; i < 3; i ++) {
          for (let j = 0; j < 3; j ++) {
            blk_region.push([sx + i, sy + j])
          }
        }
        this.region_list.push(blk_region)
      }
    }

  }

  /**
   * 提供包含了所有区域的列表，其中一个区域内部由九个位置组成，
   * 在数组完成后，这些位置上的数字应当形成 1~9 的排列。
   * @returns {Array<Array<[number, number]>>} 所有区域的列表
   */
  regions() {
    return this.region_list
  }

  /**
   * 在数独中通过行、列、宫格判断一个位置能否填入某个数字。
   * @param {number} x 位置的横坐标，需要保证在 [0, 9) 范围内
   * @param {number} y 位置的纵坐标，需要保证在 [0, 9) 范围内
   * @param {number} num 需要填入的数字，需要保证在 [1, 9] 范围内
   * @returns {bool} 数字是否能被填入
   */
  check_safe(x, y, num) {
    return (this.grid[x][y] == 0
         && !this.row_set[x].has(num)
         && !this.col_set[y].has(num)
         && !this.blk_set[Math.floor(x / 3)][Math.floor(y / 3)].has(num)
    )
  }

  /**
   * 在数组中获取一个位置能够填入的数字集合，也即候选值。
   * @param {number} x 位置的横坐标，需要保证在 [0, 9) 范围内
   * @param {number} y 位置的纵坐标，需要保证在 [0, 9) 范围内
   * @returns {Set<number>} 当前单元格的候选值（集）
   */
  possible_set(x, y) {
    if (this.grid[x][y] != 0) {
      return new Set([this.grid[x][y]]);
    }

    return new Set([1, 2, 3, 4, 5, 6, 7, 8, 9]).difference(
      this.row_set[x]
      .union(this.col_set[y])
      .union(this.blk_set[Math.floor(x / 3)][Math.floor(y / 3)])
    )
  }
}

/**
 * 从棋盘现有的确定值出发，如果⼀个区域（⾏、列、宫格）当前单元格之外，
 * 其余单元格均不能填写某个候选值，则可以确定当前单元格的确定值是此值。
 * @param {Array<Array<number>>} grid 数独棋盘, 9 * 9的⼆维数组，元素为0-9的数字，0表示未填写
 * @returns {Array<Array<Array<number>>>} 数独推理结果，9 * 9 * 9的三维数组，每个元素为当前单元格的候选值（集）
 */
export const lastRemainingCellInference = (grid) => {
  let manager = new SudokuManager(grid)
  let result = Array.from({ length: 9 }, (_, i) =>
    Array.from({ length: 9 }, (_, j) => {
      if (grid[i][j] != 0) {
        return new Set([grid[i][j]])
      }
      return new Set([1, 2, 3, 4, 5, 6, 7, 8, 9])
    })
  )
  manager.regions().forEach((region) => {
    for (let num = 1; num <= 9; num ++) {
      let free_count = 0
      let free_pos = undefined
      region.forEach((pos) => {
        if (manager.check_safe(pos[0], pos[1], num)) {
          ++ free_count
          free_pos = pos
        }
      })
      if (free_count == 1) {
        let x = free_pos[0], y = free_pos[1]
        result[x][y] = result[x][y].intersection(new Set([num]))
      }
    }
  })
  return Array.from({ length: 9 }, (_, i) =>
    Array.from({ length: 9 }, (_, j) =>
      Array.from(result[i][j])
    )
  )
}

/**
 * 未确定单元格的候选值应当排除其同⾏、列、宫格的确定值，据此可以推断出每个未确定单元格的候选值（集）。
 * @param {Array<Array<number>>} grid 数独棋盘, 9 * 9的⼆维数组，元素为0-9的数字，0表示未填写
 * @returns {Array<Array<Array<number>>>} 数独推理结果，9 * 9 * 9的三维数组，每个元素为当前单元格的候选值（集）
*/
export const possiblenumberInference = (grid) => {
  let manager = new SudokuManager(grid)
  return Array.from({ length: 9 }, (_, i) => 
    Array.from({ length: 9 }, (_, j) => Array.from(manager.possible_set(i, j)))
  )
}

```