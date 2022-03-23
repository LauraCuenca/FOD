{ Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creados en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y
el promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.}

program ejerc_2;

type
   archivo=file of integer;
var 
   arch: archivo;
   num,menos_de_1500,prom: integer;
   nombre: string;

BEGIN
    menos_de_1500:=0;
    prom:=0;
	write('Ingrese el nombre del archivo que desea abrir: ');
	readln(nombre);
	Assign(arch,nombre);
	reset(arch);
	
	While (not Eof(arch)) do begin
	  read(arch, num);
	  
	  writeln (num,' ');
	  
	  if (num < 1500)then 
	    menos_de_1500:= menos_de_1500 + 1;
	  
	  prom:= prom + num;  
	 
	end;
	
	writeln('Cantidad de num que son menores de 1500: ',menos_de_1500);
	writeln ('Promedio de los enteros: ', prom/ filesize(arch));
	close(arch);
	
END.

