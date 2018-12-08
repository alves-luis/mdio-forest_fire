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
int delta = ...; // retardamento
int d = 30; // duração
int b = ...;
float prob[1..n][1..n] = ...;

// se existe recurso na célula yx
dvar boolean resAt[1..n][1..n];
// instante de tempo em que celula yx arde após ignição em oyox
dvar int t[1..n][1..n][1..n][1..n];
// se célula yx arde d instantes após ignição em oyox
dvar boolean burns[1..n][1..n][1..n][1..n];

minimize sum (y in 1..n, x in 1..n, oY in 1..n, oX in 1..n) prob[oY][oX]*burns[y][x][oY][oX];

subject to {

	// se célula começa, então o instante de tempo é 0
	forall (y in 1..n, x in 1..n) t[y][x][y][x] == 0;
	// são usados no máximo b recursos
	sum (x in 1..n, y in 1..n) resAt[y][x] <= b;
	// instante é menor que o tempo anterior + custo para sul
	forall (oY in 1..n, oX in 1..n) {
		forall (x in 1..n, y in 1..n-1) t[y+1][x][oY][oX] - t[y][x][oY][oX] <= cs[y][x] + resAt[y][x]*delta;
		forall (x in 1..n, y in 2..n) t[y-1][x][oY][oX] - t[y][x][oY][oX] <= cn[y][x] + resAt[y][x]*delta;
		forall (x in 2..n, y in 1..n) t[y][x-1][oY][oX] - t[y][x][oY][oX] <= co[y][x] + resAt[y][x]*delta;
		forall (x in 1..n-1, y in 1..n)  t[y][x+1][oY][oX] - t[y][x][oY][oX] <= ce[y][x] + resAt[y][x]*delta;
	}
	// sempre maior que 0
	forall (x in 1..n, y in 1..n, w in 1..n, z in 1..n) t[y][x][w][z] >= 0;
	
	// Se arde, então o instante de tempo em que arde é inferior a d, logo dá um valor >= 0.qq coisa
	// Se não arde, então o instante de tempo é menor que 0, pelo que vai dar 0.
	forall (oY in 1..n, oX in 1..n) {
		forall (x in 1..n, y in 1..n) burns[y][x][oY][oX] >= (d - t[y][x][oY][oX])/d;
	}
	
}