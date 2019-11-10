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

    return

def pushd(num):
    """
    Pushes a number onto the data stack

    Args:
        num: integer to push onto the data stack
    Returns:
        None
    """

    global dstack

    dstack.append(num)
    
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

def execute(name):
    """
    Grabs the name and finds the dictionary word then executes
    
    Args:
        name: name of word as string
    Return:
        Boolean for success or failure
    """
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

    return

while get_token():
    print(token)
