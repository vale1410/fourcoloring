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
     (c(R,C)->
      write('X');
      write(' ')
     ),
     CC is C-1,
     printRow(R,CC,M).

