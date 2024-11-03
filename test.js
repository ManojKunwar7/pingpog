let BALL_X = 0;
let BALL_Y = 0;
let BALL_DX = 1;
let BALL_DY = 1;

const ROW = 50;
const WIDTH = 320;
const HEIGHT = 200;
const BALL_WIDTH = 1;
const BALL_HEIGHT = 1;
let c = 0;

const x = [
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0],
];

let clone = [
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
];
function printMatrix(x = null, y = null, print = false) {
  // const clone = JSON.parse(JSON.stringify(x))
  if (x != null && y != null) {
    clone[x][y] = 1;
  } else {
    if (!print) {
      clone = [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
      ];
      return;
    }
  }
  if (print) console.log(clone);
}

function test() {
  console.log("--------------");
  c++;
  console.log("BALL_X ", BALL_X, "BALL_DX ", BALL_DX);
  console.log("BALL_Y ", BALL_Y, "BALL_DY", BALL_DY);
  for (let y = 0; y <= BALL_HEIGHT; y++) {
    let val = 0;
    for (let x = 0; x <= BALL_WIDTH; x++) {
      // val = (y + BALL_Y) * WIDTH;
      // val = val + x + BALL_X;
      // console.log("pos", y, x, val);

      printMatrix(BALL_Y + y, BALL_X + x);
    }
  }
  printMatrix(null, null, true);
  if (c > 3) return;
  BALL_X += BALL_DX;
  BALL_Y += BALL_DY;
  printMatrix();
  console.clear()
  test();
}

test();
