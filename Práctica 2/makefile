aplicacion.exe: practica2.o conexion.o insertar.o actualizar.o eliminar.o leer.o consultas.o
	gcc -o aplicacion.exe practica2.o conexion.o insertar.o actualizar.o eliminar.o leer.o consultas.o -lnsl -lm -lz -lmysqlclient

practica2.o: practica2.c
	gcc -c practica2.c
conexion.o: conexion.c
	gcc -c conexion.c
insertar.o: insertar.c
	gcc -c insertar.c
actualizar.o: actualizar.c
	gcc -c actualizar.c
eliminar.o: eliminar.c
	gcc -c eliminar.c
leer.o: leer.c
	gcc -c leer.c
consultas.o: consultas.c
	gcc -c consultas.c
clean:
	rm *.o
	clear