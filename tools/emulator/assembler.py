import re
import sys

dictionary = [] 
dstack = []
rstack = []

tokens = []
token = '' 

#f = open('forthwordstest.fs')

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

    #token = tokens.pop(0)

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
    found = False

    codelist = []
    paramslist = []

    token = tokens.pop(0)
    name = token
    #print('Name: ', name)
    if len(tokens) == 0 :
            get_token()
            #print(tokens)
    #print("Token: " + token)
    #print("Tokens: " + tokens[0])
    
    while tokens[0] != ';':
        #print(tokens)
        #print(token)
        token = tokens.pop(0)
        #print(tokens)
        if '0x' in token:
            paramslist.append(token)
        else:
            #print('Token: ', token)
            for i in reversed(range(len(dictionary))):
                if dictionary[i]['name'] == token:
                    found = True
                    a = dictionary[i]['code']
                    b = dictionary[i]['params']
                    list(a)
                    if b is not None:
                        list(b)
                    #print(type(a))
                    for i in a:
                        codelist.append(i)
                    if b is None:
                        break
                    else:
                        for i in b:
                            paramslist.append(i)
            if found == False :
                #print("I have Appended")
                codelist.append(token)
            found = False
        if len(tokens) == 0 :
            get_token()
            print(tokens)

    code = []
    #for tup in codelist:
        #code += list(tup)     
    # print(tuple(L2))
    #dictionary.append({'name' : name, 'code': tuple(code), 'params': None})
    #print(codelist)
    dictionary.append({'name' : name, 'code' : tuple(codelist), 'params': tuple(paramslist) })

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

def pushda(x):
    global dstack

    dstack.append(x)

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
    #print(word['params'])
    if word['params']:
        for i in range(len(word['params'])):
            #print('I MADE IT HERE')
            pushda(word['params'][i])
            print(word['params'][i])

    for exref in word['code']:
        #print(exref)
        #if word['params'] is None:
        if isinstance(exref, int):
            dstack.append(exref)
            #print(dstack)
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
    print('Length: ', len(word))
    f.close

def printOut():
    global dstack
    a = int(dstack.pop(0),16)
    a = hex(a)
    f = open('Test.hex', 'a')
    if len(a) < 6:
        c = 6 - len(a)
        a = '0'*c + a
    f.write( a.replace('0x', '') + '\n')
    f.close

def orFunc():
    global dstack

    print(dstack)
    a = int(dstack.pop(0), 16) | int(dstack.pop(0), 16)
    dstack.insert(0,str(hex(a)))
    
    #print(hex(a))

    return


# dictionary.append({'name' : ':', 'code' : (add_word), 'params' : None})
#dictionary.append({'name' : 'or', 'code' : (or_func,), 'params' : None})
# dictionary.append({'name' : '."', {'code' : []})
#dictionary.append({'name' : '.s', 'code' : (print_dstack,), 'params' : None})
#dictionary.append({'name' : '>r', 'code' : (pushr, ), 'params' : None})
#dictionary.append({'name' : 'r>', 'code' : (popr, ), 'params' : None})
#dictionary.append({'name' : '+' , 'code' : (dadd, ), 'params' : None})
#dictionary.append({'name' : 'add2' , 'code' : (2, dadd), 'params' : None})
#dictionary.append({'name' : 'swap', 'code' : (pushr, pushr, popr, popr), 'params' : None})
#dictionary.append({'name' : 'swap', 'code' : (pushr, pushr, popr, popr), 'params' : None})
dictionary.append({'name' : ':', 'code' : (add_word,), 'params' : None})
dictionary.append({'name' : 'tcode,', 'code' : (printOut,), 'params': None })
dictionary.append({'name' : '|or|', 'code': (orFunc, ), 'params' : None})


fileList = ['forthwordstest.fs']
for i in range(len(sys.argv)):
    fileList.append(sys.argv[i])
fileList.pop(1)
for i in range(len(fileList)):
    f = open(fileList[i])

    while get_token():
        found = False
        token = tokens.pop(0)
        print(token)
        if '\\' in token:
            tokens = []
        else:
            for i in reversed(range(len(dictionary))):
                if dictionary[i]['name'] == token:
                    execute(i)
                    found = True
                    break
            if found:
                #print(token, "Found")
                continue
            else:
                try:
                    if '0x' in token:
                        dstack.insert(0, token)
                    #print(token, "Found num")
                except:
                    #print(token, "not found")
                    continue

'''
f = open(sys.argv[1])
while get_token():
    found = False
    token = tokens.pop(0)
    print(token)
    if '\\' in token:
            tokens = []
    else:
        for i in reversed(range(len(dictionary))):
            if dictionary[i]['name'] == token:
                execute(i)
                found = True
                break
        if found:
            #print(token, "Found")
            continue
        else:
            try:
                if '0x' in token:
                    dstack.insert(0, token)
                #print(token, "Found num")
            except:
                #print(token, "not found")
                continue

    #token = int(token)
    #pushd() #[num])
#print(dictionary)
#print(dstack)
'''
