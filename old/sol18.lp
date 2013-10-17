#const n=18.
#const m=(n/2+(n-2*(n/2))).  

ss(X,Y,(X-1)*n/2+Y) :- k(X;Y). 
pp(X,Y,(X-1)*n/2+Y+(n*n)/4) :- k(X;Y).

s(X,Y) :- sol(Z), ss(X,Y,Z). 
p(X,Y) :- sol(Z), pp(X,Y,Z). 

k(1..m).  
c(1..n).  

t(X,Y,X,Y,0,0) :- k(X;Y).
t(YY,n+1-XX,X,Y,P,1-S) :- t(XX,YY,X,Y,S,P).

p(c,XX,YY) :- not s(X,Y), not p(X,Y), t(XX,YY,X,Y,0,0).
p(c,XX,YY) :- not s(X,Y), p(X,Y), t(XX,YY,X,Y,0,1).
p(c,XX,YY) :- s(X,Y), not p(X,Y), t(XX,YY,X,Y,1,0).
p(c,XX,YY) :- s(X,Y), p(X,Y), t(XX,YY,X,Y,1,1).

% printing stuff
#hide.
#show p/3. 
size(n).

color(a;b;c;d).
                                                                         
c(1..n).

t1(X,Y,Y,Z) :- c(X;Y;Z), X+Z-1==n. 
t2(a,b). 
t2(b,c). 
t2(c,d). 
t2(d,a). 

p(CC,XX,YY) :- p(C,X,Y), t1(X,Y,XX,YY), t2(C,CC). 


% checking constraint
%c(X,Y) :- p(c,X,Y). 
%:- c(X,Y), DX = X+1..n, DY = Y+1..n, c(DX,Y), c(X,DY), c(DX,DY). 

sol(1).
sol(-2).
sol(-3).
sol(-4).
sol(-5).
sol(-6).
sol(7).
sol(8).
sol(-9).
sol(-10).
sol(-11).
sol(-12).
sol(13).
sol(-14).
sol(15).
sol(16).
sol(17).
sol(18).
sol(-19).
sol(-20).
sol(21).
sol(22).
sol(-23).
sol(-24).
sol(25).
sol(26).
sol(27).
sol(28).
sol(-29).
sol(30).
sol(31).
sol(-32).
sol(-33).
sol(34).
sol(-35).
sol(-36).
sol(-37).
sol(38).
sol(39).
sol(-40).
sol(41).
sol(42).
sol(43).
sol(-44).
sol(-45).
sol(46).
sol(-47).
sol(48).
sol(-49).
sol(50).
sol(-51).
sol(-52).
sol(-53).
sol(-54).
sol(55).
sol(-56).
sol(57).
sol(58).
sol(-59).
sol(-60).
sol(-61).
sol(-62).
sol(63).
sol(64).
sol(-65).
sol(66).
sol(-67).
sol(-68).
sol(69).
sol(70).
sol(-71).
sol(-72).
sol(-73).
sol(74).
sol(-75).
sol(76).
sol(77).
sol(78).
sol(-79).
sol(80).
sol(81).
sol(-82).
sol(83).
sol(-84).
sol(-85).
sol(-86).
sol(87).
sol(88).
sol(-89).
sol(90).
sol(91).
sol(92).
sol(93).
sol(-94).
sol(95).
sol(-96).
sol(97).
sol(98).
sol(99).
sol(-100).
sol(-101).
sol(102).
sol(-103).
sol(104).
sol(-105).
sol(-106).
sol(-107).
sol(108).
sol(-109).
sol(-110).
sol(-111).
sol(112).
sol(113).
sol(114).
sol(115).
sol(-116).
sol(-117).
sol(118).
sol(-119).
sol(120).
sol(121).
sol(122).
sol(-123).
sol(124).
sol(-125).
sol(126).
sol(127).
sol(128).
sol(129).
sol(-130).
sol(-131).
sol(-132).
sol(133).
sol(134).
sol(-135).
sol(136).
sol(137).
sol(-138).
sol(-139).
sol(-140).
sol(-141).
sol(-142).
sol(-143).
sol(144).
sol(-145).
sol(-146).
sol(147).
sol(-148).
sol(149).
sol(150).
sol(-151).
sol(152).
sol(153).
sol(-154).
sol(-155).
sol(156).
sol(157).
sol(158).
sol(159).
sol(-160).
sol(-161).
sol(162).
