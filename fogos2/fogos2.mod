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
int origemX = 1;
int origemY = 1;
int protegerX = 7;
int protegerY = 7;

dvar boolean x[1..n][1..n];
dvar int t[1..n][1..n];

maximize t[protegerX][protegerY];

subject to{
	t[origemX][origemY] == 0;
	sum (i in 1..n, j in 1..n) x[i][j] <= b;
	forall (i in 2..n, j in 1..n) t[i][j] <= ce[i-1][j] + x[i-1][j]*d + t[i-1][j];
	forall (i in 1..n-1, j in 1..n) t[i][j] <= co[i+1][j] + x[i+1][j]*d + t[i+1][j];
	forall (i in 1..n, j in 1..n-1) t[i][j] <= cn[i][j+1] + x[i][j+1]*d + t[i][j+1];
	forall (i in 1..n, j in 2..n) t[i][j] <= cs[i][j-1] + x[i][j-1]*d + t[i][j-1];
	forall (i in 1..n, j in 1..n) t[i][j] >= 0;
}