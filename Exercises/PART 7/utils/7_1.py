from format import load_positions, to_matlab

positions = load_positions()
x, y, z = to_matlab(positions)

with open("data.m", "w") as file:
    file.write(x + "\n")
    file.write(y + "\n")
    file.write(z + "\n")    