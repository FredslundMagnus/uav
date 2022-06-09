splitter = "---\n"

positions = 8, 11, 7
orientation = 12, 16, 7
class Time:
    def __init__(self, lines: list[str]):
        pass

class Orientation:
    def __init__(self, lines: list[str]):
        self.x = float(lines[0][orientation[2]:])
        self.y = float(lines[1][orientation[2]:])
        self.z = float(lines[2][orientation[2]:])
        self.w = float(lines[3][orientation[2]:])

    def __str__(self) -> str:
        return f"Rot({self.x}, {self.y}, {self.z}, {self.w})"

    def __repr__(self) -> str:
        return str(self)


class Position:
    def __init__(self, lines: list[str]):
        self.x = float(lines[0][positions[2]:])
        self.y = float(lines[1][positions[2]:])
        self.z = float(lines[2][positions[2]:])

    def __str__(self) -> str:
        return f"Pos({self.x}, {self.y}, {self.z})"

    def __repr__(self) -> str:
        return str(self)

class Block:
    def __init__(self, text: str):
        lines = text.split("\n")
        self.position = Position(lines[positions[0]:positions[1]])
        self.orientation = Orientation(lines[orientation[0]:orientation[1]])
        

    def __repr__(self):
        return str(self)

    def __str__(self):
        return f"Block(positions={self.position}, orientation={self.orientation})"

def load_positions() -> list[Position]:
    with open("7_1.txt", "r") as file:
        text = file.read()
        positions = [Block(b).position for b in text.split(splitter)[:-1]]
    return positions

def load_orientations() -> list[Orientation]:
    with open("7_1.txt", "r") as file:
        text = file.read()
        orientations = [Block(b).orientation for b in text.split(splitter)[:-1]]
    return orientations
    
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
