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


# Write your say function here


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
        raise e
    
    



# Write your Quaternion class here
