#include <stdio.h>
#include <stdlib.h>
#include <time.h> //Declaramos time.h para poder obtener la hora del sistema.
#include <mysql/mysql.h>

extern void Purge();
extern void Enter();
extern void Desconectar(MYSQL mysql);
void Insertar_Asesores(MYSQL mysql);
void Insertar_Compras(MYSQL mysql, int idClienteTemp);
void Insertar_Casos(MYSQL mysql, int IDClienteTemp);
void Insertar_Clientes(MYSQL mysql);
void Insertar_Productos(MYSQL mysql);
void Timestamp(char Timestamp[]);
extern void ObtenerStock(MYSQL mysql, int idProductoTemp, int *stockTemp);
extern void ActualizarStock(MYSQL mysql, int idProductoTemp, int stockTemp, int cantidadTemp);
extern void ObtenerUltimaCompra(MYSQL mysql, int *ultimaCompraTemp);
void Insertar_Comentarios_Productos(MYSQL mysql, int idClienteTemp);
extern void ObtenerUltimoAsesor(MYSQL mysql, int *ultimoAsesorTemp);

void Timestamp(char Timestamp[]) //Esta función obtiene la fecha y hora actual y las guarda en una cadena de salida
{
  time_t rawtime;
  struct tm *timeinfo;
  time(&rawtime);
  timeinfo = localtime(&rawtime);
  strftime(Timestamp,200, "%Y-%m-%d %H:%M:%S", timeinfo);
}

void Insertar_Asesores(MYSQL mysql)
{
	char buffer[1024];
	char NombreTemp [45], APaternoTemp[45],AMaternoTemp[45];
	printf("Ingresa nombre(s) del asesor\n");
	Purge();
  scanf (" %[^\n]",NombreTemp);
	printf("Ingresa el apellido paterno del asesor\n");
	Purge();
  scanf (" %[^\n]",APaternoTemp);
	printf("Ingresa el apellido materno del asesor\n");
	Purge();
  scanf (" %[^\n]",AMaternoTemp);

	sprintf(buffer,"INSERT INTO Asesores(nombreAsesor,aPaternoAsesor,aMaternoAsesor) VALUES  ('%s','%s','%s')",NombreTemp,APaternoTemp,AMaternoTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
    Desconectar(mysql);
		exit(1);
	}
	printf("Se agregó correctamente el asesor\n");
	Enter();
}

void Insertar_Compras(MYSQL mysql, int idClienteTemp)
{
	MYSQL_RES *res;
	MYSQL_ROW row;
	int Opcion, idProductoTemp, cantidadTemp, stockTemp, ultimaCompraTemp, terminarCompra;
	char buffer[1024];
	char HoraSistemaTemp[100], *PagoTemp;
  Opcion = 0;
  system ("clear");
  do
  {
    printf("Ingrese el ID del producto a comprar:\n");
    Purge();
    scanf(" %d", &idProductoTemp);
    printf("\n");
    ObtenerStock(mysql, idProductoTemp, &stockTemp);
    printf("Ingrese la cantidad de productos a comprar:\n");
    Purge();
    scanf(" %d", &cantidadTemp);
    if(cantidadTemp > stockTemp)
    {
      printf ("No hay stock suficiente.\n\n");
    }
    else Opcion = 1;
  }
	while(Opcion == 0);
	do
	{
		printf("Forma de pago:\n");
		printf("\t1.- Tarjeta de cŕedito.\n");
		printf("\t2.- Depósito bancario.\n");
		printf("\t3.- Transferencia electrónica.\n");
		printf("\t4.- Pago en tienda de conveniencia.\n");
		printf("Escoge una opción.\n");
		Purge();
    scanf(" %d",&Opcion);
		if (Opcion == 1)
			PagoTemp = "Tarjeta de cŕedito";
		else if (Opcion == 2)
			PagoTemp = "Depósito bancario";
		else if (Opcion == 3)
			PagoTemp = "Transferencia electrónica";
		else if (Opcion == 4)
			PagoTemp = "Pago en tienda de conveniencia";
		else
		{
			printf("Opción incorrecta\n");
			Opcion = 0;
		}
	}while(Opcion == 0);
	Timestamp(HoraSistemaTemp);
	sprintf(buffer,"INSERT INTO Compras(idCliente, formaPago, fechaCompra) VALUES  ('%d','%s','%s')",idClienteTemp, PagoTemp, HoraSistemaTemp);
	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
    Desconectar(mysql);
		exit(1);
	}
  ObtenerUltimaCompra(mysql, &ultimaCompraTemp);
  sprintf(buffer,"INSERT INTO ComprasProductos(idCompra, idProducto, cantidadProducto) VALUES  ('%d','%d','%d')",ultimaCompraTemp, idProductoTemp, cantidadTemp);
	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
    Desconectar(mysql);
		exit(1);
	}
  cantidadTemp *= -1;
  ActualizarStock(mysql, idProductoTemp, stockTemp, cantidadTemp);
	printf("Producto comprado.\n");
  do
  {
    printf ("¿Que desea hacer?\n\n");
    printf ("1.- Comprar otro producto.\n");
    printf ("2.- Terminar compra\n");
    Purge();
    scanf(" %d", &terminarCompra);
    printf ("\n");
    if(terminarCompra == 1)
    {
      Opcion = 0;
      do
      {
        printf("Ingrese el ID del producto a comprar:\n");
        Purge();
        scanf(" %d", &idProductoTemp);
        printf("\n");
        ObtenerStock(mysql, idProductoTemp, &stockTemp);
        printf("Ingrese la cantidad de productos a comprar:\n");
        Purge();
        scanf(" %d", &cantidadTemp);
        if(cantidadTemp > stockTemp)
        {
          printf ("No hay stock suficiente.\n\n");
        }
        else Opcion = 1;
      }
    	while(Opcion == 0);
      sprintf(buffer,"INSERT INTO ComprasProductos(idCompra, idProducto, cantidadProducto) VALUES  ('%d','%d','%d')",ultimaCompraTemp, idProductoTemp, cantidadTemp);
    	if(mysql_query(&mysql,buffer))
    	{
    		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
        printf("INFO: Si desea comprar varias veces el mismo producto, aumente la cantidad de productos a comprar cuanto se le pregunte\n");
        printf("Compra terminada\n");
        Desconectar(mysql);
    		exit(1);
    	}
      cantidadTemp *= -1;
      ActualizarStock(mysql, idProductoTemp, stockTemp, cantidadTemp);
    	printf("Producto comprado.\n");
    }
  }
  while(terminarCompra != 2);
	Enter();
}

void Insertar_Casos(MYSQL mysql, int IDCliente)
{
	int IDProductoTemp, IDCompraTemp, CantidadDCTemp, Opcion, stockTemp;
	char buffer[1024], *TipoCasoTemp;
	printf("Ingresa el ID de la compra\n");
	Purge();
	scanf (" %d",&IDCompraTemp);
	printf("Ingresa el ID del producto a devolver o cancelar\n");
	Purge();
	scanf (" %d",&IDProductoTemp);
	do
	{
		system("clear");
		printf("¿Qué quiere hacer?\n");
		printf("1.- Devolución del producto\n");
		printf("2.- Cancelación del producto\n");
		printf("Escoja una opción\n");

Purge();
scanf(" %d",&Opcion);
		if(Opcion == 1)
			TipoCasoTemp = "Devolución";
		else if(Opcion == 2)
			TipoCasoTemp = "Cancelación";
		else
		{
			printf("Opción incorrecta, intente de nuevo...");
			Opcion = 0;
		}
		Enter();
	}while(Opcion == 0);
	printf("Ingrese la cantidad de productos para proceder con la %s\n",TipoCasoTemp);

Purge();
scanf(" %d",&CantidadDCTemp);

	sprintf(buffer,"INSERT INTO DevolucionesCancelaciones(idProducto,idCompra,tipo,cantidadDC) VALUES  (%d,%d,'%s',%d)",IDProductoTemp,IDCompraTemp,TipoCasoTemp,CantidadDCTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
    Desconectar(mysql);
		exit(1);
	}
  ObtenerStock(mysql, IDProductoTemp, &stockTemp);
  ActualizarStock(mysql, IDProductoTemp, stockTemp, CantidadDCTemp);
	printf("Operación realizada correctamente\n");
	Enter();
}

void Insertar_Clientes(MYSQL mysql)
{
	char buffer[1024];
	char NombreTemp [45], APaternoTemp[45],AMaternoTemp[45], UsuarioTemp[45], PasswordTemp[45], RFCTemp[13],DireccionEnvioTemp[150],DireccionFacturacionTemp[150];
	printf("Ingresa nombre(s) del cliente\n");

  Purge();
  scanf (" %[^\n]",NombreTemp);
	printf("Ingresa el apellido paterno del cliente\n");

  Purge();
  scanf (" %[^\n]",APaternoTemp);
	printf("Ingresa el apellido materno del cliente\n");

  Purge();
  scanf (" %[^\n]",AMaternoTemp);
	printf("Ingresa el usuario\n");

  Purge();
  scanf (" %[^\n]",UsuarioTemp);
	printf("Ingresa la contraseña\n");
	Purge();
  scanf (" %[^\n]",PasswordTemp);
	printf("Ingresa el RFC\n");
	Purge();
  scanf (" %[^\n]",RFCTemp);
	printf("Ingresa la dirección de envío\n");
	Purge();
  scanf (" %[^\n]",DireccionEnvioTemp);
	printf("Ingresa la dirección de facturación\n");
	Purge();
  scanf (" %[^\n]",DireccionFacturacionTemp);

	sprintf(buffer,"INSERT INTO Clientes(idCategoriaCliente,usuario,password,nombreCliente,aPaternoCliente,aMaternoCliente,rfc,direccionEnvio,direccionFacturacion) VALUES  (1,'%s','%s','%s','%s','%s','%s','%s','%s')",UsuarioTemp,PasswordTemp,NombreTemp,APaternoTemp,AMaternoTemp,RFCTemp,DireccionEnvioTemp,DireccionFacturacionTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
    Desconectar(mysql);
		exit(1);
	}
	system("clear");
	printf("Registro exitoso\n");
	printf("INFO: Categoría de cliente 'Novato' asignada automáticamente\n");
	Enter();
}

void Insertar_Productos(MYSQL mysql)
{
	int IDDepartamentoTemp, IDCategoriaProductoTemp, StockTemp;
	double PrecioTemp;
	char buffer[1500], NombreTemp [45], MarcaTemp[45],DescripcionTemp[1000];

	printf("Ingresa ID del departamento para el nuevo producto\n");
	Purge();
  scanf (" %d",&IDDepartamentoTemp);
	printf("Ingresa ID de la categoria para el nuevo producto\n");
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

	sprintf(buffer,"INSERT INTO Productos(idDepartamento,idCategoriaProducto,nombre,marca,descripcion,precio,stock) VALUES  (%d,%d,'%s','%s','%s',%lf,%d)",IDDepartamentoTemp,IDCategoriaProductoTemp,NombreTemp,MarcaTemp,DescripcionTemp,PrecioTemp,StockTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
    Desconectar(mysql);
		exit(1);
	}
	system("clear");
	printf("Se registró correctamente el nuevo producto\n");
	Enter();
}

void Insertar_Comentarios_Productos(MYSQL mysql, int idClienteTemp)
{
	int idProductoTemp, calificacionTemp;
	char buffer[1500], comentarioTemp [1000];

	printf("Ingresa ID del producto a reseñar:\n");
	Purge();
  scanf (" %d",&idProductoTemp);
  do
  {
    printf("Ingresa la calificación del producto del 1 al 10:\n");
  	Purge();
    scanf (" %d",&calificacionTemp);
  }
  while (calificacionTemp < 0 || calificacionTemp > 10);
	printf("Ingresa el comentario\n");
	Purge();
  scanf (" %[^\n]",comentarioTemp);

	sprintf(buffer,"INSERT INTO Opiniones (idCliente, idProducto, calificacion, comentario) VALUES  (%d, %d, %d,'%s')",idClienteTemp, idProductoTemp, calificacionTemp, comentarioTemp);

	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
    Desconectar(mysql);
		exit(1);
	}
	system("clear");
	printf("Se registró correctamente el nuevo producto\n");
	Enter();
}

void Insertar_Quejas_Aclaraciones(MYSQL mysql, int idClienteTemp)
{
  time_t t;
  srand((unsigned) time(&t));
	int ultimoAsesorTemp, idAsesorTemp;
	char buffer[1500], comentarioTemp [1000];
  ObtenerUltimoAsesor (mysql, &ultimoAsesorTemp);
  idAsesorTemp = (rand() % (ultimoAsesorTemp - 1 + 1)) + 1;
	printf("Ingresa el comentario\n");
	Purge();
  scanf (" %[^\n]",comentarioTemp);
	sprintf(buffer,"INSERT INTO HistorialAtencion (idAsesor, idCliente, estado, comentarios) VALUES (%d, %d, 'Abierto', '%s')", idAsesorTemp, idClienteTemp, comentarioTemp);
	if(mysql_query(&mysql,buffer))
	{
		printf("Error al ejecutar el query: %s\n", mysql_error(&mysql));
    Desconectar(mysql);
		exit(1);
	}
	system("clear");
	printf("Se ha abierto el caso, y se le asignó un asesor\n");
	Enter();
}
