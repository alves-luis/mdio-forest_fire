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

// se há recurso em yx
dvar boolean resAt[1..n][1..n];
// instante de tempo em yx
dvar int minTime[1..n][1..n];

maximize minTime[protegerY][protegerX];

subject to {

	// origem tem instante 0
	minTime[origemY][origemX] == 0;
	// célula protegida requer >= g
	minTime[protegerY][protegerX] >= g;
	// a soma dos recursos tem de ser menor ou igual a b
	sum (x in 1..n, y in 1..n) resAt[y][x] <= b;
	// para cada célula, o instante de tempo a que chega é igual ao custo menor até essa célula, das 4 direções
	forall (x in 1..n, y in 1..n-1) minTime[y+1][x] - minTime[y][x]  <= cs[y][x] + resAt[y][x]*d;
	forall (x in 1..n, y in 2..n)  minTime[y-1][x] - minTime[y][x] <= cn[y][x] + resAt[y][x]*d;
	forall (x in 2..n, y in 1..n)  minTime[y][x-1] - minTime[y][x] <= co[y][x] + resAt[y][x]*d;
	forall (x in 1..n-1, y in 1..n) minTime[y][x+1] - minTime[y][x] <= ce[y][x] + resAt[y][x]*d;
	// não negatividade
	forall (x in 1..n, y in 1..n) minTime[y][x] >= 0;
}