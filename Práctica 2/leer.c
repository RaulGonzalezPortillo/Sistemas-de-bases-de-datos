#include <stdio.h>
#include <stdlib.h>
#include <mysql/mysql.h>

extern void Purge();
extern void Enter();
extern void Desconectar(MYSQL mysql);
void Ver_Asesores(MYSQL mysql);
void Ver_Historiales(MYSQL mysql);
void Ver_Productos(MYSQL mysql);
void Ver_Compras(MYSQL mysql);
void Ver_Compras_Cliente(MYSQL mysql, int idClienteTemp);
void Ver_Clientes(MYSQL mysql);
void Ver_Casos(MYSQL mysql);

void Ejecutar_Query_Leer(MYSQL mysql, char buffer[]);

void Ejecutar_Query_Leer(MYSQL mysql, char buffer[])
{
	int i, Registros = 0;
	MYSQL_RES *res;
	MYSQL_ROW row;
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
	while((row = mysql_fetch_row(res)))
	{
		for(i=0; i < mysql_num_fields(res) - 1; i++)
		{
			if(row[i] != NULL)
				printf("%s, ",row[i]);
			else
				printf("---");
		}
		if(row[i] != NULL)
			printf("%s\n\n",row[i]);
		else
			printf("---\n\n");
		Registros = 1;
	}
	mysql_free_result(res);

	if(Registros == 0)
		printf("No hay registros disponibles\n");
}

void Ver_Asesores(MYSQL mysql)
{
	char *buffer = "SELECT * FROM Asesores";
	printf ("INFO: Desplegando todos los asesores registrados en la base de datos con el formato:\n\n");
	printf ("ID de Asesor, Nombre del Asesor, Apellido Paterno del Asesor, Apellido Materno del Asesor\n\n");
	Ejecutar_Query_Leer(mysql,buffer);
	Enter();
}

void Ver_Historiales(MYSQL mysql)
{
	char *buffer = "SELECT * FROM HistorialAtencion";
	printf ("INFO: Desplegando todos los historiales de atención registrados en la base de datos con el formato:\n\n");
	printf ("ID de Historial, ID de Asesor, ID de Cliente, Estado, Comentarios\n\n");
	Ejecutar_Query_Leer(mysql,buffer);
	Enter();
}

void Ver_Productos(MYSQL mysql)
{
	system("clear");

	char *buffer = "SELECT idProducto, idDepartamento, nombreDepartamento, idCategoriaProducto, nombreCategoriaProducto, nombre, marca, descripcion, precio, stock FROM Departamentos RIGHT JOIN Productos USING (idDepartamento) RIGHT JOIN CategoriaProductos USING (idCategoriaProducto)";

	int i, Registros = 0;
	MYSQL_RES *res;
	MYSQL_ROW row;
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
	printf ("INFO: Desplegando todos los productos registrados en la base de datos con el formato:\n\n");
	printf ("ID de Producto, ID de departamento, Nombre de departamento, ID de categoría, Nombre de Categoría, Nombre, Marca\n");
	printf ("Descripción\n\nPrecio\nStock\n\n");
	while((row = mysql_fetch_row(res)))
	{
		for(i=0; i < mysql_num_fields(res); i++)
		{
			if(row[i] != NULL && i <= 5)
				printf("%s, ",row[i]);
			if(row[i] != NULL && i == 6)
				printf("%s",row[i]);
			if(row[i] != NULL && i == 7)
				printf("\n%s",row[i]);
			if(row[i] != NULL && i == 8)
				printf("\n$%s",row[i]);
			if(row[i] != NULL && i == 9)
				printf("\nStock: %s\n\n",row[i]);
		}
		Registros = 1;
	}
	mysql_free_result(res);

	if(Registros == 0)
		printf("No hay registros disponibles\n");

	Enter();
}

void Ver_Compras(MYSQL mysql)
{
	char *buffer = "SELECT idCompra,idCliente,nombreCliente,aPaternoCliente,idProducto,nombre,cantidadProducto,formaPago,fechaCompra  FROM Clientes INNER JOIN Compras USING(idCliente) INNER JOIN ComprasProductos USING(idCompra) INNER JOIN Productos USING(idProducto)";
	printf ("INFO: Desplegando todas las compras registradas en la base de datos con el formato:\n\n");
	printf ("ID de Compra, ID de Cliente, Nombre del Cliente, Apellido Paterno del Cliente, ID de Producto, Nombre del Producto, Cantidad de productos, Forma de Pago, Fecha de Compra\n\n");
	Ejecutar_Query_Leer(mysql,buffer);
	Enter();
}

void Ver_Compras_Cliente(MYSQL mysql, int idClienteTemp)
{
	char buffer[1024];
	printf ("INFO: Desplegando todas las compras registradas en la base de datos con el formato:\n\n");
	printf ("ID de Compra, ID de Producto, Nombre del Producto, Cantidad de productos, Forma de Pago, Fecha de Compra\n\n");
	sprintf(buffer,"SELECT idCompra,idProducto,nombre,cantidadProducto,formaPago,fechaCompra  FROM Clientes INNER JOIN Compras USING(idCliente) INNER JOIN ComprasProductos USING(idCompra) INNER JOIN Productos USING(idProducto) WHERE idCliente = %d",idClienteTemp);
	Ejecutar_Query_Leer(mysql,buffer);
	Enter();
}


void Ver_Clientes(MYSQL mysql)
{
	char buffer[1024];
	printf("INFO: Desplegando todos los clientes registrados en la base de datos con el formato:\n\n");
	printf("ID de cliente, ID de categoría, Usuario, Contraseña, Nombre, Apellido Paterno, Apellido Materno, RFC, Dirección de Envío, Dirección de Facturación\n\n");
	sprintf(buffer,"SELECT * FROM Clientes");
	Ejecutar_Query_Leer(mysql,buffer);
	Enter();
}

void Ver_Casos(MYSQL mysql)
{
	char buffer[1024];
	printf("INFO: Desplegando todas las cancelaciones y devoluciones con el formato:\n\n");
	printf("ID de Caso, ID de Producto, Nombre del producto, ID de Compra, Tipo, Cantidad\n\n");
	sprintf(buffer,"SELECT idCaso, idProducto, nombre, idCompra, tipo, cantidadDC FROM DevolucionesCancelaciones LEFT JOIN Productos USING (idProducto)");
	Ejecutar_Query_Leer(mysql,buffer);
	Enter();
}
