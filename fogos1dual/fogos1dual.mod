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
int origemX = 1;
int origemY = 1;

dvar int minTime[1..n][1..n];

maximize sum (x in 1..n, y in 1..n) minTime[y][x];

subject to {

	// minimum time at origin is 0
	minTime[origemY][origemX] == 0;
	forall (x in 1..n, y in 1..n-1) - minTime[y][x] + minTime[y+1][x] <= cs[y][x];
	forall (x in 1..n, y in 2..n) - minTime[y][x] + minTime[y-1][x] <= cn[y][x];
	forall (x in 2..n, y in 1..n) - minTime[y][x] + minTime[y][x-1] <= co[y][x];
	forall (x in 1..n-1, y in 1..n) - minTime[y][x] + minTime[y][x+1] <= ce[y][x];
	forall (x in 1..n, y in 1..n) minTime[y][x] >= 0;
}