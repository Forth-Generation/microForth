import re
import sys

dictionary = [] 
dstack = []
rstack = []

tokens = []
token = '' 

f = open(sys.argv[1])

def get_token():
    """
    Fills tokens list with tokens

    Args:
        None
    Returns:
        False if end of file,
        True otherwise
    """

    global tokens
    global token

    while not tokens:
        line = f.readline()

        # if reached EOF  
        if line == '':
            return False

        tokens = line.split()

    token = tokens.pop(0)

    return True 

def add_word():
    """
    Adds word to the forth dictionary
 
    Args:
        name: name of word as string
    Returns:
        None
    """
 
    global tokens
    global token

    codelist = []

    token = tokens.pop(0)
    name = token
    print(type(name))
    
    while tokens[0] != ';':
        token = tokens.pop(0)
        for i in reversed(range(len(dictionary))):
            if dictionary[i]['name'] == token:
                codelist.append(dictionary[i]['code'])

    code = []
    for tup in codelist:
        code += list(tup)     
    # print(tuple(L2))
    dictionary.append({'name' : name, 'code': tuple(code), 'params': None})

    tokens = []

def pushd():
    """
    Pushes a number onto the data stack

    Args:
        params: tuple of integers to push onto the data stack
    Returns:
        None
    """

    global dstack
    global token

    dstack.append(token)

    return

def popd():
    """
    Pops a number off the data stack

    Args:
        None
    Returns:
        The integer popped off the data stack. If the data stack is empty it will return None. 
    """

    global dstack

    dstack.pop()

    return

def pushr():
    """
    Pops a number off of data stack and push onto the return stack

    Args:
        None
    Returns:
        None
    """

    global rstack
    global token

    rstack.append(dstack[-1])
    dstack.pop()

    print("rstack: ", rstack)
    

    return

def popr():
    """
    Pops a number off the return stack

    Args:
        None
    Returns:
        The integer popped off the return stack. If the return stack is empty it will return None. 
    """

    global rstack

    dstack.append(rstack.pop())

    return

def execute(i):
    """
    Grabs the index of the token in the dictionary, gets the dictionary word, then executes
    
    Args:
        i: index of dictionary
    Return:
        Boolean for success or failure
    """
   
    global dictionary

    word = dictionary[i]

    for exref in word['code']:
        # if word['params'] is None:
        if isinstance(exref, int):
            dstack.append(exref)
        else:
            exref()
        # else:
            
            # exref(word['params'])

    return

def or_func():
    """
    Or operation on the data stack.
    Pops off two numbers from the data stack and performs a bitwise OR
    and pushes the result onto the data stack.

    Args:
        None
    Return:
        Boolean for success or stack overflow   
    """

    global dstack

    dstack[-2] = dstack[-1] | dstack[-2]
    popd()

    return

def print_dstack():
    """
    Prints data stack

    Args:
        None
    Return:
        None
    """

    global dstack

    print(dstack)

    return

def dadd():
    global dstack
    a = dstack.pop()
    b = dstack.pop()
    dstack.append(a+b)
    
    writeOut('T->N|d-1|alu')
    

    return

def writeOut(word):
    """ Writes out Assembly Code
    """
    
    f = open('output.asm','a')
    f.write(word)
    f.close

# dictionary.append({'name' : ':', 'code' : (add_word), 'params' : None})
dictionary.append({'name' : 'or', 'code' : (or_func,), 'params' : None})
# dictionary.append({'name' : '."', {'code' : []})
dictionary.append({'name' : '.s', 'code' : (print_dstack,), 'params' : None})
dictionary.append({'name' : '>r', 'code' : (pushr, ), 'params' : None})
dictionary.append({'name' : 'r>', 'code' : (popr, ), 'params' : None})
dictionary.append({'name' : '+' , 'code' : (dadd, ), 'params' : None})
dictionary.append({'name' : 'add2' , 'code' : (2, dadd), 'params' : None})
dictionary.append({'name' : 'swap', 'code' : (pushr, pushr, popr, popr), 'params' : None})
dictionary.append({'name' : 'swap', 'code' : (pushr, pushr, popr, popr), 'params' : None})
dictionary.append({'name' : ':', 'code' : (add_word,), 'params' : None})

while get_token():
    found = False
    for i in reversed(range(len(dictionary))):
        if dictionary[i]['name'] == token:
            execute(i)
            found = True
            break
    if found:
        print(token, "Found")
        continue
    else:
        try:
            int(token)
            print(token, "Found num")
        except:
            print(token, "not found")
            continue

    token = int(token)
    pushd() #[num])
