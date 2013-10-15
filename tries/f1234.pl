start :- 
    size(N),
    printRow(N,N,N). 

printRow(0,_,_) :-
    !.
    
printRow(R,0,M) :-
    !,
    write('\n'),
    RR is R-1,
    printRow(RR,M,M).


printRow(R,C,M) :- 
    (p(P,R,C)->
     write(P);
     write(' ')
     ),
     CC is C-1,
     printRow(R,CC,M).

size(17).
p(c,17,16).
p(c,17,13).
p(c,17,12).
p(c,17,7).
p(c,16,11).
p(c,16,8).
p(c,16,3).
p(c,16,2).
p(c,15,15).
p(c,15,14).
p(c,15,12).
p(c,15,10).
p(c,15,8).
p(c,14,16).
p(c,14,10).
p(c,14,5).
p(c,14,2).
p(c,13,17).
p(c,13,16).
p(c,13,15).
p(c,13,3).
p(c,12,14).
p(c,12,13).
p(c,12,4).
p(c,12,2).
p(c,11,16).
p(c,11,8).
p(c,11,6).
p(c,11,1).
p(c,10,17).
p(c,10,7).
p(c,10,6).
p(c,10,2).
p(c,9,15).
p(c,9,13).
p(c,9,9).
p(c,9,1).
p(c,8,17).
p(c,8,13).
p(c,8,8).
p(c,8,5).
p(c,7,15).
p(c,7,11).
p(c,7,6).
p(c,7,5).
p(c,7,4).
p(c,6,13).
p(c,6,10).
p(c,6,6).
p(c,6,3).
p(c,5,14).
p(c,5,9).
p(c,5,7).
p(c,5,5).
p(c,4,10).
p(c,4,7).
p(c,4,4).
p(c,4,1).
p(c,3,17).
p(c,3,14).
p(c,3,11).
p(c,3,1).
p(c,2,12).
p(c,2,5).
p(c,2,3).
p(c,2,1).
p(c,1,17).
p(c,1,12).
p(c,1,9).
p(c,1,4).
p(d,4,17).
p(d,9,17).
p(d,12,17).
p(d,17,17).
p(d,1,16).
p(d,3,16).
p(d,5,16).
p(d,12,16).
p(d,1,15).
p(d,11,15).
p(d,14,15).
p(d,17,15).
p(d,1,14).
p(d,4,14).
p(d,7,14).
p(d,10,14).
p(d,5,13).
p(d,7,13).
p(d,9,13).
p(d,14,13).
p(d,3,12).
p(d,6,12).
p(d,10,12).
p(d,13,12).
p(d,4,11).
p(d,5,11).
p(d,6,11).
p(d,11,11).
p(d,15,11).
p(d,5,10).
p(d,8,10).
p(d,13,10).
p(d,17,10).
p(d,1,9).
p(d,9,9).
p(d,13,9).
p(d,15,9).
p(d,2,8).
p(d,6,8).
p(d,7,8).
p(d,17,8).
p(d,1,7).
p(d,6,7).
p(d,8,7).
p(d,16,7).
p(d,2,6).
p(d,4,6).
p(d,13,6).
p(d,14,6).
p(d,3,5).
p(d,15,5).
p(d,16,5).
p(d,17,5).
p(d,2,4).
p(d,5,4).
p(d,10,4).
p(d,16,4).
p(d,8,3).
p(d,10,3).
p(d,12,3).
p(d,14,3).
p(d,15,3).
p(d,2,2).
p(d,3,2).
p(d,8,2).
p(d,11,2).
p(d,7,1).
p(d,12,1).
p(d,13,1).
p(d,16,1).
p(a,1,2).
p(a,1,5).
p(a,1,6).
p(a,1,11).
p(a,2,7).
p(a,2,10).
p(a,2,15).
p(a,2,16).
p(a,3,3).
p(a,3,4).
p(a,3,6).
p(a,3,8).
p(a,3,10).
p(a,4,2).
p(a,4,8).
p(a,4,13).
p(a,4,16).
p(a,5,1).
p(a,5,2).
p(a,5,3).
p(a,5,15).
p(a,6,4).
p(a,6,5).
p(a,6,14).
p(a,6,16).
p(a,7,2).
p(a,7,10).
p(a,7,12).
p(a,7,17).
p(a,8,1).
p(a,8,11).
p(a,8,12).
p(a,8,16).
p(a,9,3).
p(a,9,5).
p(a,9,9).
p(a,9,17).
p(a,10,1).
p(a,10,5).
p(a,10,10).
p(a,10,13).
p(a,11,3).
p(a,11,7).
p(a,11,12).
p(a,11,13).
p(a,11,14).
p(a,12,5).
p(a,12,8).
p(a,12,12).
p(a,12,15).
p(a,13,4).
p(a,13,9).
p(a,13,11).
p(a,13,13).
p(a,14,8).
p(a,14,11).
p(a,14,14).
p(a,14,17).
p(a,15,1).
p(a,15,4).
p(a,15,7).
p(a,15,17).
p(a,16,6).
p(a,16,13).
p(a,16,15).
p(a,16,17).
p(a,17,1).
p(a,17,6).
p(a,17,9).
p(a,17,14).
p(b,14,1).
p(b,9,1).
p(b,6,1).
p(b,1,1).
p(b,17,2).
p(b,15,2).
p(b,13,2).
p(b,6,2).
p(b,17,3).
p(b,7,3).
p(b,4,3).
p(b,1,3).
p(b,17,4).
p(b,14,4).
p(b,11,4).
p(b,8,4).
p(b,13,5).
p(b,11,5).
p(b,9,5).
p(b,4,5).
p(b,15,6).
p(b,12,6).
p(b,8,6).
p(b,5,6).
p(b,14,7).
p(b,13,7).
p(b,12,7).
p(b,7,7).
p(b,3,7).
p(b,13,8).
p(b,10,8).
p(b,5,8).
p(b,1,8).
p(b,17,9).
p(b,9,9).
p(b,5,9).
p(b,3,9).
p(b,16,10).
p(b,12,10).
p(b,11,10).
p(b,1,10).
p(b,17,11).
p(b,12,11).
p(b,10,11).
p(b,2,11).
p(b,16,12).
p(b,14,12).
p(b,5,12).
p(b,4,12).
p(b,15,13).
p(b,3,13).
p(b,2,13).
p(b,1,13).
p(b,16,14).
p(b,13,14).
p(b,8,14).
p(b,2,14).
p(b,10,15).
p(b,8,15).
p(b,6,15).
p(b,4,15).
p(b,3,15).
p(b,16,16).
p(b,15,16).
p(b,10,16).
p(b,7,16).
p(b,11,17).
p(b,6,17).
p(b,5,17).
p(b,2,17).