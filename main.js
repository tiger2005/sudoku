import {lastRemainingCellInference, possibleNumberInference} from "./helper.js"

const sudoku_test = () => {
  const assert_eq = (arr1, arr2) => {
    console.assert(arr1.length == arr2.length)
    for (let i = 0; i < arr1.length; i ++) {
      console.assert(arr1[i] == arr2[i])
    }
  }

  const test1 = [
    [2, 0, 0, 0, 7, 0, 0, 3, 8],
    [0, 0, 0, 0, 0, 6, 0, 7, 0],
    [3, 0, 0, 0, 4, 0, 6, 0, 0],
    [0, 0, 8, 0, 2, 0, 7, 0, 0],
    [1, 0, 0, 0, 0, 0, 0, 0, 6],
    [0, 0, 7, 0, 3, 0, 4, 0, 0],
    [0, 0, 4, 0, 8, 0, 0, 0, 9],
    [0, 6, 0, 4, 0, 0, 0, 0, 0],
    [9, 1, 0, 0, 6, 0, 0, 0, 2]
  ];

  let res1 = lastRemainingCellInference(test1)
  for (let i = 0; i < 9; i ++) {
    for (let j = 0; j < 9; j ++) {
      console.assert(res1[i][j].length != 0)
    }
  }

  assert_eq(res1[0][1], [4])
  assert_eq(res1[7][0], [8])
  
  const test2 = [
    [0, 7, 0, 4, 0, 8, 0, 2, 9],
    [0, 0, 2, 0, 0, 0, 0, 0, 4],
    [8, 5, 4, 0, 2, 0, 0, 0, 7],
    [0, 0, 8, 3, 7, 4, 2, 0, 0],
    [0, 2, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 3, 2, 6, 1, 7, 0, 0],
    [0, 0, 0, 0, 9, 3, 6, 1, 2],
    [2, 0, 0, 0, 0, 0, 4, 0, 3],
    [1, 3, 0, 6, 4, 2, 0, 7, 0]
  ];
  
  let res2 = possibleNumberInference(test2)

  for (let i = 0; i < 9; i ++) {
    for (let j = 0; j < 9; j ++) {
      console.assert(res2[i][j].length != 0)
    }
  }

  assert_eq(res2[4][3], [5, 8, 9])
  assert_eq(res2[4][4], [5, 8])
  assert_eq(res2[4][5], [5, 9])
}

sudoku_test()
