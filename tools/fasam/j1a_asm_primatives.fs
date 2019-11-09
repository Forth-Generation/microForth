\  j1a  assembler base word definitions

: T          0x0000 ;
: N          0x0100 ;
: T+N        0x0200 ;
: T&N        0x0300 ;
: T|N        0x0400 ;
: T^N        0x0500 ;
: ~T         0x0600 ;
: N==T       0x0700 ;
: N<T        0x0800 ;
: T2/        0x0900 ;
: T2*        0x0a00 ;
: rT         0x0b00 ;
: N-T        0x0c00 ;
: io[T]      0x0d00 ;
: status     0x0e00 ;
: Nu<T       0x0f00 ;

: T->N       0x0010 |or| ;
: T->R       0x0020 |or| ;
: N->[T]     0x0030 |or| ;
: N->io[T]   0x0040 |or| ;
: _IORD_     0x0050 |or| ;
: RET        0x0080 |or| ;

: d-1        0x0003 |or| ;
: d+1        0x0001 |or| ;
: r-1        0x000c |or| ;
: r-2        0x0008 |or| ;
: r+1        0x0004 |or| ;

: imm        0x8000 |or| tcode, ;
: alu        0x6000 |or| tcode, ;
: ubranch    0x0000 |or| tcode, ;
: 0branch    0x2000 |or| tcode, ;
: scall      0x4000 |or| tcode, ;
: @imm       0x5000 |or| tcode, ;   \ fetch immediate


:: noop      T                       alu ;
:: +         T+N                 d-1 alu ;
:: -         N-T                 d-1 alu ;
:: xor       T^N                 d-1 alu ;
:: and       T&N                 d-1 alu ;
:: or        T|N                 d-1 alu ;
:: invert    ~T                      alu ;
:: =         N==T                d-1 alu ;
:: <         N<T                 d-1 alu ;
:: u<        Nu<T                d-1 alu ;
:: swap      N     T->N              alu ;
:: dup       T     T->N          d+1 alu ;
:: drop      N                   d-1 alu ;
:: over      N     T->N          d+1 alu ;
:: nip       T                   d-1 alu ;
:: >r        N     T->R      r+1 d-1 alu ;
:: r>        rT    T->N      r-1 d+1 alu ;
:: r@        rT    T->N          d+1 alu ;
:: io@       T     _IORD_            alu
             io[T]                   alu ;
:: !         
             T     N->[T]        d-1 alu
             N                   d-1 alu ;
:: io!       
             T     N->io[T]      d-1 alu
             N                   d-1 alu ;
:: 2/        T2/                     alu ;
:: 2*        T2*                     alu ;
:: depth     status T->N         d+1 alu ;
:: exit      T  RET              r-1 alu ;
:: pexit     T  RET          d-1 r-1 alu ;  \ pop return
:: hack      T      N->io[T]         alu ;

\ Elided words
\ These words are supported by the hardware but are not
\ part of ANS Forth.  They are named after the word-pair
\ that matches their effect  
\ Using these elided words instead of
\ the pair saves one cycle and one instruction.

:: 2dupand   T&N   T->N          d+1 alu ;
:: 2dup<     N<T   T->N          d+1 alu ;
:: 2dup=     N==T  T->N          d+1 alu ;
:: 2dupor    T|N   T->N          d+1 alu ;
:: 2dup+     T+N   T->N          d+1 alu ;
:: 2dupu<    Nu<T  T->N          d+1 alu ;
:: 2dupxor   T^N   T->N          d+1 alu ;
:: dup>r     T     T->R      r+1     alu ;
:: overand   T&N                     alu ;
:: over>     N<T                     alu ;
:: over=     N==T                    alu ;
:: overor    T|N                     alu ;
:: over+     T+N                     alu ;
:: overu>    Nu<T                    alu ;
:: overxor   T^N                     alu ;
:: rdrop     T                   r-1 alu ;
:: tuck!     T     N->[T]        d-1 alu ;
