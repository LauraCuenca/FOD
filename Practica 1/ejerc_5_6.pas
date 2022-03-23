{Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:
a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
correspondientes a los celulares, deben contener: código de celular, el nombre,
descripcion, marca, precio, stock mínimo y el stock disponible.
b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo.
c. Listar en pantalla los celulares del archivo cuya descripción contenga una
cadena de caracteres proporcionada por el usuario.
d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
“celulares.txt” con todos los celulares del mismo. }

program ejerc_5;
type
 cadena = string[30];
 
 celular= record
   cod: integer;
   nombre:cadena;
   desc:cadena;
   marca:cadena;
   precio:real;
   stock_min: integer;
   stock_disp:integer;
 end;
 
 arch_cel= file of celular;

var
op: integer;
salir:boolean;
{........................................................}
procedure crearBinario();
var
n_text,nombre: cadena;
arch: arch_cel;
texto:text;
c:celular;
begin
 write('Nombre del archivo de texto: ');
 readln(n_text);
 assign(texto,n_text);
 reset(texto);
 
 write('Nombre del archivo nuevo: ');
 readln(nombre);
 assign(arch,nombre);
 rewrite(arch);
 
 while(not eof(texto)) do begin
  with c do begin
    readln(texto,cod,stock_disp,stock_min,precio,nombre);
    readln(texto,desc);
    readln(texto,marca); //guardo en r los datos que estaban en el txt
   end;
   write(arch,c);
 end;
 writeln('Archivo cargado correctamente <3');
 close(texto);
 close(arch);
 end;
 {.......................................................}
 procedure imprimirStock();
 var
 arch:arch_cel;
 c:celular;
 nombre:cadena;
 begin
 write('Nombre del archivo que quiere imprimir con stock menor ');
 readln(nombre);
 assign(arch,nombre);
 reset(arch);
 
 while(not EOF(arch)) do begin
  read(arch,c);
  with c do begin
   if (stock_disp < stock_min) then begin
     writeln('Nombre: ',nombre);
     writeln('Descrip: ',desc);
     writeln('Marca: ',marca);
     writeln('Precio: ',precio);
     writeln('Stock disp: ',stock_disp);
    end;
   end;
   end;
   close(arch);
 end;
 {.........................................................}
 procedure imprimirDesc();
 var
 arch:arch_cel;
 c:celular;
 nombre,cad:cadena;
 begin
 write('Ingrese nombre del archivo que desea abrir: ');
 readln(nombre);
 assign(arch,nombre);
 reset(arch);
 
 write('Ingrese cadena de descripcion a buscar: ');
  readln(cad);
 while(not eof(arch)) do begin
  read(arch,c);
  with c do begin
  if Pos(cad,desc)<> 0 then begin 
  writeln('Nombre: ',nombre);
  writeln('Marca: ',marca);
  writeln('Precio: ',precio);
  writeln('Stock minimo: ',stock_min);
  writeln('Stock disp: ',stock_disp);
  writeln('........................');
   end;
  end;
  end;
  close(arch);
  end;
  {.......................................................}
 procedure exportarText();
  var
  nombre:cadena;
  arch:arch_cel;
  texto:text;
  c:celular;
 begin
  write('Ingrese el nombre del archivo que quiere pasar a texto: ');
  readln(nombre);
  assign(arch,nombre);
  reset(arch);
  
  assign(texto,'celulares.txt');
  rewrite(texto);
  
  while(not eof(arch)) do begin
  read(arch,c);
  with c do begin
   writeln(texto,' ',cod,' ',nombre,' ',desc,' ',marca,' ',precio:5:2,' ',stock_min,' ',stock_disp);
  end;
 end;
 close(arch);
 close(texto);
 end;
 {.....................................................}
 procedure leerCelular(var c: celular);
 begin
 write('....Datos celular....');
 write('Codigo: ');
 readln(c.cod);
 If c.cod <> -1 then begin
 with c do begin
        write('Nombre: ');
        readln(nombre);
        write('Descripcion: ');
        readln(desc);
        write('Marca: ');
        readln(marca);
        write('Precio: ');
        readln(precio);
        write('Stock minimo: ');
        readln(stock_min);
        write('Stock disponible: ');
        readln(stock_disp);
    end;
  end;
end;
 {.....................................................}
 procedure agregarCelulares();
 var
 cant_cel,i: integer;
 nombre:cadena;
 arch:arch_cel;
 c:celular;
 begin
 write('Ingrese el nombre del arch que desea abrir: ');
  readln(nombre);
  assign(arch,nombre);
  reset(arch);
  seek(arch,FileSize(arch));
  
  write('Ingrese la cant de celulares que desea agregar: ');
  readln(cant_cel);
  
  for i:= 1 to cant_cel do begin
   leerCelular(c);
   write(arch,c);
   end;
   close(arch);
 end;
 
 {.........................................................}
 procedure modificarStock();
 var
  arch:arch_cel;
  c:celular;
  nombre,n_cel:cadena;
  bool:boolean;
 begin
 bool:= false;
 write('Ingrese el nombre del archivo que desea abrir: ');
 readln(nombre);
 assign(arch,nombre);
 reset(arch);
 
 write('Ingrese nombre del celular para modificar el stock:');
 readln(n_cel);
 while(not eof(arch)or (not bool)) do begin
  read(arch,c);
  if(n_cel = c.nombre) then begin
   write('Ingrese cant nueva de stock: ');
   readln(c.stock_disp);
   seek(arch,FilePos(arch)-1);
   write(arch,c);
   bool:= true;
   end;
   end;
   if(not bool) then
     writeln('Ese nombre de celular no se encuentra en el archivo ');
  close(arch);
 end;
 {..........................................................} 
 procedure textStock();
 var
 nombre:cadena;
 c:celular;
 arch:arch_cel;
 texto:text;
 begin
 write('Ingrese el nombre del arch que desea abrir: ');
 readln(nombre);
 assign(arch,nombre);
 reset(arch);
 
 assign(texto,'SinStock.txt');
 rewrite(texto);
 
 while(not eof(arch)) do begin
  read(arch,c);
  if(c.stock_disp = 0) then begin
   with c do
      writeln(texto,' ',cod,' ',nombre,' ',desc,' ',marca,' ',precio:5:2,' ',stock_min,' ',stock_disp);
        end;
    end;
    close(arch);
    close(texto);
end;
 {.........................................................}  

BEGIN
	salir:= false;
	while (not salir) do begin
	  writeln('........Menu.......');
	  writeln('Op 1: Crear un archivo Binario de uns txt ');
	  writeln('Op 2: Imprimir celulares con stock menor al minimo ');
	  writeln('Op 3: Imprimir celulares con desc determinada ');
	  writeln('Op 4: Exportar a arch txt');
	  writeln('Op 5: Agregar celulares a un archivo ya creado');
      writeln('Op 6: Modificar stock de un archivo ya creado');
      writeln('Op 7: Exportar a txt los celulares con stock =0');
      writeln('Op 8: Cerrar el programa');
      write('Opcion a elegir: ');
      readln(op);
	  case op of
	  1:crearBinario;
	  2:imprimirStock;
	  3:imprimirDesc;
	  4:exportarText;
	  5:agregarCelulares;
	  6:modificarStock;
	  7:textStock;
	  8:salir:= true;
	  end;
	 end;
END.

