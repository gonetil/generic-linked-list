unit GenericLinkedList;
{$mode objfpc}
{$modeswitch advancedrecords}
interface

uses fgl;

type

  generic LinkedList<T> = class
   type
    TLista = ^Tnodo;
    TNodo = record
      datum : T;
      sig : Tlista;
    end;  
  private

    pri, ult, cur, prev : TLista;
    
    procedure createNode(datum :T; var node : Tlista);
    function empty : boolean;
    procedure relocatePointers;

  public
    constructor create;
    procedure reset;
    function eol : boolean;
    procedure current (var datum : T);
    procedure next;
    procedure add(datum: T);
    procedure addLast(datum: T);
    procedure insertCurrent(datum: T);
    procedure removeCurrent (var datum: T);

  end;
  
implementation
 
   {* Reset all pointers to nil
     @FIXME shall we clear all nodes from memory 
    *} 
    constructor LinkedList.create;
	  begin
		pri := nil;
		cur := nil;
		prev := nil;
		ult := nil;
	  end;
	 
  {*
   Set points for current and previous to the first node of the list
  *} 
	procedure LinkedList.reset;
	begin
	  cur := pri;
	  prev := pri;
	end;
  
    function LinkedList.empty : boolean;
    begin
      empty := (pri = nil);
    end;
    
    procedure LinkedList.current(var datum : T);
    begin
      //@WARN will break if list is empty
      datum := cur^.datum;   
    end;
    
    procedure LinkedList.next;
    begin
      prev := cur;
      //@WARN will break if list is empty
      cur := cur^.sig;  
    end;
    
    function LinkedList.eol : boolean;
    begin
      eol := (cur = nil);
    end;
    
    procedure LinkedList.createNode(datum :T; var node : Tlista);
    begin
       new(node);
       node^.datum := datum;
       node^.sig := nil;
    end;
    
    
    procedure LinkedList.add(datum: T);
    var
      aux : TLista;
    begin
      createNode(datum, aux);
      aux^.sig := pri;
      pri := aux;
      if (ult = nil) then //empty list
        ult := pri;
    end;
    
    procedure LinkedList.addLast(datum : T);
    var
      aux : Tlista;
    begin
      createNode(datum, aux);
      aux^.sig := nil;
      
      if (empty) then  begin
        pri := aux;
        reset();
      end else ult^.sig := aux;
      
      ult := aux; 
    end;    

    procedure LinkedList.insertCurrent(datum : T);
    var
      aux : Tlista;
    begin
      createNode(datum, aux);
      
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
    
    
    procedure LinkedList.removeCurrent(var datum : T);
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
      
    end;
    
    //used to relocate previous and current pointers after last node was removed
    procedure LinkedList.relocatePointers;
    var
      aux : tlista;
    begin
      aux := pri;
      while (aux <> nil) and (aux^.sig <> prev) do
        aux := aux^.sig;
      prev := aux;
      if (prev <> nil) and (prev^.sig <> nil) then
        cur := prev^.sig
      else  //there is only one node in the list
        cur := prev;  
    end;
end.
