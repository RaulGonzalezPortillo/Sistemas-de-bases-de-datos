#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>

extern void Purge();
extern void Enter();
extern void Desconectar(MYSQL mysql);
void Actualizar_Asesores(MYSQL mysql);
void Actualizar_Historiales(MYSQL mysql);
void Actualizar_Productos(MYSQL mysql);
void Actualizar_Clientes_Administrador(MYSQL mysql);
void ActualizarStock(MYSQL mysql, int idProductoTemp, int stockTemp, int cantidadTemp);
void Actualizar_Clientes(MYSQL mysql, int idClienteTemp);

void Actualizar_Asesores(MYSQL mysql)
{
	int IDTemp;
	char buffer[1024];
	char NombreTemp [45], APaternoTemp[45], AMaternoTemp[45];
	printf("Ingrese el id del asesor\n");
	Purge();
	scanf (" %d",&IDTemp);
	printf("Ingresa el nuevo nombre del asesor\n");
	Purge();
	scanf (" %[^\n]",NombreTemp);
	printf("Ingresa el nuevo apellido paterno del asesor\n");
	Purge();
	scanf (" %[^\n]",APaternoTemp);
	printf("Ingresa el nuevo apellido materno del asesor\n");
	Purge();
	scanf (" %[^\n]",AMaternoTemp);

	sprintf(buffer,"UPDATE Asesores SET nombreAsesor = '%s', aPaternoAsesor = '%s', aMaternoAsesor = '%s' WHERE idAsesor = %d",NombreTemp,APaternoTemp,AMaternoTemp,IDTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		Desconectar(mysql);
		exit(1);
	}
	printf("Se actualizó correctamente el asesor\n");
	Enter();
}

void Actualizar_Historiales(MYSQL mysql)
{
	MYSQL_RES *res;
	MYSQL_ROW row;
	int IDTemp;
	char buffer[1024], *EstadoTemp;
	printf("Ingrese el id del historial\n");
	Purge();
	scanf (" %d",&IDTemp);
	sprintf(buffer,"SELECT estado FROM HistorialAtencion WHERE idAtencion = %d",IDTemp);
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
	row = mysql_fetch_row(res);
	if(row == NULL)
		printf("Error, no existe historial de atención\n");
	else
	{
		if(strcmp(row[0],"Abierto") == 0)
			EstadoTemp = "Cerrado";
		else
			EstadoTemp = "Abierto";

		sprintf(buffer,"UPDATE HistorialAtencion SET estado = '%s' WHERE idAtencion = %d",EstadoTemp, IDTemp);

		if(mysql_query(&mysql,buffer))
		{
			printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
			Desconectar(mysql);
			exit(1);
		}
		printf("Se cambió el estado del historial a: %s\n",EstadoTemp);
	}

	mysql_free_result(res);

	Enter();
}

void Actualizar_Productos(MYSQL mysql)
{
	int IDProductoTemp, IDDepartamentoTemp, IDCategoriaProductoTemp, StockTemp;
	double PrecioTemp;
	char buffer[2000], NombreTemp [45], MarcaTemp[45],DescripcionTemp[1000];

	printf("Ingresa ID del producto\n");
	Purge();
	scanf (" %d",&IDProductoTemp);
	printf("Ingresa ID del departamento del producto\n");
	Purge();
	scanf (" %d",&IDDepartamentoTemp);
	printf("Ingresa ID de la categoria del producto\n");
	Purge();
	scanf (" %d",&IDCategoriaProductoTemp);
	printf("Ingresa nombre del producto\n");
	Purge();
	scanf (" %[^\n]",NombreTemp);
	printf("Ingresa marca del producto\n");
	Purge();
	scanf (" %[^\n]",MarcaTemp);
	printf("Ingresa la descripción del producto\n");
	Purge();
	scanf (" %[^\n]",DescripcionTemp);
	printf("Ingresa precio del producto\n");
	Purge();
	scanf (" %lf",&PrecioTemp);
	printf("Ingresa stock del producto\n");
	Purge();
	scanf (" %d",&StockTemp);

	sprintf(buffer,"UPDATE Productos SET idDepartamento = %d,idCategoriaProducto = %d,nombre = '%s',marca = '%s',descripcion = '%s',precio = %lf,stock = %d WHERE idProducto = %i",IDDepartamentoTemp,IDCategoriaProductoTemp,NombreTemp,MarcaTemp,DescripcionTemp,PrecioTemp,StockTemp,IDProductoTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		Desconectar(mysql);
		exit(1);
	}
	system("clear");
	printf("Se actualizó correctamente el producto\n");
	Enter();
}

void Actualizar_Clientes_Administrador(MYSQL mysql)
{
	int idClienteTemp;
	int idCategoriaClienteTemp;
	char buffer[1024];
	char nombreClienteTemp [45], aPaternoClienteTemp[45], aMaternoClienteTemp[45], usuarioTemp[45], passwordTemp[45], rfcTemp[13], direccionEnvioTemp[150], direccionFacturacionTemp[150];
	printf("Ingresa el ID del cliente\n");
	Purge();
	scanf (" %d", &idClienteTemp);
	printf("Ingresa la categoría del cliente\n");
	Purge();
	scanf (" %d", &idCategoriaClienteTemp);
	printf("Ingresa el nombre(s) del cliente\n");
	Purge();
	scanf (" %[^\n]", nombreClienteTemp);
	printf("Ingresa el apellido paterno del cliente\n");
	Purge();
	scanf (" %[^\n]", aPaternoClienteTemp);
	printf("Ingresa el apellido materno del cliente\n");
	Purge();
	scanf (" %[^\n]", aMaternoClienteTemp);
	printf("Ingresa el usuario\n");
	Purge();
	scanf (" %[^\n]", usuarioTemp);
	printf("Ingresa la contraseña\n");
	Purge();
	scanf (" %[^\n]", passwordTemp);
	printf("Ingresa el RFC\n");
	Purge();
	scanf (" %[^\n]", rfcTemp);
	printf("Ingresa la dirección de envío\n");
	Purge();
	scanf (" %[^\n]", direccionEnvioTemp);
	printf("Ingresa tu dirección de facturación\n");
	Purge();
	scanf (" %[^\n]", direccionFacturacionTemp);

	sprintf(buffer,"UPDATE Clientes SET idCategoriaCliente = %d, nombreCliente = '%s', aPaternoCliente = '%s',  aMaternoCliente = '%s', usuario = '%s', password = '%s', rfc = '%s', direccionEnvio = '%s', direccionFacturacion = '%s' WHERE idCliente = %d", idCategoriaClienteTemp, nombreClienteTemp, aPaternoClienteTemp, aMaternoClienteTemp, usuarioTemp, passwordTemp, rfcTemp, direccionEnvioTemp, direccionFacturacionTemp, idClienteTemp);
	puts(buffer);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		Desconectar(mysql);
		exit(1);
	}
	system("clear");
	printf("Cliente actualizado exitosamente\n");
	Enter();
}

void ActualizarStock(MYSQL mysql, int idProductoTemp, int stockTemp, int cantidadTemp)
{
	char buffer[1024];
	stockTemp += cantidadTemp;
	sprintf(buffer,"UPDATE Productos SET stock = %d WHERE idProducto = %d", stockTemp, idProductoTemp);
	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		Desconectar(mysql);
		exit(1);
	}
}

void Actualizar_Clientes(MYSQL mysql, int idClienteTemp)
{
	char buffer[1024];
	char nombreClienteTemp [45], aPaternoClienteTemp[45], aMaternoClienteTemp[45], usuarioTemp[45], passwordTemp[45], rfcTemp[13], direccionEnvioTemp[150], direccionFacturacionTemp[150];
	printf("Ingresa el nombre(s) del cliente\n");
	Purge();
	scanf (" %[^\n]", nombreClienteTemp);
	printf("Ingresa el apellido paterno del cliente\n");
	Purge();
	scanf (" %[^\n]", aPaternoClienteTemp);
	printf("Ingresa el apellido materno del cliente\n");
	Purge();
	scanf (" %[^\n]", aMaternoClienteTemp);
	printf("Ingresa el usuario\n");
	Purge();
	scanf (" %[^\n]", usuarioTemp);
	printf("Ingresa la contraseña\n");
	Purge();
	scanf (" %[^\n]", passwordTemp);
	printf("Ingresa el RFC\n");
	Purge();
	scanf (" %[^\n]", rfcTemp);
	printf("Ingresa la dirección de envío\n");
	Purge();
	scanf (" %[^\n]", direccionEnvioTemp);
	printf("Ingresa tu dirección de facturación\n");
	Purge();
	scanf (" %[^\n]", direccionFacturacionTemp);

	sprintf(buffer,"UPDATE Clientes SET nombreCliente = '%s', aPaternoCliente = '%s',  aMaternoCliente = '%s', usuario = '%s', password = '%s', rfc = '%s', direccionEnvio = '%s', direccionFacturacion = '%s' WHERE idCliente = %d", nombreClienteTemp, aPaternoClienteTemp, aMaternoClienteTemp, usuarioTemp, passwordTemp, rfcTemp, direccionEnvioTemp, direccionFacturacionTemp, idClienteTemp);
	puts(buffer);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
		Desconectar(mysql);
		exit(1);
	}
	system("clear");
	printf("Vuelva a iniciar sesión para aplicar los cambios\n");
	Enter();
	exit(1);
}
