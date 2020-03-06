class Word:
    
    def __init__(self, name):
        self.previous = None
        self.count = len(name)
        self.name = name
        self.code = []
        self.params = []

class Diction:

    def __init__(self):
        self.head = None

    def printDict(self):
        temp = self.head
        while(temp):
            print (temp.name)
            print (temp.count)
            temp = temp.previous
            
    def addWord(self, newNode):
        newWord = Word(newNode)
        if self.head is None:
            self.head = newWord
            return
        temp = self.head
        while(temp.previous):
            temp = temp.previous
        temp.previous = newWord


Dictionary = Diction()
Dictionary.addWord('io!')
Dictionary.addWord('imm')
Dictionary.addWord('Butters')
Dictionary.printDict()


