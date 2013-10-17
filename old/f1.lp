%#const n=10.
%
%color(blue;green;red;yellow).
%
%1 { c(X,Y,C) : color(C) } 1:- X = 1..n, Y = 1..n. 
%
%:- c(X,Y,C), DX = X+1..n, DY = Y+1..n, c(DX,Y,C), c(X,DY,C), c(DX,DY,C).
%
%:- C = green, not n { c(X,Y,C) } n.


#const n=10.

#hide k/4. 

size(n).
                                                                         
{ c(X,Y) } :- X = 1..n, Y = 1..n.                        
                                                                         
:- c(X,Y), DX = X+1..n, DY = Y+1..n, c(DX,Y), c(X,DY), c(DX,DY). 

%#maximize[c(_,_)@2].

% exactly n^2/4 over the whole board                                                                         

:- not (n*n)/4 { c(X,Y) } (n*n)/4.                                      

:- X=1..n,  { c(X,Y) } 3.                                      
:- Y=1..n,  { c(X,Y) } 3.                                      
:- X=1..n,  6 { c(X,Y) }.                                      
:- Y=1..n,  6 { c(X,Y) }.                                      


k(X,Y,DX,DY) :- X = 1..n, Y = 1..n, DX = X+1..n, DY = Y+1..n, 
          not c(X,Y), not c(DX,Y), not c(X,DY), not c(DX,DY).
          % DX-X < 6, DY-Y < 6.

%x(X) :- X=1..n,  5 { c(X,Y) }.                                      
%y(Y) :- Y=1..n,  5 { c(X,Y) }.                                      
%
%k(X,Y) :- x(X), y(Y).

#minimize[k(_,_,_,_)@1].

%same_row(X,Y) :- same_row(X,Y-1), c(X,Y), c(X-1,Y), X = 2..n.
%same_row(X,Y) :- same_row(X,Y-1), not c(X,Y), not c(X-1,Y), Y = 1..n, X = 2..n.
%same_row(X,0) :- X = 1..n.
%:- same_row(X,Y-1), not c(X,Y), c(X-1,Y).
