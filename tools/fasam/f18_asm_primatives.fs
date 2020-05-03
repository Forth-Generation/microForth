\  j1a  assembler base word definitions

: T          0x00000 ;
: N          0x00100 ;
: T+N        0x00200 ;
: T&N        0x00300 ;
: T|N        0x00400 ;
: T^N        0x00500 ;
: ~T         0x00600 ;
: N==T       0x00700 ;
: N<T        0x00800 ;
: T2/        0x00900 ;
: T2*        0x00a00 ;
: rT         0x00b00 ;
: N-T        0x00c00 ;
: io[T]      0x00d00 ;
: status     0x00e00 ;
: Nu<T       0x00f00 ;

: T->N       0x00010 |or| ;
: T->R       0x00020 |or| ;
: N->[T]     0x00030 |or| ;
: N->io[T]   0x00040 |or| ;
: _IORD_     0x00050 |or| ;
: RET        0x00080 |or| ;

: d-1        0x00003 |or| ;
: d+1        0x00001 |or| ;
: r-1        0x0000c |or| ;
: r-2        0x00008 |or| ;
: r+1        0x00004 |or| ;

: imm                0x00000 |or| tcode, ;
: alu                0x16000 |or| tcode, ;
: ubranch            0x10000 |or| tcode, ;   \ unconditional absolute branch
: ubranchr   |s-12b| 0x18000 |or| tcode, ;   \ unconditional relative branch
: 0branch            0x12000 |or| tcode, ;   \ conditional absolute branch
: 0branchr   |s-12b| 0x1A000 |or| tcode, ;   \ conditional relative branch
: scall              0x14000 |or| tcode, ;   \ subroutine call absolute
: scallr     |s-12b| 0x1C000 |or| tcode, ;   \ subroutine call relative
: @mem               0x20000      tcode, ;   \ fetch


:: noop      T                       alu ;
:: +         T+N                 d-1 alu ;
:: -         N-T                 d-1 alu ;
:: xor       T^N                 d-1 alu ;
:: and       T&N                 d-1 alu ;
:: andRET    T&N   RET           d-1 alu ;
:: or        T|N                 d-1 alu ;
:: orRET     T|N   RET           d-1 alu ;
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
:: @                                @mem ;
:: io@       io[T]     _IORD_        alu ;
:: !         
             T     N->[T]        d-1 alu
             N                   d-1 alu ;
:: io!       
             T     N->io[T]      d-1 alu
             N                   d-1 alu ;
:: io!RET    
             T     N->io[T]      d-1 alu
             N     RET           d-1 alu ;
:: 2/        T2/                     alu ;
:: 2*        T2*                     alu ;
:: depth     status T->N         d+1 alu ;
:: exit      T     RET           r-1 alu ;
:: pexit     N     RET       d-1 r-1 alu ;  \ pop return
:: hack      T      N->io[T]         alu ;  \ io write leave address and data on stack
:: !ad       N      N->[T]   d-1     alu ;  \ mem write leave address on stack
:: io!ad     N      N->io[T] d-1     alu ;  \ io write leave address on stack

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
