#!/usr/bin/perl -w
use Getopt::Std;
use feature "switch";
use feature "state";

#   Program to read a Forth basewords file that has
#   Forth code to generate j1a assembly instructions
#   This program reads the Forth code and generates
#   a file with perl subroutines for each Forth word
#
#   Assumptions :
#    - The file can have ONLY word definitions (: or ::)

 my $invokemessage = '

     to invoke :
GenForthSubs.pl -b basewordsFname -a asmInFileName {-o hexOutFileName} {-d} {-h} {-l LogFileName}

     where :
 -b basewordsFname    Forth basewords filename {required]
 -a asmInFileName     j1a input asm filename {required]
 -o hexOutFileName    j1a output hex filename [default to j1a.hex]
 -l LogFileName       Output Log Filename [default to STDOUT]
 -d                   prints debug info to LogFileName
 -h                   prints this message

';


my ($inFile,$ForthFileName,$outHEXfile,$hexOutFileName,$logfile,$LogFileName,$debug);
my ($asmInFileName,$inFileName);
my ($i,$j,$k);

my $line;          # current input line from inFile
my $lnum;          # current input line number
my $cmnt;          # '\' comment on current asm file input line

my $TOKEN;         # the current Token
my @Tokens;        # Array of tokens on current line
my $TokIndx;       # Index of current token

my $Ntyp = "";     # Number Type of immediate values [0d, 0x, (''=hex)]
my $Num  = 0;      # decimal value of immediate number
my @Stk;           # Data Stack used to make instruction codes


######################################
#      dictionary data structure     #
######################################

#   %dict{word}   =  [ @ExecutionTuple {,@ExecutionTuple}*  ]
#        @ExecutionTuple  =  [ \&FunctionRef, [ parameters] ]

my %dict;          # word dictionary - hash of defined words/subroutines
            # Forth word             execution functions
%dict  =  (
              ':'            => [  [ \&AddWord, [ ] ]         ],
              ';'            => [  [ \&notImplemented, [ ] ]  ],
              '::'           => [  [ \&AddWord, [ ] ]  ],
              '('            => [  [ \&LparenComment, [ ] ]   ],
              '{'            => [  [ \&LbraceComment, [ ] ]   ],
              '\\'           => [  [ \&BslashComment, [ ] ]   ],
              'h#'           => [  [ \&notImplemented, [ ] ]  ],
              'tcode,'       => [  [ \&writecode, [ ] ]       ],
              '|or|'         => [  [ \&orFunction, [ ] ]    ],
);


my %OPdict;          # word dictionary - hash of defined words/subroutines
            # pseudo OP             execution functions
%OPdict =  (
              ':'            => [  [ \&AddWord, [ ] ]         ],
              ';'            => [  [ \&notImplemented, [ ] ]  ],
              '::'           => [  [ \&AddWord, [ ] ]  ],
              '('            => [  [ \&LparenComment, [ ] ]   ],
              '{'            => [  [ \&LbraceComment, [ ] ]   ],
              '\\'           => [  [ \&BslashComment, [ ] ]   ],
              'h#'           => [  [ \&notImplemented, [ ] ]  ],
              'tcode,'       => [  [ \&writecode, [ ] ]       ],
              '|or|'         => [  [ \&orFunction, [ ] ]    ],
);


######################################
#             subroutines            #
######################################


#---------------------------------#
#           GetToken              #
#  get next token in @Tokens      #
#  if @Tokens is empty read new   #
#  line and split into @Tokens    #
#  write token to $TOKEN          #
#  return 1 if token written      #
#  return 0 if no token(file done)#
#---------------------------------#
sub GetToken {
  my $ln;    # copy of $line
  if ( exists($Tokens[0]) ) {
    $TOKEN  =  shift(@Tokens);
    return 1;                    # found token
  }
  else {
  
    while ( !exists($Tokens[0]) ) {  # flush blank lines
      if ($line = <$inFile>) {  # read next line
        $lnum++;

        $line  =~ s/\x0D?\x0A/\n/;   # allow files to have LF or CRLF
        chomp $line;
        
        if ($debug) {
          print $logfile "\nRead next line b<$inFileName> l<$lnum>\n line> $line\n";
        }

                ### split tokens on $line into @Tokens array
        $ln      =  $line;
        $ln      =~ s/^\s*//;    # remove leading whitespace on line
        @Tokens  =  split /\s+/, $ln;
        
        if ($debug) {
          for my $tok ( @Tokens ) { print $logfile "{$tok}  " }
          print $logfile "\n";
        }
      }  #  end read next line
      else {  # file EOF - punt!
        $TOKEN = "";
        return 0;
      }
    }  # end flush blank lines
    
    $TOKEN  =  shift(@Tokens);   # write token to $TOKEN
    return 1;                    # found token
  }
  
}  # end GetToken

#---------------------------------#
#         AddWord                 #
#  parses @Tokens as a new word   #
#  - prints a warning if word was #
#    previously defined           #
#  - adds the word to %dict       #
#---------------------------------#
sub AddWord {
  my $word;
  
  if ( &GetToken ) {
    $word  =  $TOKEN;
    if ($debug) { print $logfile "<< AddWord <$word> >>\n" }
    
    if ( exists($dict{$word}) ) {   # check for TOKEN defined in dictionary
      print $logfile "  << AddWord<$word> previously defined\n";
    }
    else {
          # if new word write to %dict with value = empty execution array
      $dict{$word}  =  [ ];
    }
  }
  else {
    print $logfile "*** EOF found when expecting word after <:> in AddWord\n";
    return 0;    # fail return
  }
  
  while ( &GetToken ) {
    if ($debug) {
      print $logfile "  >> TOKEN<$TOKEN>\n";
    }
    
    given ($TOKEN) {
    
      when ($TOKEN eq ';') {
        return 1;
      }
    
      when  ($TOKEN =~  /^(\\|\(|\{)$/ ) {
        &Execute($TOKEN);                          # execute comment type
      }
    
      when  ( &validNum($TOKEN) ) { # number (0xHHHH/DDDD)
        push @{$dict{$word}}, ( [ \&pushStk, [ $Num ] ] );
      }
      
      default {
        unless ( exists($dict{$TOKEN}) ) {
          print $logfile "    $TOKEN not found in dictionary\n";
        }
        else {
          if ($debug) { print $logfile "    $TOKEN in dictionary\n" }
          push @{$dict{$word}}, ( [ \&Execute, [ $TOKEN ] ] );
        }
      }
      
    }  # end given
  }  # end while GetToken
  
        # EOF found before finding ";" 
  print $logfile "*** EOF found before finding <;> AddWord<$word>\n";
  return 0;    # fail return
  
}  # end AddWord


#---------------------------------#
#         Execute(word)           #
# calls all functions in the word #
#---------------------------------#
sub Execute {
  my $word  = shift @_;
  my $eXfuncRef;       # reference to Execution function
  
  if ($debug) {
    print $logfile "  << Execute($word) >>\n";
  }
  
  for my $tref ( @{$dict{$word}} ) {
    @_  =  @{$tref->[1]};        # array of parameters
    $eXfuncRef  =  $tref->[0];  # execution function reference
    unless ( &{$eXfuncRef} ) {
      print $logfile "*** encountered error in Execute<$TOKEN>\n";
      return 0;
    }
  }
  return 1;
}  # end Execute


#---------------------------------#
#         LparenComment           #
#  consumes tokens from @Tokens   #
#  until a token that ends with   #
#  ')' is found                   #
#---------------------------------#
sub LparenComment {
  if ($debug) {
    print $logfile "  << LparenComment >>\n";
  }
  
  while ( &GetToken ) {
    if ( $TOKEN =~ m/^.*\)$/ ) {
      return 1;
    }
  }
  print $logfile "*** hit EOF in LparenComment\n";
  return 0;      # encountered EOF before )
}  # end LparenComment


#---------------------------------#
#         LbraceComment           #
#  consumes tokens from @Tokens   #
#  until a token that ends with   #
#  '}' is found                   #
#---------------------------------#
sub LbraceComment {
  if ($debug) {
    print $logfile "  << LbraceComment >>\n";
  }
  
  while ( &GetToken ) {
    if ( $TOKEN =~ m/^.*\}$/ ) {
      return 1;
    }
  }
  print $logfile "*** hit EOF in LbraceComment\n";
  return 0;      # encountered EOF before }
}  # end LbraceComment


#---------------------------------#
#         BslashComment           #
#  consumes remaining tokens in   #
#  @Tokens                        #
#---------------------------------#
sub BslashComment {
  if ($debug) {
    print $logfile "  << BslashComment >>\n";
  }
     # consume all remaining tokens on line
  @Tokens  =  ();
  return 1;
}  # end BslashComment


#---------------------------------#
#         writecode               #
#  writes current instruction to  #
#  output file                    #
#---------------------------------#
sub writecode {
  state $addr = 0;
  my ($hnum,$haddr);
  $haddr  =  sprintf("%4.4X", $addr++);
  $hnum   =  sprintf("%4.4X", $Stk[0]);
  
  if ($debug) {
    print $logfile "  << writecode  TOS<$hnum> >>\n";
  }
  
  shift(@Stk);
  print $outHEXfile "$hnum     // $haddr $line\n";
      #  clear line so that it will not appear as a comment
      #  on multi cell forth primitive words in hex output
  $line  =  "";
  return 1;
}  # end writecode


#---------------------------------#
#         printdict               #
# writes keys of %dict to logfile #
#---------------------------------#
sub printdict {
  
  print $logfile "  dictionary keys :\n";
  for my $word ( sort keys(%dict) ) {
    print $logfile "    $word\n";
  }
  print $logfile "----- end dictionary keys -----\n";
  return 1;
}  # end printdict


#---------------------------------#
#         printStk                #
# writes values in Stk to logfile #
#---------------------------------#
sub printStk {
  my $hnum;
  print $logfile "  Stk :";
  for my $num ( @Stk ) {
    $hnum  =  sprintf("%4.4X", $num);
    print $logfile "  $hnum";
  }
  print $logfile "\n";
  return 1;
}  # end printStk


#---------------------------------#
#         orFunction              #
# implement or stack function     #
# return 0 if stack underflow     #
#---------------------------------#
sub orFunction {
  
  unless ( exists($Stk[0]) && exists($Stk[1]) ) {
    print "*** Stack underflow in or\n";
    return 0;
  }
  else {
    $Stk[1] = $Stk[0] | $Stk[1]; shift(@Stk);
    if ($debug) { &printStk }
    return 1;
  }
}  # end orFunction


#---------------------------------#
#          pushStk(int)           #
# push int onto Stk               #
#---------------------------------#
sub pushStk {
  my $int  = shift @_;
  
  unshift(@Stk, $int);   # push $int onto @Stk
  if ($debug) { &printStk }
  
  return 1;
  
}  # end pushStk


#---------------------------------#
#          validNum(word)         #
# check if word is a number       #
# if true write Ntyp and Num      #
# else fail return                #
#---------------------------------#
sub validNum {
  my $word  = shift @_;
  if ($debug) {
    print $logfile "  << validNum($word) >>\n";
  }
  $Ntyp  =  "";
  if  ($word =~  /^(?i)(0x|)([0-9a-f]+)$/ ) { # number (0xHHHH/DDDD)
    $Ntyp  =  $1;
    $Num   =  $2;
        # if number is hex convert it to decimal
    if ( $Ntyp =~ m/^0x$/i   ) {
      $Num = hex($Num);
    }
    elsif ( $Num !~ m/^[0-9]+$/ ) {
      return 0;
    }
    
    if ($debug) {
       print $logfile "    << found number t($Ntyp) n($Num)\n";
    }
    return 1;
  }
     # word was not a valid hex or decimal number
  return 0;
}  # end validNum


#---------------------------------#
#    notImplemented function      #
#---------------------------------#
sub notImplemented {
  
  print "*** Function Not Implemented\n";
  return 1;
  
}  # end notImplemented


#########################
#  command line options #
#########################

#command line options
$opt_h=""; # help
$opt_b=""; # Forth basewords Input File
$opt_a=""; # j1a input asm filename
$opt_o=""; # Output File
$opt_l=""; # Log File
$opt_d=""; # print debug info

getopts('hdb:a:l:o:');

if ($opt_l) { # open logfile if specified
  $LogFileName = $opt_l;
  open ($logfile, ">", $LogFileName)  or die  "$LogFileName : $! \n";
}
else  { # otherwise send logfile info to STDOUT
  $logfile = "STDOUT";
}

if ($opt_b) {
  $ForthFileName = $opt_b;
     # open Forth basewords input File
  open ($inFile, "<", $ForthFileName)  or die  "$ForthFileName : $! \n";
  print $logfile " >>OPENING File <$ForthFileName>\n";
  $inFileName  =  $ForthFileName;
}
else { print $invokemessage; exit(1);}

if ($opt_a) {
  $asmInFileName = $opt_a;
}
else { print $invokemessage; exit(1);}

if ($opt_o) { # open output if specified
  $hexOutFileName = $opt_o;
}
else  { # otherwise write hex output to j1a.hex
  $hexOutFileName = "j1a.hex";
}
     # open Perl output File
open ($outPERLfile, ">", $hexOutFileName)  or die  "$hexOutFileName : $! \n";


if ($opt_d) { $debug = 1 }
if ($opt_h) {print $invokemessage; exit(1);}


#########################
#    program start      #
#########################

if ($debug) { &printdict }

     # read forth basewords file and
     # add them to the dictionary %dict

$lnum    =  0;
$TOKEN   =  "";   # initialize $TOKEN
@Tokens  =  ();   # initialize @Tokens
PARSEBASETOKENS: while (&GetToken) {
    
  if ( exists($dict{$TOKEN}) ) {   # check for TOKEN defined in dictionary
        #print $logfile ">>> TOKEN<$TOKEN>\n";
    &Execute($TOKEN);
  }
  else {
    print $logfile ">>> Can not execute <$TOKEN> not in dictionary\n";
  }
  
} # end PARSEBASETOKENS

if ($debug) { &printdict }
print "\n-- Done GenForthSubs\n\n";
close $inFile;   #  close Forth basewords input file



    # read the asm source file and
    # create the asm hex output file

     # open asm input File
  open ($inFile, "<", $asmInFileName)  or die  "$asmInFileName : $! \n";
  print $logfile " >>OPENING File <$asmInFileName>\n";
  
     # open asm hex output File
  open ($outHEXfile, ">", $hexOutFileName)  or die  "$hexOutFileName : $! \n";
  print $logfile " >>OPENING File <$hexOutFileName>\n";
  
  $inFileName  =  $asmInFileName;  # GetToken reads from asm input file

 $lnum    =  0;
 $TOKEN   =  "";   # initialize $TOKEN
 @Tokens  =  ();   # initialize @Tokens
 PARSEASMTOKENS: while (&GetToken) {

  if ( exists($dict{$TOKEN}) ) {   # check for TOKEN defined in dictionary
    if ($debug) { print $logfile ">>> TOKEN<$TOKEN>\n" }
    
    &Execute($TOKEN);
  }
  elsif  ( &validNum($TOKEN) ) { #  is number (0x/0d/hhhh) ?
    &pushStk($Num);
  }
  else {
    print $logfile ">>> Can not execute <$TOKEN> not in dictionary\n";
  }
  #
} # end PARSEASMTOKENS

close $inFile;
unless ($outPERLfile eq "STDOUT") { close $outPERLfile }
unless ($logfile eq "STDOUT") { close $logfile }
exit;
