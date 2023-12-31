lineNumber = 0

#Valid variable names and their machine code equivalents (e.g. P0 -> 000 in the instruction)
#Note that input is set to lower case, so e.g. both I and i work fine.
regs = {"r0": "0", "r1": "1","r2": "2","r3": "3","r4": "4","r5": "5","r6": "6","r7": "7","r8": "8","r9": "9","r10": "10","r11": "11","r12": "12","r13": "13","r14": "14","r15": "15"}

#Method to convert a given assembly line into a machine code instruction
def convertLine(line):
    global lineNumber
    lineNumber = lineNumber + 1 #keep track of line number for debug
    line = line.strip()
    line.split()
    tokenList  = line.split(" ")

    #skip line if white space or is a comment
    if (line=="" or line[0:2]=="#" or len(tokenList) == 0):
            return

    #remove any excess whitespace inside each line
    while ("" in tokenList) : tokenList.remove("")

    command = tokenList[0].lower()
    assemblyInstruction = ""

    #switch on command & follow recipe to craft machine code instruction
    if (command=="xor"):
       assemblyInstruction = "00000" + convertBinary(4, convertRegs(tokenList[1]))
       
    elif (command=="lw"):
        assemblyInstruction = "00001" + convertBinary(4, convertRegs(tokenList[1]))

    elif (command=="sw"):
        assemblyInstruction = "00010" + convertBinary(4, convertRegs(tokenList[1]))

    elif (command=="mov"):
        assemblyInstruction = "00011" + convertBinary(4, convertRegs(tokenList[1]))

    elif (command=="put"):
        assemblyInstruction = "00100" + convertBinary(4, convertRegs(tokenList[1]))

    elif (command=="add"):
        assemblyInstruction = "00101" + convertBinary(4, convertRegs(tokenList[1]))

    elif (command=="sub"):
        assemblyInstruction = "00110" + convertBinary(4, convertRegs(tokenList[1]))

    elif (command=="sl"):
        assemblyInstruction = "00111" + convertBinary(4, convertRegs(tokenList[1]))

    elif (command=="sr"):
        assemblyInstruction = "01000" + convertBinary(4, convertRegs(tokenList[1]))

    elif (command=="inc"):
       assemblyInstruction = "01001" + convertBinary(4, convertRegs(tokenList[1]))

    elif (command=="dec"):
       assemblyInstruction = "01010" + convertBinary(4, convertRegs(tokenList[1]))

    elif (command=="and"):
        assemblyInstruction = "01011" + convertBinary(4, convertRegs(tokenList[1]))

    elif (command=="addi"):
        assemblyInstruction = "01100" + convertBinary(4, delNumSign(tokenList[1]))

    elif (command=="bne"):
        assemblyInstruction = "1" + convertBinary(8, delNumSign(tokenList[1]))
    elif(command=="done"):
        assemblyInstruction = "011110000"
    elif (command=="eop"):
        print("Assembler successfully terminated!")
        quit()
    else:
        print("ERROR: unrecognized assembly instruction on line " + str(lineNumber))
        quit()

    #write out finished assembly instruction
    fileM.write(assemblyInstruction+"\n")


#convert decimal token to binary for machine code
def convertBinary(length, token):
    number = int(token)

    #Handy method from http://stackoverflow.com/questions/28383585/how-to-get-binary-representation-of-negative-numbers-in-python
    binary = "{0:b}".format(((1<<length)-1) & number)

    #If positive number, won't give leading zeros - need to add these
    while (len(binary) < length):
        binary = "0" + binary

    return binary

#converts an index token to machine code (e.g. R3 -> 3)
def convertRegs(token):
    return regs[token.lower()]

#removes # for immediates 
def delNumSign(token):
    return token[1:]

#Program Start - open files, and start converting each line of input Assembly file
inFilename = input("Enter the name of input file: ")
outFilename = input("Enter the name of output file: ")

with open(inFilename, "r") as fileA:
    with open(outFilename, "w") as fileM:
        for line in fileA:
            convertLine(line)
