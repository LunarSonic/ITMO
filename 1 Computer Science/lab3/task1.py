import re
def smile(value):
    our_matches = re.findall(r"X-\\", value)
    print(len(our_matches))
ex1 = r"X-X-\\:)-Xitmo:X-\\{X-\\:)"
ex2 = r"heX-\\16 система счисления"
ex3 = r"XXXX---\\\\"
ex4 = r"My favorite smile is X - \\"
ex5 = r"[X-\\-X-/X-\\-/-99=X-\\"
ex6 = r"X-\\ 000 \\\\\\\ X-\\\\\\XXXX--\\\XXX-\\\\\\"
smile(ex1)
smile(ex2)
smile(ex3)
smile(ex4)
smile(ex5)
smile(ex6)





