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
int protegerX = 3;
int protegerY = 3;

dvar boolean resAt[1..n][1..n];
dvar int minTime[1..n][1..n];

maximize sum (x in 1..n, y in 1..n) minTime[y][x];

subject to {

	// minimum time at origin is 0
	minTime[origemY][origemX] == 0;
	// protected cell
	//minTime[protegerY][protegerX] >= g;
	// sum of resources less or equal to available resources
	sum (x in 1..n, y in 1..n) resAt[y][x] <= b;
	// time to i(j-1) - time to ij <= cs[i][j]
	forall (x in 1..n, y in 1..n-1) - minTime[y][x] + minTime[y+1][x] <= cs[y][x] + resAt[y][x]*d;
	forall (x in 1..n, y in 2..n) - minTime[y][x] + minTime[y-1][x] <= cn[y][x] + resAt[y][x]*d;
	forall (x in 2..n, y in 1..n) - minTime[y][x] + minTime[y][x-1] <= co[y][x] + resAt[y][x]*d;
	forall (x in 1..n-1, y in 1..n) - minTime[y][x] + minTime[y][x+1] <= ce[y][x] + resAt[y][x]*d;
	forall (x in 1..n, y in 1..n) minTime[y][x] >= 0;
}