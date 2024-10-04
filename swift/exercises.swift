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

func firstThenLowerCase(of strings: [String], satisfying predicate: (String) -> Bool) -> String? {
    return strings.first(where: predicate)?.lowercased()
}

struct Sayer {
    let phrase: String
    func and(_ word: String) -> Sayer {
        return Sayer(phrase: phrase + " " + word)
    }
}

func say(_ word: String = "") -> Sayer {
    return Sayer(phrase: word)
}


func meaningfulLineCount(_ fileName: String) -> Result<Int, Error> {
    do {
        let fileURL = URL(fileURLWithPath: fileName)
        let fileContents = try String(contentsOf: fileURL)
        let lines = fileContents.split(separator: "\n")
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

    init(a: Double = 0, b: Double = 0, c: Double = 0, d: Double = 0) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
    }

    var coefficients: [Double] {
        return [a, b, c, d]
    }

    var conjugate: Quaternion {
        return Quaternion(a: a, b: -b, c: -c, d: -d)
    }

    var description: String {
        var components: [String] = []

        if a != 0 {
            components.append(String(format: "%.1f", a)) // Always show one decimal place for real part
        }

        if b != 0 {
            let sign = b < 0 ? "-" : (components.isEmpty ? "" : "+")
            let bValue = abs(b) == 1 ? "" : String(format: "%.2f", abs(b)) // Omit "1" for unit values
            components.append("\(sign)\(bValue)i")
        }

        if c != 0 {
            let sign = c < 0 ? "-" : (components.isEmpty ? "" : "+")
            let cValue = abs(c) == 1 ? "" : String(format: "%.1f", abs(c)) // Omit "1" for unit values
            components.append("\(sign)\(cValue)j")
        }

        if d != 0 {
            let sign = d < 0 ? "-" : (components.isEmpty ? "" : "+")
            let dValue = abs(d) == 1 ? "" : String(format: "%.2f", abs(d)) // Omit "1" for unit values
            components.append("\(sign)\(dValue)k")
        }

        return components.isEmpty ? "0" : components.joined()
    }

    static func + (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(a: lhs.a + rhs.a, b: lhs.b + rhs.b, c: lhs.c + rhs.c, d: lhs.d + rhs.d)
    }

    static func * (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        let a = lhs.a * rhs.a - lhs.b * rhs.b - lhs.c * rhs.c - lhs.d * rhs.d
        let b = lhs.a * rhs.b + lhs.b * rhs.a + lhs.c * rhs.d - lhs.d * rhs.c
        let c = lhs.a * rhs.c - lhs.b * rhs.d + lhs.c * rhs.a + lhs.d * rhs.b
        let d = lhs.a * rhs.d + lhs.b * rhs.c - lhs.c * rhs.b + lhs.d * rhs.a
        return Quaternion(a: a, b: b, c: c, d: d)
    }

    static func == (lhs: Quaternion, rhs: Quaternion) -> Bool {
        return lhs.a == rhs.a && lhs.b == rhs.b && lhs.c == rhs.c && lhs.d == rhs.d
    }
}

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

