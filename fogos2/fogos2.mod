/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Luís Alves
 * Creation Date: 1 Dec 2018 at 15:28:01
 *********************************************/
int n = ...;
int cn[1..n][1..n] = ...;
int cs[1..n][1..n] = ...;
int ce[1..n][1..n] = ...;
int co[1..n][1..n] = ...;
int d = ...;
int b = ...;
int g = ...;
int origemX = 1;
int origemY = 1;
int protegerX = 7;
int protegerY = 7;

dvar boolean resAt[1..n][1..n];
dvar int minTime[1..n][1..n];

maximize sum (i in 1..n, j in 1..n) minTime[i][j];

subject to {

	// minimum time at origin is 0
	minTime[origemX][origemY] == 0;
	// protected cell
	minTime[protegerX][protegerY] >= g;
	// sum of resources less or equal to available resources
	sum (i in 1..n, j in 1..n) resAt[i][j] <= b;
	// time to i(j-1) - time to ij <= cs[i][j]
	forall (i in 1..n, j in 1..n-1) minTime[i][j] - minTime[i][j+1] <= cs[i][j] + resAt[i][j]*d;
	forall (i in 1..n, j in 2..n) minTime[i][j] - minTime[i][j-1] <= cn[i][j] + resAt[i][j]*d;
	forall (i in 2..n, j in 1..n) minTime[i][j] - minTime[i-1][j] <= co[i][j] + resAt[i][j]*d;
	forall (i in 1..n-1, j in 1..n) minTime[i][j] - minTime[i+1][j] <= ce[i][j] + resAt[i][j]*d;
	forall (i in 1..n, j in 1..n) minTime[i][j] >= 0;
}