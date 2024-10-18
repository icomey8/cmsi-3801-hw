import { open } from "node:fs/promises"

export function change(amount: bigint): Map<bigint, bigint> {
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let counts: Map<bigint, bigint> = new Map()
  let remaining = amount
  for (const denomination of [25n, 10n, 5n, 1n]) {
    counts.set(denomination, remaining / denomination)
    remaining %= denomination
  }
  return counts
}

export function firstThenApply<T, U> (items: T[], predicate: (item: T) => boolean, consumer: (item: T) => U): U | undefined {
  const result = items.find((item) => predicate(item))
  return result ? consumer(result) : undefined
}


export function* powersGenerator(base: bigint): Generator<bigint> {
  for (let power = 1n; ; power *= base) {
    yield power
  }
}


// Write your line count function here


interface Sphere {
  kind: "Sphere"
  radius: number
}
interface Box {
  kind: "Box"
  width: number
  length: number
  depth: number
}

export function volume(shape: Shape): number {
  if (shape.kind === "Sphere") {
    return (4 / 3) * Math.PI * (shape.radius ** 3)
  } else {
    return shape.width * shape.length * shape.depth
  }
}

export function surfaceArea(shape: Shape): number {
  if (shape.kind === "Sphere") {
    return 4 * Math.PI * (shape.radius ** 2)
  } else {
    return 2 * (shape.width * shape.length + shape.length * shape.depth + shape.depth * shape.width)
  }
}

export type Shape = Sphere | Box


export interface BinarySearchTree<T> {
  size(): number
  insert(value: T): BinarySearchTree<T>
  contains(value: T): boolean
  inorder(): Iterable<T>
}

export class Empty<T> implements BinarySearchTree<T> {
  size(): number {
    return 0
  }
  insert(value: T): BinarySearchTree<T> {
    return new Node(value, new Empty(), new Empty())
  }
  contains(value: T): boolean {
    return false
  }
  // generate inorder as an iterable, not as a symbol
  inorder(): Iterable<T> {
    return []
  }
}