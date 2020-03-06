: noop      T                       alu ;
: +         T+N                 d-1 alu ;
: -         N-T                 d-1 alu ;
: xor       T^N                 d-1 alu ;
: and       T&N                 d-1 alu ;
: or        T|N                 d-1 alu ;
: invert    ~T                      alu ;
: =         N==T                d-1 alu ;
: <         N<T                 d-1 alu ;
: u<        Nu<T                d-1 alu ;
: swap      N     T->N              alu ;
: dup       T     T->N          d+1 alu ;
: drop      N                   d-1 alu ;
: over      N     T->N          d+1 alu ;
: nip       T                   d-1 alu ;
: >r        N     T->R      r+1 d-1 alu ;
: r>        rT    T->N      r-1 d+1 alu ;
: r@        rT    T->N          d+1 alu ;
: io@       T     _IORD_            alu
            io[T]                   alu ;
: !         
            T     N->[T]        d-1 alu
            N                   d-1 alu ;
: io!       
            T     N->io[T]      d-1 alu
            N                   d-1 alu ;
: 2/        T2/                     alu ;
: 2*        T2*                     alu ;
: depth     status T->N         d+1 alu ;
: exit      T  RET              r-1 alu ;
: hack      T      N->io[T]         alu ;

