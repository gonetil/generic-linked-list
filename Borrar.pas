program test;
uses GenericLinkedList;

type  
  ListaInt = specialize LinkedList<integer>;
  
procedure printFullList(L : ListaInt);
var
  num,cur : integer;
begin
  //vamos a recorrer la lista completa
  l.reset();
  writeln; writeln('----------------------');
  num := 0;
  while (not l.eol) do begin
    num := num + 1;
    l.current(cur);
    writeln('Nodo ',num,' ==> ', cur);
    l.next;
  end;
  writeln('******'); writeln;
end;

procedure insertOrdered(l: ListaInt; valor: integer);
var buscar: boolean; actual: integer;
begin
l.reset;
buscar:= true;
while(not l.eol) and buscar do
	begin
	l.current(actual);
	if actual > valor then begin
		buscar:= false;
		end
	else begin
		l.next;
		end
	end;
l.insertCurrent(valor);
end;

var 
  l: ListaInt;

begin
  //randomize;
  
  l:= ListaInt.create;  
  insertOrdered(l, 10);
  insertOrdered(l, 12);
  insertOrdered(l, 8);
  L.add(14);
  L.addFirst(5);
  L.addFirst(4);
  insertOrdered(L, 15);
  printFullList(l);
end.
