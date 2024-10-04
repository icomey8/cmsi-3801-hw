import Foundation

struct NegativeAmountError: Error {}
struct NoSuchFileError: Error {}

func change(_ amount: Int) -> Result<[Int:Int], NegativeAmountError> {
    if amount < 0 {
        return .failure(NegativeAmountError())
    }
    var (counts, remaining) = ([Int:Int](), amount)
    for denomination in [25, 10, 5, 1] {
        (counts[denomination], remaining) = 
            remaining.quotientAndRemainder(dividingBy: denomination)
    }
    return .success(counts)
}

// Write your first then lower case function here
func firstThenLowerCase(of strings: [String], satisfying predicate: (String) -> Bool) -> String? {
    return strings.first(where: predicate)?.lowercased()
}

// Write your say function here
struct Sayer {
    let phrase: String
    func and(_ word: String) -> Sayer {
        return Sayer(phrase: phrase + " " + word)
    }
}

func say(_ word: String = "") -> Sayer {
    return Sayer(phrase: word)
}


// Write your meaningfulLineCount function here
func meaningfulLineCount(_ fileName: String) -> Result<Int, Error> {
    do {
        let fileURL = URL(fileURLWithPath: fileName)
        let fileContents = try String(contentsOf: fileURL)
        let lines = fileContents.split(separator: "\n")
        
        // Filter meaningful lines
        let meaningfulLines = lines.filter { line in
            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
            return !trimmed.isEmpty && !trimmed.hasPrefix("#")
        }
        return .success(meaningfulLines.count)
    } catch {
        return .failure(error)
    }
}


struct Quaternion: Equatable, CustomStringConvertible {
    let a: Double
    let b: Double
    let c: Double
    let d: Double

    static let ZERO = Quaternion(a: 0, b: 0, c: 0, d: 0)
    static let I = Quaternion(a: 0, b: 1, c: 0, d: 0)
    static let J = Quaternion(a: 0, b: 0, c: 1, d: 0)
    static let K = Quaternion(a: 0, b: 0, c: 0, d: 1)

    static func + (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(
            a: lhs.a + rhs.a,
            b: lhs.b + rhs.b,
            c: lhs.c + rhs.c,
            d: lhs.d + rhs.d
        )
    }

    static func * (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        let newA = lhs.a * rhs.a - lhs.b * rhs.b - lhs.c * rhs.c - lhs.d * rhs.d
        let newB = lhs.a * rhs.b + lhs.b * rhs.a + lhs.c * rhs.d - lhs.d * rhs.c
        let newC = lhs.a * rhs.c - lhs.b * rhs.d + lhs.c * rhs.a + lhs.d * rhs.b
        let newD = lhs.a * rhs.d + lhs.b * rhs.c - lhs.c * rhs.b + lhs.d * rhs.a
        return Quaternion(a: newA, b: newB, c: newC, d: newD)
    }

    var conjugate: Quaternion {
        return Quaternion(a: a, b: -b, c: -c, d: -d)
    }

    var coefficients: [Double] {
        return [a, b, c, d]
    }

    var description: String {
        var parts: [String] = []

        if a != 0 { parts.append("\(a)") }
        if b == 1 { parts.append("i") }
        else if b == -1 { parts.append("-i") }
        else if b != 0 { parts.append("\(b)i") }

        if c == 1 { parts.append("j") }
        else if c == -1 { parts.append("-j") }
        else if c != 0 { parts.append("\(c)j") }

        if d == 1 { parts.append("k") }
        else if d == -1 { parts.append("-k") }
        else if d != 0 { parts.append("\(d)k") }

        return parts.isEmpty ? "0" : parts.joined(separator: "")
    }
}
// Write your Binary Search Tree enum here
enum BinarySearchTree: CustomStringConvertible {
    case empty
    indirect case node(BinarySearchTree?, String, BinarySearchTree?)

    var size: Int {
        switch self {
            case .empty:
                return 0
            case let .node(left, _, right):
                return 1 + (left?.size ?? 0) + (right?.size ?? 0)
           }
    }

    func contains(_ value: String) -> Bool {
        switch self {
        case .empty:
            return false
        case let .node(left, v, right):
            if value < v {
                return left?.contains(value) ?? false
            } else if value > v {
                return right?.contains(value) ?? false
            } else {
                return true
            }
        }
    }

    func insert(_ value: String) -> BinarySearchTree {
        switch self {
        case .empty:
            return .node(.empty, value, .empty)
        case let .node(left, v, right):
            if value < v {
                return .node(left?.insert(value) ?? .empty, v, right)
            } else if value > v {
                return .node(left, v, right?.insert(value) ?? .empty)
            } else {
                return self
            }
        }
    }

    var description: String {
        switch self {
        case .empty:
            return "()"
        case let .node(left, value, right):
            let leftDesc = left?.description == "()" ? "" : left?.description ?? ""
            let rightDesc = right?.description == "()" ? "" : right?.description ?? ""

            if leftDesc.isEmpty && rightDesc.isEmpty {
                return "(\(value))"
            } else if leftDesc.isEmpty {
                return "(\(value)\(rightDesc))"
            } else if rightDesc.isEmpty {
                return "(\(leftDesc)\(value))"
            } else {
                return "(\(leftDesc)\(value)\(rightDesc))"
            }
        }
    }

}

