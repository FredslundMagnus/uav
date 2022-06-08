splitter = "---\n"

class Time:
    def __init__(self, lines: list[str]):
        pass

class Position:
    def __init__(self, lines: list[str]):
        self.x = float(lines[0][7:])
        self.y = float(lines[1][7:])
        self.z = float(lines[2][7:])

    def __str__(self) -> str:
        return f"Pos({self.x}, {self.y}, {self.z})"

    def __repr__(self) -> str:
        return str(self)

class Block:
    def __init__(self, text: str):
        lines = text.split("\n")
        self.position = Position(lines[8:11])
        

    def __repr__(self):
        return str(self.position)

def load_positions() -> list[Position]:
    with open("log.txt", "r") as file:
        text = file.read()
        positions = [Block(b).position for b in text.split(splitter)[:-1]]
    return positions
    
def to_matlab(positions: list[Position]) -> tuple[str, str, str]:
    x = "x = ["
    y = "y = ["
    z = "z = ["
    for p in positions:
        x += f"{p.x} "
        y += f"{p.y} "
        z += f"{p.z} "
    x = x[:-1] + "];"
    y = y[:-1] + "];"
    z = z[:-1] + "];"
    return x, y, z
