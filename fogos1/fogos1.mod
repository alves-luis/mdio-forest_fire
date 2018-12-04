/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Luís Alves
 * Creation Date: 4 Dec 2018 at 19:23:01
 *********************************************/
int n = ...;
int cn[1..n][1..n] = ...;
int cs[1..n][1..n] = ...;
int ce[1..n][1..n] = ...;
int co[1..n][1..n] = ...;
int origemX = 1;
int origemY = 1;

dvar int numPathsN[1..n][1..n];
dvar int numPathsS[1..n][1..n];
dvar int numPathsE[1..n][1..n];
dvar int numPathsO[1..n][1..n];

minimize sum (i in 1..n, j in 1..n) (numPathsN[i][j]*cn[i][j] + numPathsS[i][j]*cs[i][j] + numPathsE[i][j]*ce[i][j] + numPathsO[i][j]*co[i][j]);

subject to {

	n*n - 1 == (numPathsN[origemX][origemY] + numPathsS[origemX][origemY] + numPathsE[origemX][origemY] + numPathsO[origemX][origemY]);
	// needs restriction for 4 sides and middle
	// : j != origemY && i != origemX
	// for middle fires
	forall (i in 2..n, j in 2..n) (numPathsN[i][j+1] + numPathsS[i][j-1] + numPathsE[i+1][j] + numPathsO[i-1][j]) == 1 + (numPathsN[i][j] + numPathsS[i][j] + numPathsE[i][j] + numPathsO[i][j]);
	// for left fires
	// for right fires
	// for top fires
	// for bottom fires
}