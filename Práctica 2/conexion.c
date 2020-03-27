#include <stdio.h>
#include <stdlib.h>
#include <mysql/mysql.h>

MYSQL Conectar(MYSQL mysql);
void Desconectar(MYSQL mysql);

MYSQL Conectar(MYSQL mysql)
{
	char *server = "localhost";
	char *user = "root";
	char *password = "d2Qy2H;YJ";
	char *db = "Practica2";

	mysql_init(&mysql);

	// Se conecta al servidor.
	if(!mysql_real_connect(&mysql,server,user,password,db,0,NULL,0))
	{
		printf("Error al conectarse: %s\n", mysql_error(&mysql));
		exit(1);
	}
	// Se conecta a la base de datos.
	if(mysql_select_db(&mysql,db))
	{
		printf("Error al selecionar la base de datos: %s\n", mysql_error(&mysql));
		exit(1);
	}
	return mysql;
}
void Desconectar(MYSQL mysql)
{
	mysql_close(&mysql);
}
