#const n=17.

#hide.
#show s/3. 

size(n).

color(a;b;c;d).
                                                                         
c(1..n).

t1(X,Y,Y,Z) :- c(X;Y;Z), X+Z-1==n. 
t2(a,b). 
t2(b,c). 
t2(c,d). 
t2(d,a). 

p(CC,XX,YY) :- p(C,X,Y), t1(X,Y,XX,YY), t2(C,CC). 

p(c,X,Y) :- c(X,Y). 



%p(X,Y) :- p(_,X,Y). 
%
%{ s(C,X,Y) : color(C) } :- X = 1..n, Y = 1..n, not p(X,Y). 
%
%t(C,X,Y) :- p(C,X,Y).
%t(C,X,Y) :- s(C,X,Y).
%
%%:- c(X;Y), 2 { t(C,X,Y) : color(C) }.
%
%#maximize{ t(_,_,_) }.
%
%:- t(C,X,Y), DX = X+1..n, DY = Y+1..n, t(C,DX,Y), t(C,X,DY), t(C,DX,DY). 

