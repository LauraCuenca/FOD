{Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo.}
program ejerc1;


type
   archivo=  file of integer;
   
 var
  arch: archivo;
  nombre:string;
  num:integer;
  
 begin
   write ('Ingrese el nombre del archivo: ');
   readln (nombre);
   Assign (arch,nombre);
   rewrite (arch);
   while (num <> 3000)do begin
      write(arch,num);
      write ('Ingresar un numero');
      readln (num);
   end;
   close(arch);
   
  end.
  
