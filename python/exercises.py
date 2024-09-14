from dataclasses import dataclass
from collections.abc import Callable


def change(amount: int) -> dict[int, int]:
    if not isinstance(amount, int):
        raise TypeError('Amount must be an integer')
    if amount < 0:
        raise ValueError('Amount cannot be negative')
    counts, remaining = {}, amount
    for denomination in (25, 10, 5, 1):
        counts[denomination], remaining = divmod(remaining, denomination)
    return counts


# Write your first then lower case function here
def first_then_lower_case(strings, predicate, /):
  for str in strings:
    if predicate(str): 
      return str.lower()
  return None

# Write your powers generator here
def powers_generator(base, limit):
    value = 1
    exponent = 0
    
    while value <= limit:
        yield value
        exponent += 1
        value = base ** exponent

# Write your say function here
def say(word=None):
    if word is None:
        return ''

    def inner_say(next_word=None, words=[word]):
        if next_word is None:
            return ' '.join(words)
        else:
            words.append(next_word)
            return lambda w=None: inner_say(w, words)
    return inner_say

# Write your line count function here
def meaningful_line_count(file, /):
    try:
        count = 0
        with open(file, 'r') as file:
            for line in file:
                stripped_line = line.strip()
                if stripped_line and not stripped_line.startswith('#'):
                    count += 1
            return count
    except FileNotFoundError as e:
        raise 
    
    
class Quaternion:
    def __init__(self, a: float, b: float, c: float, d: float):
        self.a = a
        self.b = b
        self.c = c
        self.d = d

    # String representation
    def __str__(self):
        parts = []
        if self.a != 0 or (self.a == 0 and self.b == 0 and self.c == 0 and self.d == 0):
            parts.append(f"{self.a}")
        if self.b != 0:
            parts.append(f"{'+' if self.b > 0 else ''}{self.b}i")
        if self.c != 0:
            parts.append(f"{'+' if self.c > 0 else ''}{self.c}j")
        if self.d != 0:
            parts.append(f"{'+' if self.d > 0 else ''}{self.d}k")
        return ''.join(parts).replace("+-", "-") if parts else '0'

    # Add two quaternions
    def __add__(self, other: 'Quaternion') -> 'Quaternion':
        return Quaternion(self.a + other.a, self.b + other.b, self.c + other.c, self.d + other.d)

    # Multiply two quaternions
    def __mul__(self, other: 'Quaternion') -> 'Quaternion':
        return Quaternion(
            self.a * other.a - self.b * other.b - self.c * other.c - self.d * other.d,
            self.a * other.b + self.b * other.a + self.c * other.d - self.d * other.c,
            self.a * other.c - self.b * other.d + self.c * other.a + self.d * other.b,
            self.a * other.d + self.b * other.c - self.c * other.b + self.d * other.a
        )

    # Conjugate 
    @property
    def conjugate(self) -> 'Quaternion':
        return Quaternion(self.a, -self.b, -self.c, -self.d)

    # Coefficients 
    @property
    def coefficients(self) -> tuple:
        return (self.a, self.b, self.c, self.d)

    



# Write your Quaternion class here
