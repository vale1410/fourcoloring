#const n=18.
#hide t/4. 

size(n).
                                                                         
{ c(X,Y) } :- X = 1..n, Y = 1..n.                        

:- not c((n/2)+1,(n/2)+1).

c(1..n).
cc(1..n/2+(n-2*(n/2))). 
                                                                         
:- c(X,Y), DX = X+1..n, DY = Y+1..n, c(DX,Y), c(X,DY), c(DX,DY). 


t(X,Y,X,Y) :- cc(X;Y).
t(X,Y,YY,n+1-XX) :- t(X,Y,XX,YY).

:- X = 1..n/2, Y = 1..n/2, not 1 {c(XX,YY) : t(X,Y,XX,YY) } 1. 
