program test;
uses GenericLinkedList;
const
  steps = 6;
type
  
  ListaInt = specialize LinkedList<integer>;
  
function square(num : integer) : integer;
begin 
  square := num*num
end;

procedure printFullList(L : ListaInt);
var
  num, aux : integer;
begin
  //vamos a recorrer la lista completa
  l.reset();
  writeln; writeln('----------------------');
  num := 0;
  while (not l.eol()) do begin
    num := num + 1;
    l.current(aux);
    writeln('Nodo ',num,' ==> ', aux);
    l.next;
  end;
  writeln('******'); writeln;
end;


var 

  l: ListaInt;
  i, aux : integer;
begin
  l:= ListaInt.create;
  //ponemos algunos valores en la lista de numeros

  writeln('Armo una lista con algunos numeros ');

  for i:= -4 to 5 do
    l.addLast(square(i));

  printFullList(L);

  //volvemos al inicio y avanzamos algunos nodos
  l.reset(); 
  for i:= 1 to steps do l.next();
  l.current(aux);
  writeln('Desde el inicio, avancé ',steps,' nodos. El nodo actual tiene el valor ',aux);
  writeln('Agrego el numero ',square(square(steps)),' en la posicion actual');
  l.insertCurrent(square(square(steps)));

  printFullList(L);

  //volvemos al inicio y avanzamos algunos nodos
  l.reset(); 
  for i:= 1 to steps do l.next();
  l.current(aux);
  writeln('Desde el inicio, avancé ',steps,' nodos. El nodo actual tiene el valor ',aux);
  writeln('Elimino los siguientes ',steps DIV 2,' nodos ');
  for i:= 1 to (steps DIV 2) do begin
    l.removeCurrent(aux);
    writeln('Se elimino el numero ',aux);

  end;
  writeln('Ahora me salteo un nodo, y elimino el siguiente');
  l.next();
  l.removeCurrent(i);
  writeln('Se elimino el numero ',i);

  l.current(aux);
  writeln('Quedé parado en un nodo que tiene el valor ',aux);
  l.removeCurrent(aux);
  writeln('Borro el nodo actual: ',aux);
  l.current(aux);
  writeln('El nuevo nodo actual tiene el valor ',aux);
  writeln('La lista quedo:' );
  printFullList(L);
  

end.
