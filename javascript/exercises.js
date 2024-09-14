import { open } from "node:fs/promises"

export function change(amount) {
  if (!Number.isInteger(amount)) {
    throw new TypeError("Amount must be an integer")
  }
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let [counts, remaining] = [{}, amount]
  for (const denomination of [25, 10, 5, 1]) {
    counts[denomination] = Math.floor(remaining / denomination)
    remaining %= denomination
  }
  return counts
}

// Write your first then lower case function here
export function firstThenLowerCase(strings, predicate) {
  for (const string of strings) {
    if (predicate?.(string)) {
      return string.toLowerCase()
    }
  }
  return undefined
}

// Write your powers generator here
export function* powersGenerator({ ofBase, upTo }) {
    let value = 1;  // Start with b^0 = 1
    let exponent = 0;
    
    while (value <= upTo) {
        yield value;
        exponent++;
        value = Math.pow(ofBase, exponent);
    }
}

// Write your say function here
export function say(word) {
  say.words = say.words || []
  if (word !== undefined) {
    say.words.push(word)
    return say
  }

  const result = say.words.join(" ")
  say.words = []
  return result
}

// Write your line count function here
export async function meaningfulLineCount(file) {
  let fileHandle;
  try {
    const fileHandle = await open(file, "r")
    const content = await fileHandle.readFile({ encoding: 'utf-8' })
    const lines = content.split('\n')
    let count = 0
    for (const line of lines) {
      const trimmedLine = line.trim()
      if (trimmedLine !== "" && trimmedLine[0] !== '#')
        count++
    }
    return count
  } catch (error) {
    return Promise.reject(error)
  } finally {
    if (fileHandle) {
      await fileHandle.close()
    }
  }

}

// Write your Quaternion class here
class Quaternion {
  constructor(a, b, c, d) {
      this.a = a || 0; // Real part
      this.b = b || 0; // i coefficient
      this.c = c || 0; // j coefficient
      this.d = d || 0; // k coefficient
      Object.freeze(this); // Freezing instance for immutability
  }

  // Get coefficients as an array
  get coefficients() {
      return [this.a, this.b, this.c, this.d];
  }

  // Conjugate
  get conjugate() {
      return new Quaternion(this.a, -this.b, -this.c, -this.d);
  }

  // String representation 
  toString() {
      const terms = [];
      if (this.a !== 0 || (this.b === 0 && this.c === 0 && this.d === 0)) {
          terms.push(this.a);
      }
      if (this.b !== 0) {
          terms.push(`${this.b > 0 && terms.length > 0 ? "+" : ""}${this.b}i`);
      }
      if (this.c !== 0) {
          terms.push(`${this.c > 0 && terms.length > 0 ? "+" : ""}${this.c}j`);
      }
      if (this.d !== 0) {
          terms.push(`${this.d > 0 && terms.length > 0 ? "+" : ""}${this.d}k`);
      }
      return terms.join('') || '0';
  }

  // Add two quaternions
  plus(q) {
      return new Quaternion(
          this.a + q.a,
          this.b + q.b,
          this.c + q.c,
          this.d + q.d
      );
  }

  // Multiply two quaternions
  times(q) {
      const a1 = this.a, b1 = this.b, c1 = this.c, d1 = this.d;
      const a2 = q.a, b2 = q.b, c2 = q.c, d2 = q.d;

      return new Quaternion(
          a1 * a2 - b1 * b2 - c1 * c2 - d1 * d2,
          a1 * b2 + b1 * a2 + c1 * d2 - d1 * c2,
          a1 * c2 - b1 * d2 + c1 * a2 + d1 * b2,
          a1 * d2 + b1 * c2 - c1 * b2 + d1 * a2
      );
  }

  // Check if quaternions are equal
  equals(q) {
      return this.a === q.a && this.b === q.b && this.c === q.c && this.d === q.d;
  }
}

export { Quaternion };