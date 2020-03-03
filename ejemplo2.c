#include <stdio.h>
#include <stdlib.h>
#include <mysql/mysql.h>

int main(int argc, char *argv[])
{
  int i = 0;
  int Year;
  char buffer[1024];
  char *server = "localhost";
  char *user = "ic18rgp";
  char *password = "208366";
  char *db = "ic18rgp";
  MYSQL mysql;
  MYSQL_RES *res;
  MYSQL_ROW row;
  mysql_init(&mysql);
  //Se conecta al servidor
  if(!mysql_real_connect(&mysql, server, user, password, db, 0, NULL, 0))
  {
    printf ("Error al conectarse: %s\n", mysql_error(&mysql));
    exit(1);
  }
  //Se conecta a la base de datos
  if(mysql_select_db(&mysql, db))
  {
    printf("Error al seleccionar la bd %s\n", mysql_error(&mysql));
    exit(1);
  }
  printf("Introduzca el año de nacimiento: ");
  scanf("%d", &Year);
  //Ejecuta el query
  sprintf(buffer, "SELECT * FROM presidentes WHERE YEAR(nacimiento) = '%d'", Year);
  if(mysql_query(&mysql, buffer))
  {
    printf("Error al ejecutar el query %s\n", mysql_error(&mysql));
    exit(1);
  }
  //Obtenemos el mysql_query
  if(!(res = mysql_store_result(&mysql)))
  {
    printf("Error al obtener el query%s\n", mysql_error(&mysql));
    exit(1);
  }
  //Desplegamos el resultset
  while((row = mysql_fetch_row(res)))
  {
    for(i = 0; i < mysql_num_fields(res); i++)
    {
      if(row[i] != NULL)
      {
        printf("%s", row[i]);
      }
      else
      {
        printf("---");
      }
      printf("\n");
    } //for
    printf("\n");
  } //while
  mysql_free_result(res);
  mysql_close(&mysql);
} //main
