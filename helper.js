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
