unit ListaEnlazada;
{$mode objfpc}
{$modeswitch advancedrecords}
interface

uses fgl;

type

  generic Lista<T> = class
   type
    TLista = ^Tnodo;
    TNodo = record
      datum : T;
      sig : Tlista;
    end;  
  private

    pri, ult, cur, prev : TLista;
    
    function createNode(datum :T) : Tlista;
    function empty : boolean;
    procedure relocatePointers;

  public
    constructor create;
    procedure reset;
    function eol : boolean;
    function current : T;
    procedure next;
    procedure add(datum: T);
    procedure addLast(datum: T);
    procedure insertCurrent(datum: T);
    function removeCurrent : T;

  end;
  
implementation
 
    constructor Lista.create;
	  begin
		pri := nil;
		cur := nil;
		prev := nil;
		ult := nil;
	  end;
	 
	procedure Lista.reset;
	begin
	  cur := pri;
	  prev := pri;
	end;
  
    function Lista.empty : boolean;
    begin
      empty := (pri = nil);
    end;
    
    function Lista.current : T;
    begin
      //@WARN will break if list is empty
      current := cur^.datum;   
    end;
    
    procedure Lista.next;
    begin
      prev := cur;
      //@WARN will break if list is empty
      cur := cur^.sig;  
    end;
    
    function Lista.eol : boolean;
    begin
      eol := (cur = nil);
    end;
    
    function Lista.createNode(datum :T) : Tlista;
    var
      aux : Tlista;
    begin
       new(aux);
       aux^.datum := datum;
       createNode := aux;
    end;
    
    
    procedure Lista.add(datum: T);
    var
      aux : TLista;
    begin
      aux := createNode(datum);
      aux^.sig := pri;
      pri := aux;
      if (empty) then begin //empty list
        ult := pri;
        reset;
      end;  
    end;
    
    procedure Lista.addLast(datum : T);
    var
      aux : Tlista;
    begin
      aux := createNode(datum);
      aux^.sig := nil;
      
      if (empty) then  begin
        pri := aux;
        reset();
      end else ult^.sig := aux;
      
      ult := aux; 
    end;    

    procedure Lista.insertCurrent(datum : T);
    var
      aux : Tlista;
    begin
      aux := createNode(datum);
      
      if (pri = nil) then begin//empty list
        pri := aux;
        aux^.sig := nil;
        reset;
      end else begin
        prev^.sig := aux;
        aux^.sig := cur;
        cur := aux; //set the current to the recently inserted node
      end;
      
    end;
    
    
    function Lista.removeCurrent : T;
    var
      datum : T;
    begin
      //@WARN will break if list is empty
      datum := cur^.datum; 
      
      if (prev = cur) then begin //first node
          cur := cur^.sig;
          dispose(prev);
          prev := cur;
      end else begin //any other node
        prev^.sig := cur^.sig;
        dispose(cur);
        cur := prev^.sig;
        if (cur = nil) then //last node deleted
          relocatePointers;
      end;
      
      removeCurrent := datum;
    end;
    
    //used to relocate previous and current pointers after last node was removed
    procedure Lista.relocatePointers;
    var
      aux : tlista;
    begin
      aux := pri;
      while (aux <> nil) and (aux^.sig <> prev) do
        aux := aux^.sig;
      prev := aux;
      cur := aux^.sig;
    end;
end.
