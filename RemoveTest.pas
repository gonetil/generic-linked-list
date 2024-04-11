program test;
uses GenericLinkedList;
type
  
  ListaInt = specialize LinkedList<integer>;
var 
  L : ListaInt;
  num : integer;
begin
  L := ListaInt.create;
  L.add(1);  L.add(2);
  l.reset;
  L.current(num); writeln('El current es: ',num);
  L.removeCurrent(num);  writeln('Removi el ', num);
  L.current(num); writeln('El current es: ',num);
  L.removeCurrent(num);  writeln('Removi el ', num);
  //Si ejecuto la siguiente línea, se rompe
  //L.current(num); writeln('El current es: ',num);
end.