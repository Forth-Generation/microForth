class Word:
    
    def __init__(self, name, *codes):
        self.previous = None
        self.count = len(name)
        self.name = name
        self.code = []
        for i in codes:
            self.code.append(i)
        self.params = []

class Diction:

    def __init__(self):
        self.head = None

    def printDict(self):
        temp = self.head
        while(temp):
            print (temp.name)
            print (temp.count)
            print (temp.code)
            temp = temp.previous

    def addWord(self, newNode, *codes ):
        newWord = Word(newNode, codes)
        if self.head is None:
            self.head = newWord
            return
        temp = self.head
        while(temp.previous):
            temp = temp.previous
        temp.previous = newWord


Dictionary = Diction()
Dictionary.addWord('noop' , 6000)
Dictionary.printDict()


