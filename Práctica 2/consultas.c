#include <stdio.h>
#include <stdlib.h>
#include <mysql/mysql.h>

void Purge();
extern void Desconectar(MYSQL mysql);
extern void Enter();
void Asesores_Casos_Resueltos(MYSQL mysql);
void Asesores_Casos_Abiertos(MYSQL mysql);
void Historiales_Clientes(MYSQL mysql);
void Productos_Categoria(MYSQL mysql);
void Ver_Compras_Productos(MYSQL mysql);
void Ver_Monto(MYSQL mysql);
void Ejecutar_Query_Consultas(MYSQL mysql, char buffer[]);
void Clientes_Mas_Compras(MYSQL mysql);
void Clientes_Facturacion(MYSQL mysql);
void Clientes_Ningun_Producto(MYSQL mysql);
void Clientes_Cantidad(MYSQL mysql);
void Clientes_Entrega(MYSQL mysql);
void ObtenerIdProductoYCantidadDevoluciones(MYSQL mysql, int idCasoTemp, int *idProductoTemp, int *cantidadTemp);
void ObtenerStock(MYSQL mysql, int idProductoTemp, int *stockTemp);
void Casos_Producto_Mas_Devuelto(MYSQL mysql);
void ObtenerUltimaCompra(MYSQL mysql, int *ultimaCompraTemp);
void ObtenerUltimoAsesor(MYSQL mysql, int *ultimoAsesorTemp);

void Ejecutar_Query_Consultas(MYSQL mysql, char buffer[])
{
	int i, Registros = 0;
	MYSQL_RES *res;
	MYSQL_ROW row;
	//Ejecuta el query.
	if(mysql_query(&mysql,"SET sql_mode=''"))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		Desconectar(mysql);
		exit(1);
	}
	//Ejecuta el query 2.
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

void Asesores_Casos_Resueltos(MYSQL mysql)
{
	char *buffer = "SELECT idAsesor, nombreAsesor, aPaternoAsesor, aMaternoAsesor FROM HistorialAtencion LEFT JOIN Asesores USING(idAsesor) WHERE estado = 'Cerrado' GROUP BY idAsesor";
	printf ("INFO: Desplegando todos los asesores con casos resueltos registrados en la base de datos con el formato:\n\n");
	printf ("ID de Asesor, Nombre del Asesor, Apellido Paterno del Asesor, Apellido Materno del Asesor\n\n");

	Ejecutar_Query_Consultas(mysql,buffer);
	Enter();
}
void Asesores_Casos_Abiertos(MYSQL mysql)
{
	char *buffer = "SELECT idAsesor, nombreAsesor, aPaternoAsesor, aMaternoAsesor FROM HistorialAtencion LEFT JOIN Asesores USING(idAsesor) WHERE estado = 'Abierto' GROUP BY idAsesor";
	printf ("INFO: Desplegando todos los asesores con casos abiertos registrados en la base de datos con el formato:\n\n");
	printf ("ID de Asesor, Nombre del Asesor, Apellido Paterno del Asesor, Apellido Materno del Asesor\n\n");
	Ejecutar_Query_Consultas(mysql,buffer);
	Enter();
}

void Historiales_Clientes(MYSQL mysql)
{
	int IDTemp;
	char buffer[1024];
	printf("Ingrese el id del cliente\n");
	Purge();
	scanf (" %d",&IDTemp);
	sprintf(buffer,"SELECT * FROM HistorialAtencion WHERE idCliente = %d",IDTemp);
	printf ("INFO: Desplegando todos los historiales de atención registrados en la base de datos del cliente %d con el formato:\n\n",IDTemp);
	printf ("ID de Historial, ID de Asesor, ID de Cliente, Estado, Comentarios\n\n");
	Ejecutar_Query_Consultas(mysql,buffer);
	Enter();
}

void Productos_Categoria(MYSQL mysql)
{
	char buffer[1024], NombreCategoriaTemp[45];
	printf("Ingrese el nombre de la categoria del producto\n");
	Purge();
	scanf (" %[^\n]",NombreCategoriaTemp);
	system("clear");
	sprintf(buffer,"SELECT nombre, descripcion, COUNT(idOpinion) AS Cuantos_Comentarios FROM CategoriaProductos RIGHT JOIN Productos USING(idCategoriaProducto) LEFT JOIN Opiniones USING(idProducto) WHERE nombreCategoriaProducto = '%s' GROUP BY idProducto",NombreCategoriaTemp);
	printf ("INFO: Desplegando todos los productos de la categoria '%s' registrados en la base de datos con el formato:\n\n",NombreCategoriaTemp);
	printf ("Nombre del Producto, Descripción del Producto, Cantidad de Comentarios\n\n");
	Ejecutar_Query_Consultas(mysql,buffer);
	Enter();
}

void Ver_Compras_Productos(MYSQL mysql)
{
	char *buffer = "SELECT idCompra, nombreCliente, aPaternoCliente, aMaternoCliente, nombre as producto, cantidadProducto, descripcion FROM Clientes RIGHT JOIN Compras USING(idCliente) LEFT JOIN ComprasProductos USING (idCompra) LEFT JOIN Productos USING (idProducto)";
	printf ("INFO: Desplegando todas las compras registrados en la base de datos con el formato:\n\n");
	printf ("ID de Compra, Nombre del Cliente, Apellido Paterno del Cliente, Apellido Materno del Cliente, Nombre del Producto, Cantidad de Productos, Descripción del Producto\n\n");
	Ejecutar_Query_Consultas(mysql,buffer);
	Enter();
}

void Ver_Monto(MYSQL mysql)
{
	MYSQL_RES *res;
	MYSQL_ROW row;
	int IDClienteTemp,IDProductoTemp,NumProductos;
	double MontoTotal,MontoEnvio,CostoProducto,PorcentajeEnvio;
	char buffer[1024], buffer2[1024];

	printf("Ingresa el id del cliente\n");
	Purge();
	scanf(" %d",&IDClienteTemp);
	printf("Ingresa el id del producto\n");
	Purge();
	scanf(" %d",&IDProductoTemp);
	printf("Ingresa la cantidad de productos\n");
	Purge();
	scanf(" %d",&NumProductos);
	sprintf(buffer,"SELECT precio FROM Productos WHERE idProducto = %d",IDProductoTemp);
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
		printf("No existe el producto seleccionado\n");
	else
	{
		sscanf(row[0], "%lf", &CostoProducto);
		sprintf(buffer2,"SELECT porcentajeEnvio FROM Clientes LEFT JOIN CategoriaClientes USING(idCategoriaCliente) WHERE idCliente = %d",IDClienteTemp);
		if(mysql_query(&mysql,buffer2))
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
			printf("No existe el cliente seleccionado\n");
		else
		{
			sscanf(row[0], "%lf", &MontoEnvio);
			MontoTotal = CostoProducto * NumProductos;
			MontoEnvio = MontoTotal * MontoEnvio;
			printf("El monto total es: %lf\n",MontoTotal);
			printf("El monto envío es: %lf\n",MontoEnvio);
		}
	}
	Enter();
}

void Clientes_Mas_Compras(MYSQL mysql)
{
	char buffer[1024];
	printf("INFO: Desplegando los cliente(s) que más ha(n) comprado en orden con el formato:\n\nID del cliente, Nombre, Apellido Paterno, Apellido Materno, Total de productos comprados\n\n");
	sprintf(buffer,"SELECT idCliente, nombreCliente, aPaternoCliente, aMaternoCliente, SUM(cantidadProducto) FROM Clientes INNER JOIN Compras USING(idCliente) INNER JOIN ComprasProductos USING(idCompra) GROUP BY idCliente HAVING SUM(cantidadProducto) = (SELECT SUM(cantidadProducto) AS Cantidad FROM Clientes INNER JOIN Compras USING(idCliente) INNER JOIN ComprasProductos USING(idCompra) GROUP BY idCliente ORDER BY Cantidad DESC LIMIT 1)");
	Ejecutar_Query_Consultas(mysql,buffer);
	Enter();
}

void Clientes_Facturacion(MYSQL mysql)
{
	int idClienteTemp;
	char buffer[1024];
	printf("Ingrese el ID del cliente:\n");
	Purge();
	scanf(" %d",&idClienteTemp);
	printf("\n");
	printf("INFO: Calculando la facturación para el cliente: ");
	sprintf(buffer,"SELECT nombreCliente FROM Clientes WHERE idCliente = %d", idClienteTemp);
	Ejecutar_Query_Consultas(mysql,buffer);
	printf("Total: $");
	sprintf(buffer,"SELECT SUM(precio) FROM Clientes LEFT JOIN Compras USING(idCliente) LEFT JOIN ComprasProductos USING (idCompra) LEFT JOIN Productos USING (idProducto) WHERE idCliente = %d", idClienteTemp);
	Ejecutar_Query_Consultas(mysql,buffer);
	Enter();
}

void Clientes_Ningun_Producto(MYSQL mysql)
{
	char buffer[1024];
	printf("INFO: Desplegando todos los clientes que NO han comprado ningún producto con el formato:\n\nID de cliente, Nombre, Apellido Paterno, Apellido Materno\n\n");
	sprintf(buffer,"SELECT idCliente, nombreCliente, aPaternoCliente, aMaternoCliente FROM Clientes WHERE idCliente NOT IN (SELECT idCliente FROM Clientes INNER JOIN Compras USING(idCliente) INNER JOIN ComprasProductos USING(idCompra) GROUP BY idCliente)");
	Ejecutar_Query_Consultas(mysql,buffer);
	Enter();
}

void Clientes_Cantidad(MYSQL mysql)
{
	int cantidadTemp;
	char buffer[1024];
	printf("Ingrese la cantidad:\n");
	Purge();
	scanf(" %d",&cantidadTemp);
	printf("\n");
	printf("INFO: Desplegando todos los clientes que han comprado productos por más de $%d con el formato:\n\nID de cliente, Nombre, Apellido Paterno, Apellido Materno\n\n", cantidadTemp);
	sprintf(buffer,"SELECT idCliente, nombreCliente, aPaternoCliente, aMaternoCliente FROM Clientes INNER JOIN Compras USING(idCliente) INNER JOIN ComprasProductos USING(idCompra) INNER JOIN Productos USING(idProducto) GROUP BY idCliente HAVING MAX(precio) > %d;", cantidadTemp);
	Ejecutar_Query_Consultas(mysql,buffer);
	Enter();
}

void Clientes_Entrega(MYSQL mysql)
{
	char buffer[1024];
	printf("INFO: Desplegando las entregas de los clientes y su información con el formato:\n\n");
	printf("ID de compra, Nombre del producto, Cantidad, Nombre del cliente, Apellido Paterno, Apellido Materno, Dirección de envío\n\n");
	sprintf(buffer,"SELECT idCompra, nombre AS nombreProducto, cantidadProducto, nombreCliente, aPaternoCliente,aMaternoCliente, direccionEnvio FROM Clientes INNER JOIN Compras USING(idCliente) INNER JOIN ComprasProductos USING(idCompra) INNER JOIN Productos USING(idProducto)");
	Ejecutar_Query_Consultas(mysql,buffer);
	Enter();
}

void ObtenerIdProductoYCantidadDevoluciones(MYSQL mysql, int idCasoTemp, int *idProductoTemp, int *cantidadTemp)
{
	MYSQL_RES *res;
	MYSQL_ROW row;
	char buffer[1024];
	//Obtenemos el ID del producto con base al ID del caso
	sprintf(buffer,"SELECT idProducto, cantidadDC FROM DevolucionesCancelaciones WHERE idCaso = %d",idCasoTemp);
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
	//idProductoTemp = row[0];
	sscanf (row[0],"%d", idProductoTemp);
	sscanf (row[1],"%d", cantidadTemp);
	mysql_free_result(res);
}

void ObtenerStock(MYSQL mysql, int idProductoTemp, int *stockTemp)
{
	MYSQL_RES *res;
	MYSQL_ROW row;
	char buffer[1024];
	//Obtenemos el stock del producto con base al ID del mismo
	sprintf(buffer,"SELECT stock FROM Productos WHERE idProducto = %d",idProductoTemp);
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
	sscanf (row[0],"%d", stockTemp);
	mysql_free_result(res);
}

void Casos_Producto_Mas_Devuelto(MYSQL mysql)
{
	char *buffer = "SELECT idProducto, nombre AS Producto, precio, SUM(cantidadDC) FROM Productos RIGHT JOIN DevolucionesCancelaciones USING (idProducto) WHERE idProducto = (SELECT idProducto FROM Productos RIGHT JOIN DevolucionesCancelaciones USING (idProducto) GROUP BY idProducto ORDER BY SUM(cantidadDC) DESC LIMIT 1)";
	printf("INFO: Desplegando la cantidad de devoluciones y el producto más devueto con el formato:\n\n");
	printf("ID de Producto, Nombre de Producto, Precio, Veces cancelado / devuelto\n\n");
	Ejecutar_Query_Consultas(mysql,buffer);
	Enter();
}

void ObtenerUltimaCompra(MYSQL mysql, int *ultimaCompraTemp)
{
	MYSQL_RES *res;
	MYSQL_ROW row;
	char buffer[1024];
	sprintf(buffer,"SELECT idCompra FROM Compras ORDER BY idCompra DESC LIMIT 1");
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
	sscanf (row[0],"%d", ultimaCompraTemp);
	mysql_free_result(res);
}

void ObtenerUltimoAsesor(MYSQL mysql, int *ultimoAsesorTemp)
{
	MYSQL_RES *res;
	MYSQL_ROW row;
	char buffer[1024];
	sprintf(buffer,"SELECT idAsesor FROM Asesores ORDER BY idAsesor DESC LIMIT 1");
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
	sscanf (row[0],"%d", ultimoAsesorTemp);
	mysql_free_result(res);
}
