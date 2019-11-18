import re
import sys

dictionary = [] 
dstack = []
rstack = []

tokens = []
token = '' 
params = []

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

# def add_word():
#     """
#     Adds word to the forth dictionary
# 
#     Args:
#         name: name of word as string
#     Returns:
#         None
#     """
# 
#     global tokens
#     global token
#     global params
#     print("Tokens", tokens)
# 
#     word = {}
# 
#     word['name'] = token
# 
#     code = []
#     params = []
#     while not token:
#         token = tokens.pop(0)
#         found = False
#         for i in reversed(range(len(dictionary))):
#             if dictionary[i]['name'] == token:
#                 code.append(token)
#                 found = True
#                 break
#         if found:
#             print(token, "Added to code")
#             continue
#         else:
#             try:
#                 int(token)
#                 print(token, "Added num")
#             except:
#                 print(token, "not found")
#                 continue
# 
#     num = int(token)
#     code.append(pushd)
#     params.append(
# 
#     print("Tokens", tokens)
#         #tokens.pop(0)
#     
#     return

def pushd():
    """
    Pushes the values of params onto the data stack

    Args:
        params: tuple of integers to push onto the data stack
    Returns:
        None
    """

    global dstack
    global params

    dstack += params

    params = []

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

# dictionary.append({'name' : ':', 'code' : (add_word), 'params' : None})
dictionary.append({'name' : 'or', 'code' : (or_func,), 'params' : None})
# dictionary.append({'name' : '."', {'code' : []})
dictionary.append({'name' : '.s', 'code' : (print_dstack,), 'params' : None})

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

    num = int(token)
    params = [num]
    pushd() #[num])
