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

        if line == '':
            return False

        tokens = line.split()

    token = tokens.pop(0)

    return True 

def add_word(name):
    """
    Adds word to the forth dictionary
    Args:
        name: name of word as string
    Returns:
        None
    """
    
    global dictionary
    
    

    return

def pushd(params):
    """
    Pushes the values of params onto the data stack
    Args:
        params: tuple of integers to push onto the data stack
    Returns:
        None
    """

    global dstack

    dstack += params

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
        #exref = word['code']
        if word['params'] is None:
            exref()
        else:
            exref(word['params'])

    return

def or_func():
    """
    Or operation on the data stack.
    Pops off two numbers from the data stack and performs a bitwise OR
    and pushes the result onto the data stack.
    Args:
        None
    Return:
        Boolean for success or stack underflow
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
    
def add_func():
    """
    Adds two elements on stack
    Pops off two numbers from the data stack and performs addition
    and pushes the result onto the data stack.
    Args:
        None
    Return:
        Boolean for success or stack underflow
    """
    
    global dstack
    
    dstack[-2] = dstack[-1] + dstack[-2]
    popd()
    
    return
    
def duplicate_func():
    """
    Duplicates the top stack item.
    Takes the top stack item duplicates, and pushes it to stack
    Args:
        None
    Return:
        Boolean for success or stack underflow
    """
    
    global dstack
    
    num = dstack[-1]
    
    pushd([num])
    
    return
    
def drop_func():
    """
    Discards the top stack item.
    Takes the top stack item and discards it
    Args:
        None
    Return:
        Boolean for success or stack underflow
    """

    popd()

    return
    
def swap_func():
    """
    Swaps the order of the top two stack items.
    Create a temporary varible, Store the top stack item
    Make the top stack item the second stack item
    The second stack item is the new temp variable
    Args:
        None
    Return:
        Boolean for success or stack underflow
    """

    global dstack
    
    x = dstack[-1]
    
    dstack[-1] = dstack[-2]
    dstack[-2] = x

    return
    
def over_func():
    """
    Copies the second stack item and pushes it to the top
    Push the second stack item
    Args:
        None
    Return:
        Boolean for success or stack underflow
    """

    global dstack
    
    pushd([dstack[-2]])
    
    return
    
def rotate_func():
    """
    Rotates the top three stack items to bring the third one on top
    Store the values in temp vars, pop the values off, push in the correct order
    Args:
        None
    Return:
        Boolean for success or stack underflow
    """

    global dstack
    
    x = dstack[-3]
    y = dstack[-2]
    z = dstack[-1]
    
    popd()
    popd()
    popd()
    
    pushd([y])
    pushd([z])
    pushd([x])
    
    return
    
def negative_rotate_func():
    """
    Rotates the top three stack items to bring the top one to the third
    Store the values in temp vars, pop the values off, push in the correct order
    Args:
        None
    Return:
        Boolean for success or stack underflow
    """

    global dstack
    
    x = dstack[-3]
    y = dstack[-2]
    z = dstack[-1]
    
    popd()
    popd()
    popd()
    
    pushd([z])
    pushd([x])
    pushd([y])
    
    return

def two_duplicate_func():
    """
    Duplicates the top stack item.
    Takes the top stack item duplicates, and pushes it to stack
    Args:
        None
    Return:
        Boolean for success or stack underflow
    """

    global dstack

    x = dstack[-1]
    y = dstack[-2]

    pushd([y])
    pushd([x])

    return
    
def two_drop_func():
    """
    Destroy the top two stack items
    Pops the items from stack
        Args:
        None
    Return:
        Boolean for success or stack underflow
    """
    
    popd()
    popd()
    
    return
    
def two_swap_func():
    """
    Swaps the order of the top four stack items.
    Create a temporary varibles, Store the four stack variables
    Push the stack back on in the desired order
    Args:
        None
    Return:
        Boolean for success or stack underflow
    """

    global dstack

    x = dstack[-3]
    y = dstack[-4]
    z = dstack[-2]
    w = dstack[-1]

    popd()
    popd()
    popd()
    popd()

    pushd([z])
    pushd([w])
    pushd([y])
    pushd([x])

    return
    
def two_over_func():
    """
    Copies the second pair of stack items to the top
    Take temp vars, store the second pair stack values
    push them on in order
    Args:
        None
    Return:
        Boolean for success or stack underflow
    """

    global dstack

    x = dstack[-3]
    y = dstack[-4]
    pushd([y])
    pushd([x])

    return
    
def carriage_return_func():
    """
    Prints a new line
    Args:
        None
    Return:
        Boolean for success or stack underflow
    """
    
    print('\n')

    return
    
def nothing_func():
    """
    Does Nothing :)
    Args:
        Nothing
    Return:
        Nothing
    """
    
    return
    


# dictionary.append({'name' : ':', 'code' : (add_word), 'params' : None})
dictionary.append({'name' : 'or', 'code' : (or_func, nothing_func), 'params' : None})
# dictionary.append({'name' : '."', {'code' : []})
dictionary.append({'name' : '.s', 'code' : (print_dstack, nothing_func), 'params' : None})
dictionary.append({'name' : '+', 'code' : (add_func, nothing_func), 'params' : None})
dictionary.append({'name' : 'DUP', 'code' : (duplicate_func, nothing_func), 'params' : None})
dictionary.append({'name' : 'DROP', 'code' : (drop_func, nothing_func), 'params' : None})
dictionary.append({'name' : 'SWAP', 'code' : (swap_func, nothing_func), 'params' : None})
dictionary.append({'name' : 'OVER', 'code' : (over_func, nothing_func), 'params' : None})
dictionary.append({'name' : 'ROT', 'code' : (rotate_func, nothing_func), 'params' : None})
dictionary.append({'name' : '-ROT', 'code' : (negative_rotate_func, nothing_func), 'params' : None})
dictionary.append({'name' : '2DUP', 'code' : (two_duplicate_func, nothing_func), 'params' : None})
dictionary.append({'name' : '2DROP', 'code' : (two_drop_func, nothing_func), 'params' : None})
dictionary.append({'name' : '2SWAP', 'code' : (two_swap_func, nothing_func), 'params' : None})
dictionary.append({'name' : '2OVER', 'code' : (two_over_func, nothing_func), 'params' : None})
dictionary.append({'name' : 'CR', 'code' : (carriage_return_func, nothing_func), 'params' : None})
dictionary.append({'name' : '4DROP', 'code' :}
#dictionary.append({'name' : 'ADD2', 'code' : (pushd(2) , add_func), 'params' : None})

while get_token():
    #print(token)
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

    num = int(token)
    pushd([num])
