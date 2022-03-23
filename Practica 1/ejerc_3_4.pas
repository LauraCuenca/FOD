{Realizar un programa que presente un menú con opciones para:
a. Crear un archivo de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. De cada empleado se registra: número de
empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
b. Abrir el archivo anteriormente generado y
i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado.
ii. Listar en pantalla los empleados de a uno por línea.
iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario una
única vez.
}

program ejerc_3;

type
 cadena= string[20];
 
 empleado=record
      apellido: cadena;
      nombre:cadena;
      num_emp: integer;
      edad: integer;
      dni: integer;
  end; 
  
   arch_emp= file of empleado;
{.............................................................}
  procedure leerEmpleado(var e: empleado);
  begin
   writeln ('....Apellido....');
   readln(e.apellido);
   if(e.apellido <> 'fin') then begin
    with e do begin
        write('Nombre: ');
        readLn(nombre);
        write('Numero empleado: ');
        readln(num_emp);
        write('Edad: ');
        readln(edad);
        write('DNI: ');
        readln(dni);
    end;
end;
end;
 {......................................................... }
procedure crearArchivo ();
  var
   nombre: cadena;
   archivo_emp: arch_emp; 
   e: empleado;
  begin
    write('Ingrese nombre para asignar al archivo ');
    read(nombre);
    Assign(archivo_emp,nombre);
    rewrite(archivo_emp);
    
    leerEmpleado(e);
    
    while (e.apellido <> 'fin') do begin
     write(archivo_emp,e);
     leerEmpleado(e);
    end;
    
    close(archivo_emp);
end;
{.........................................................}
procedure imprimirTodos (var arch:arch_emp);
 var 
 e:empleado;
 begin
   writeln('....Todos los Empleados....');
   while (not eof (arch)) do begin
   read(arch,e);
   writeln('Nombre: ',e.nombre);
   writeln('Apellido: ',e.apellido);
   writeln('Edad: ',e.edad);
   writeln('DNI: ',e.dni);
   writeln('--------------');
    end;
end;
{.........................................................}
procedure imprimirApellido( var arch:arch_emp);
var
e:empleado;
ape: cadena;
begin
 writeln ('Ingrese el apellido que desea buscar: ');
 readln(ape);
 while (not eof(arch)) do begin
 read(arch,e);
 
   if (e.apellido = ape) then begin
     write ('Nombre: ',e.nombre);
     write ('Apellido: ',e.apellido);
     write ('Edad: ',e.edad);
   end;
  end;
 end;
{........................................................}
procedure imprimirMayores70 (var arch:arch_emp);
var 
 e:empleado;
begin
writeln('....Empleados mayores a 70 anios....');
while (not eof(arch)) do begin
 read(arch,e);
 if (e.edad > 70) then begin
 write('Nombre: ',e.nombre);
 write('Apellido: ',e.apellido);
 end;
 end;
 end;
{........................................................}
procedure agregarEmpleado();
var
arch:arch_emp;
nombre:cadena;
e:empleado;
cant_e,i:integer;
begin
 write('Ingrese el nombre del archivo que desea abrir: ');
 readln(nombre);
 assign (arch,nombre);
 reset(arch);
 
 write('Cuantos empleados quiere agregar? ');
 readln(cant_e);
 seek(arch,Filesize(arch));
  for i:=1 to cant_e do begin
    leerEmpleado(e);
    write(arch,e);
   end;
  close(arch);
 end;
{........................................................}
procedure modificarEdad();
var
arch: arch_emp;
nombre: cadena;
num_e:integer;
e:empleado;
terminar:string[2];
salida: boolean;
begin
 terminar:= 'no';
 write('Ingrese el nomnre del archivo que quiere abrir: ');
 readln(nombre);
 Assign(arch,nombre);
 reset(arch);
 
 while (terminar <> 'no') do begin
        salida:=false;
        seek(arch,0);
  writeln('Ingrese el num de empleado,para modificar Edad: ');
  readln(num_e);
 while (not eof(arch) or not salida)do begin
  read(arch,e);
  
  If (e.num_emp = num_e) then begin
  write('Que edad le pondra a',e.apellido,':');
  readln(e.edad);
  seek(arch,Filepos(arch)-1);
  write(arch,e);
  salida:= true;
  end;
  end;
  
  write ('Desea terminar de cambiar edades? (si o no)');
  readln(terminar);
  end;
  close(arch);
  end;
{.........................................................}
 procedure imprimirArchivo ();
 var
  arch: arch_emp;
  nombre:cadena;
  op:integer;
 begin
 write('Ingrese nombre del archivo que quiere abrir: ');
 read(nombre);
 Assign(arch,nombre);
 reset(arch);
 
 writeln('Op 1: imprimir todos los empleados.');
 writeln('Op 2: imprimir solo los empleados con determinado apellido.');
 writeln('Op 3: imprimir los empleados mayores a 70 anios');
 write('Escriba la opcion que desea realizar: ');
 readln (op);
 
 case op of
  1:imprimirTodos(arch);
  2:imprimirApellido(arch);
  3:imprimirMayores70(arch);
 end;
 close(arch);
 
end;

{..........................................................}
  procedure exportarATexto();
  var
  carga: text;
  arch:arch_emp; 
  e:empleado;
  nombre:cadena;
  
  begin
  write('Ingrese el nombre del archivo que quiere abrir :');
  read(nombre);
  Assign(arch,nombre);
  reset(arch); //abro arch binario
  
  Assign(carga,'todos_empleados.txt');
  rewrite(carga);// creo mi arch de texto
  
  while (not eof(arch)) do begin
    read(arch,e);
    with e do begin
      writeln(carga,' ',num_emp,' ',edad,' ',dni,' ',nombre);
      writeln(carga,' ',apellido);
     end;
   end;
   writeln('YAYY arch exportado correctamente!');
   close(arch);
   close(carga);
   end;
{...........................................................} 
  procedure exportarDNI();
  var
  carga: text;
  nombre:cadena;
  e:empleado;
  arch: arch_emp;
  begin
  write('Ingrese el nombre del archivo que desea exportar: ');
  readln(nombre);
  assign (arch,nombre);
  reset(arch);
  
  assign(carga,'faltaDNIEmpleado.txt');
  rewrite(carga);
  
  while (not eof(arch)) do begin
  read(arch,e);
  if (e.dni = 00) then begin
  with e do begin
   writeln(carga,' ',num_emp,' ',edad,' ',dni,' ',nombre);
   writeln(carga,' ',apellido);
   end;
  end;
 end;
 
 close(arch);
 close(carga);
 end; 
{..........................................................}
var 
 num_op: integer;
 salida: boolean;
BEGIN
  salida:= false;
  
  while (not salida) do begin
  writeln('.....¿Que desea realizar?.....');
        writeln('Op 1: Crear un archivo de Empleados.');
        writeln('Op 2: Imprimir un archivo ya creado.');
        writeln('Op 3: Agregar mas empleados a un archivo ya creado.');
        writeln('Op 4: Modificar la edad de empleados.');
        writeln('Op 5: Exportar a archivo de texto.');
        writeln('Op 6: Exportar a text los empleados sin DNI(00)');
        writeln('Op 7: Salir del programa.');
        writeln('.............................................');
        write('Usted quiere elegir la opcion numero: ');
        readln(num_op);
        writeln();
        case num_op of
            1:crearArchivo;
            2:imprimirArchivo; 
            3:agregarEmpleado;
            4:modificarEdad;
            5:exportarATexto;
            6:exportarDNI;
            7:salida:=true;
        end;
    end;	
END.

