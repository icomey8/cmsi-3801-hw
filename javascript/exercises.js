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

// Write your say function here

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
