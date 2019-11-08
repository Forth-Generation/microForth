#!/usr/bin/perl -w
use Getopt::Std;
use feature "switch";

use strict "refs";

my ($inFile,$ForthFileName,$outHEXfile,$hexOutFileName,$logfile,$LogFileName,$debug);
my ($asmInFileName,$inFileName);
my ($i,$j,$k);

my $line;          # current input line from inFile
my $lnum;          # current input line number

my $TOKEN;         # the current Token
my @Tokens;        # Array of tokens on current line
my $TokIndx;       # Index of current token

my $Ntyp = "dec";  # Number Type - used to convert immediate values (dec, hex)
my @Stk  = ();     # Data Stack used to make instruction codes

$aref  =  [  [ 1, [ 3 ] ]  ];
$i     =  $aref->[0][1][0];

print "**1  i<$i>\n";


######################################
#      dictionary data structure     #
######################################

%dict;          # word dictionary - hash of defined words/subroutines
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
              'one'          => [  [ \&pushStk, [ 1 ] ]       ],
              'two'          => [  [ \&pushStk, [ 2 ] ]       ],
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
        $line    =~ s/^\s*//;    # remove leading whitespace on line
        @Tokens  =  split /\s+/, $line;
        
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
  my ($Ntyp, $num);
  
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
    
      when  ($TOKEN =~  /^(?i)(0x|0d|)([0-9a-f]+)$/ ) { # number (0x/0d/hhhh)
        $Ntyp  =  $1;
        $Num   =  $2;
            # if number is hex convert it to decimal
        unless ( $Ntyp =~ m/^0D$/i ) { $Num = hex($Num) }
        print $logfile "    << found number t($Ntyp) n($Num)\n";
        push @{$dict{$word}}, ( [ \&pushStk, [ $Num ] ] );
      }
      
      default {
        unless ( exists($dict{$TOKEN}) ) {
          print $logfile "    $TOKEN not found in dictionary\n";
        }
        else {
          print $logfile "    $TOKEN in dictionary\n";
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
  
  $aref  =  $dict{$word};
  $bref  =  scalar(@{$aref});
  # $i     =  $bref->[1][0];
  $i     =  $bref;
  print "** w<$word>  aref<$aref>  i<$i>\n";
  
  for my $tref ( @{$dict{$word}} ) {
    $i  =  scalar( @{$tref->[1]} );  # parameter list size
print "**2  i<$i>\n";
    print $logfile "-- parameter list size<$i>\n";
    @_  =  @{$tref->[1]};        # array of parameters
    $eXfuncRef  =  $tref->[0];  # execution function reference
    unless ( &{$eXfuncRef} ) {
      print $logfile "*** encountered EOF in Execute<$TOKEN>\n";
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
  my $hnum;
  $hnum  =  sprintf("%4.4X", $Stk[0]);
  if ($debug) {
    print $logfile "  << writecode  TOS<$hnum> >>\n";
    shift(@Stk);
  }
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
    if ($debug) { \printStk }
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
  if ($debug) { \printStk }
  
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
  if  ($word =~  /^(?i)(0x|0d|)([0-9a-f]+)$/ ) { # number (0x/0d/hhhh)
    $Ntyp  =  $1;
    $Num   =  $2;
        # if number is hex convert it to decimal
    unless ( $Ntyp =~ m/^0D$/i ) { $Num = hex($Num) }
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
#    program start      #
#########################

$debug  =  1;
$LogFileName = "test.log";
$inFileName  =  "prim_test2.fs";
open ($logfile, ">", $LogFileName)  or die  "$LogFileName : $! \n";
open ($inFile, "<", $inFileName)  or die  "$inFileName : $! \n";

if ($debug) { &printdict }

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

print "\n-- Done parsing $inFileName\n\n";
close $inFile;   #  close Forth basewords input file
print $logfile "\n";


&Execute("one");    # push 1 onto Stk
&Execute("two");    # push 2 onto Stk
&Execute("|or|");   # execute or function

&pushStk(0x00AA);
&Execute("imm");     # execute or function


print "\n-- Done test\n\n";

unless ($logfile eq "STDOUT") { close $logfile }
exit;