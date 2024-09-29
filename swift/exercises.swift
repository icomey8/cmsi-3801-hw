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
func firstThenLowerCase(of strings: [String?], satisfying predicate: (String) -> Bool) -> String? {
    for string in strings {
        if let unwrappedString = string, predicate(unwrappedString) {
            return string?.lowercased()
        }
    }
    return nil
}

// Write your say function here


// Write your meaningfulLineCount function here

// Write your Quaternion struct here

// Write your Binary Search Tree enum here
//enum BST {
//    case empty
//    indirect case node(BST?, String, BST?)
//
//    var size: Int {
//        switch self {
//            case .empty: return 00
//            case let .node(left, _, right): return left.size + 1 + right.size
//           }
//    }
//}

