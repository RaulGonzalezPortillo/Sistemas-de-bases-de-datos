#include <stdio.h>
#include <stdlib.h>
#include <mysql/mysql.h>

extern void Purge();
extern void Enter();
extern void Desconectar(MYSQL mysql);
void Borrar_Asesores(MYSQL mysql);
void Borrar_Historiales(MYSQL mysql);
void Borrar_Productos(MYSQL mysql);
void Borrar_Compras(MYSQL mysql);
void Borrar_Clientes(MYSQL mysql);
void Borrar_Casos(MYSQL mysql);
void Existe_Caso(MYSQL mysql, int idCasoTemp, int *flag);
extern void ObtenerIdProductoYCantidadDevoluciones(MYSQL mysql, int idCasoTemp, int *idProductoTemp, int *cantidadTemp);
extern void ObtenerStock(MYSQL mysql, int idProductoTemp, int *stockTemp);
extern void ActualizarStock(MYSQL mysql, int idProductoTemp, int stockTemp, int cantidadTemp);

void Borrar_Asesores(MYSQL mysql)
{
	int IDTemp;
	char buffer[1024];
	printf("Ingrese el id del asesor a borrar\n");
	Purge();
	scanf (" %d",&IDTemp);

	sprintf(buffer,"DELETE FROM Asesores WHERE idAsesor = %d",IDTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		Desconectar(mysql);
		exit(1);
	}
	printf("Se eliminó correctamente el asesor\n");
	Enter();
}

void Borrar_Historiales(MYSQL mysql)
{
	int IDTemp;
	char buffer[1024];
	printf("Ingrese el id del historial\n");
	Purge();
	scanf (" %d",&IDTemp);

	sprintf(buffer,"DELETE FROM HistorialAtencion WHERE idAtencion = %d",IDTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		Desconectar(mysql);
		exit(1);
	}

	printf("Se eliminó correctamente el historial\n");
	Enter();
}

void Borrar_Productos(MYSQL mysql)
{
	int IDTemp;
	char buffer[1024];
	printf("Ingrese el id del producto\n");
	Purge();
	scanf (" %d",&IDTemp);

	sprintf(buffer,"DELETE FROM Productos WHERE idProducto = %d",IDTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		Desconectar(mysql);
		exit(1);
	}

	printf("Se eliminó correctamente el producto\n");
	Enter();
}

void Borrar_Compras(MYSQL mysql)
{
	int IDTemp, Opcion;
	char buffer[1024];
	printf("Ingrese el id de la compra\n");
	Purge();
	scanf (" %d",&IDTemp);
	printf("¿Seguro que desea realizar esta acción?\n");
	printf("1.- Aceptar\n");
	printf("Otro número.- Cancelar\n");
	printf("Escoja una opción\n");
	Purge();
	scanf(" %d",&Opcion);

	if(Opcion == 1)
	{
		sprintf(buffer,"DELETE FROM Compras WHERE idCompra = %d",IDTemp);

		if(mysql_query(&mysql,buffer))
		{
			printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
			Desconectar(mysql);
			exit(1);
		}

		printf("Se eliminó correctamente la compra\n");
	}
	else
		printf("Se canceló la acción\n");

	Enter();
}

void Borrar_Clientes(MYSQL mysql)
{
	int idClienteTemp;
	char buffer[1024];
	printf("Ingrese el id del cliente a borrar\n");
	Purge();
	scanf(" %d", &idClienteTemp);

	sprintf(buffer,"DELETE FROM Clientes WHERE idCliente = %d", idClienteTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		Desconectar(mysql);
		exit(1);
	}
	printf("Cliente borrado exitosamente\n");
	Enter();
}

void Borrar_Casos(MYSQL mysql)
{
	int idCasoTemp, idProductoTemp, stockTemp, cantidadTemp, flag = 0;
	char buffer[1024];
	printf("Ingrese el id del caso a borrar\n");
	Purge();
	scanf(" %d", &idCasoTemp);
	Existe_Caso(mysql,idCasoTemp, &flag);
	if(flag == 0)
	{
		sprintf(buffer,"DELETE FROM DevolucionesCancelaciones WHERE idCaso = %d", idCasoTemp);
		ObtenerIdProductoYCantidadDevoluciones(mysql, idCasoTemp, &idProductoTemp, &cantidadTemp);
		cantidadTemp *= -1;
		ObtenerStock(mysql, idProductoTemp, &stockTemp);
		if(mysql_query(&mysql,buffer))
		{
			printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
			Desconectar(mysql);
			exit(1);
		}
		else
		{
			ActualizarStock(mysql, idProductoTemp, stockTemp, cantidadTemp);
		}
		printf("Caso borrado exitosamente\n");
	}
	else
		printf("No existe el caso seleccionado\n");

	Enter();
}
void Existe_Caso(MYSQL mysql, int idCasoTemp, int *flag)
{
	MYSQL_RES *res;
	MYSQL_ROW row;
	char buffer[1024];
	sprintf(buffer,"SELECT * FROM DevolucionesCancelaciones WHERE idCaso = %d", idCasoTemp);
	//Ejecuta el query.
	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		Desconectar(mysql);
		exit(1);
	}
	// Obtenemos el result set.
	if(!(res = mysql_store_result(&mysql)))
	{
		printf("Error al obtener el query: %s\n", mysql_error(&mysql));
		Desconectar(mysql);
		exit(1);
	}
	// Desplegamos el resultset
	row = mysql_fetch_row(res);
	mysql_free_result(res);

	if(row == NULL)
		*flag = 1;
}
