/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Luís Alves
 * Creation Date: 4 Dec 2018 at 19:23:01
 *********************************************/
int n = ...; // grid of nxn
int cn[1..n][1..n] = ...; // arcs from yx to y-1x
int cs[1..n][1..n] = ...; // arcs from yx to y+1x
int ce[1..n][1..n] = ...; // arcs from yx to yx+1
int co[1..n][1..n] = ...; // arcs from yx to yx-1
int origemX = 1;
int origemY = 1;

dvar int numPathsN[1..n][1..n]; // num of paths from yx to y-1x
dvar int numPathsS[1..n][1..n]; // num of paths from yx to y+1x
dvar int numPathsE[1..n][1..n]; // num of paths from yx to yx+1
dvar int numPathsO[1..n][1..n]; // num of paths from yx to yx-1

minimize sum (y in 1..n, x in 1..n) (numPathsN[y][x]*cn[y][x] + numPathsS[y][x]*cs[y][x] + numPathsE[y][x]*ce[y][x] + numPathsO[y][x]*co[y][x]);

subject to {

	// origin needs this much
	d1: n*n - 1 == (numPathsN[origemY][origemX] + numPathsS[origemY][origemX] + numPathsE[origemY][origemX] + numPathsO[origemY][origemX]);
	// for middle fires
	d2: forall (y in 2..n-1, x in 2..n-1) (numPathsN[y+1][x] + numPathsS[y-1][x] + numPathsE[y][x-1] + numPathsO[y][x+1]) == 1 + (numPathsN[y][x] + numPathsS[y][x] + numPathsE[y][x] + numPathsO[y][x]);
	// for left fires
	d3: forall (y in 2..n-1) (numPathsN[y+1][1] + numPathsS[y-1][1] + numPathsO[y][2]) == 1 + (numPathsN[y][1] + numPathsS[y][1] + numPathsE[y][1]);
	// for right fires
	d4: forall (y in 2..n-1) (numPathsN[y+1][n] + numPathsS[y-1][n] + numPathsE[y][n-1]) == 1 + (numPathsN[y][n] + numPathsS[y][n] + numPathsO[y][n]);
	// for top fires
	d5: forall (x in 2..n-1) (numPathsN[2][x] + numPathsO[1][x+1] + numPathsE[1][x-1]) == 1 + (numPathsE[1][x] + numPathsS[1][x] + numPathsO[1][x]);
	// for bottom fires
	d6: forall (x in 2..n-1) (numPathsS[n-1][x] + numPathsO[n][x+1] + numPathsE[n][x-1]) == 1 + (numPathsE[n][x] + numPathsN[n][x] + numPathsO[n][x]);
	// for right up corner
	d7: numPathsN[2][n] + numPathsE[1][n-1] == 1 + numPathsS[1][n] + numPathsO[1][n];
	// for right bottom corner
	d8: numPathsS[n-1][n] + numPathsE[n][n-1] == 1 + numPathsN[n][n] + numPathsO[n][n];
	// for left bottom corner
	d9: numPathsS[n-1][1] + numPathsO[n][2] == 1 + numPathsN[n][1] + numPathsE[n][1];
	// no left up corner cause it's origin
	// no negative
	d10: forall(y in 1..n, x in 1..n) numPathsN[y][x] >= 0;
	d11: forall(y in 1..n, x in 1..n) numPathsS[y][x] >= 0;
	d12: forall(y in 1..n, x in 1..n) numPathsE[y][x] >= 0;
	d13: forall(y in 1..n, x in 1..n) numPathsO[y][x] >= 0;
	// no paths from borders
	d14: forall(x in 1..n) numPathsN[1][x] == 0;
	d15: forall(x in 1..n) numPathsS[n][x] == 0;
	d16: forall(y in 1..n) numPathsE[y][n] == 0;
	d17: forall(y in 1..n) numPathsO[y][1] == 0;
}