entree = input("String : ")
print("[", end="")
for element in entree:
    print(str(ord(element)) +" ", end="")
print("]", end="")
