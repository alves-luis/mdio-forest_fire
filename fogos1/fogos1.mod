/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Luís Alves
 * Creation Date: 4 Dec 2018 at 19:23:01
 *********************************************/
int n = ...; // grid of nxn
int cn[1..n][1..n] = ...; // arcs from ij to i(j-1)
int cs[1..n][1..n] = ...; // arcs from ij to i(j+1)
int ce[1..n][1..n] = ...; // arcs from ij to (i+1)j
int co[1..n][1..n] = ...; // arcs from ij to (i-1)j
int origemX = 1;
int origemY = 1;

dvar int numPathsN[1..n][1..n]; // num of paths from ij to i(j-1)
dvar int numPathsS[1..n][1..n]; // num of paths from ij to i(j+1)
dvar int numPathsE[1..n][1..n]; // num of paths from ij to (i+1)j
dvar int numPathsO[1..n][1..n]; // num of paths from ij to (i-1)j

minimize sum (i in 1..n, j in 1..n) (numPathsN[i][j]*cn[i][j] + numPathsS[i][j]*cs[i][j] + numPathsE[i][j]*ce[i][j] + numPathsO[i][j]*co[i][j]);

subject to {

	// origin needs this much
	n*n - 1 == (numPathsN[origemX][origemY] + numPathsS[origemX][origemY] + numPathsE[origemX][origemY] + numPathsO[origemX][origemY]);
	// for middle fires
	forall (i in 2..n-1, j in 2..n-1) (numPathsN[i][j+1] + numPathsS[i][j-1] + numPathsE[i-1][j] + numPathsO[i+1][j]) == 1 + (numPathsN[i][j] + numPathsS[i][j] + numPathsE[i][j] + numPathsO[i][j]);
	// for left fires
	forall (j in 2..n-1) (numPathsN[1][j+1] + numPathsS[1][j-1] + numPathsO[2][j]) == 1 + (numPathsN[1][j] + numPathsS[1][j] + numPathsE[1][j]);
	// for right fires
	forall (j in 2..n-1) (numPathsN[n][j+1] + numPathsS[n][j-1] + numPathsE[n-1][j]) == 1 + (numPathsN[n][j] + numPathsS[n][j] + numPathsO[n][j]);
	// for top fires
	forall (i in 2..n-1) (numPathsN[i][2] + numPathsO[i+1][1] + numPathsE[i-1][1]) == 1 + (numPathsE[i][1] + numPathsS[i][1] + numPathsO[i][1]);
	// for bottom fires
	forall (i in 2..n-1) (numPathsS[i][n-1] + numPathsO[i+1][n] + numPathsE[i-1][n]) == 1 + (numPathsE[i][n] + numPathsN[i][n] + numPathsO[i][n]);
	// for right up corner
	numPathsN[n][2] + numPathsE[n-1][1] == 1 + numPathsS[n][1] + numPathsO[n][1];
	// for right bottom corner
	numPathsS[n][n-1] + numPathsE[n-1][n] == 1 + numPathsN[n][n] + numPathsO[n][n];
	// for left bottom corner
	numPathsS[1][n-1] + numPathsO[2][n] == 1 + numPathsN[1][n] + numPathsE[1][n];
	// no left up corner cause it''s origin
	// no negative
	forall(i in 1..n, j in 1..n) numPathsN[i][j] >= 0;
	forall(i in 1..n, j in 1..n) numPathsS[i][j] >= 0;
	forall(i in 1..n, j in 1..n) numPathsE[i][j] >= 0;
	forall(i in 1..n, j in 1..n) numPathsO[i][j] >= 0;
	// no paths from borders
	forall(i in 1..n) numPathsN[i][1] == 0;
	forall(i in 1..n) numPathsS[i][n] == 0;
	forall(j in 1..n) numPathsE[n][j] == 0;
	forall(j in 1..n) numPathsO[1][j] == 0;
}