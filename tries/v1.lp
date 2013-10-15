#const n=18.  
#const m=(n/2+(n-2*(n/2))).  

#hide.
#show s/2. 
#show p/2. 

k(1..m).  
c(1..n).  

{ s(X,Y) } :- k(X;Y). 
{ p(X,Y) } :- k(X;Y). 

t(X,Y,X,Y,0,0) :- k(X;Y).
t(YY,n+1-XX,X,Y,P,1-S) :- t(XX,YY,X,Y,S,P).

:- c(X;Y), DX = X+1..n, DY = Y+1..n, 
   t(X,Y,X1,Y1,S1,P1),
   t(X,DY,X2,Y2,S2,P2),
   t(DX,DY,X3,Y3,S3,P3),
   t(DX,Y,X4,Y4,S4,P4),

   not s(X1,Y1) : S1==0 ,not p(X1,Y1): P1==0, 
       s(X1,Y1) : S1==1 ,    p(X1,Y1): P1==1,

   not s(X2,Y2) : S2==0 ,not p(X2,Y2): P2==0, 
       s(X2,Y2) : S2==1 ,    p(X2,Y2): P2==1,

   not s(X3,Y3) : S3==0 ,not p(X3,Y3): P3==0, 
       s(X3,Y3) : S3==1 ,    p(X3,Y3): P3==1,

   not s(X4,Y4) : S4==0 ,not p(X4,Y4): P4==0, 
       s(X4,Y4) : S4==1 ,    p(X4,Y4): P4==1.

% symmetry breaker, set unique central bit
:- not s(m,m).
:- not p(m,m).
