import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException
import java.lang.StringBuilder

fun change(amount: Long): Map<Int, Long> {
    require(amount >= 0) { "Amount cannot be negative" }
    
    val counts = mutableMapOf<Int, Long>()
    var remaining = amount
    for (denomination in listOf(25, 10, 5, 1)) {
        counts[denomination] = remaining / denomination
        remaining %= denomination
    }
    return counts
}

// Write your first then lower case function here
fun firstThenLowerCase (a: List<String>, predicate: (String) -> Boolean): String? {
    return a.firstOrNull(predicate)?.lowercase()
}

// Write your say function
data class Say(val phrase: String) {
    fun and(nextPhrase: String): Say {
        return Say("$phrase $nextPhrase")
    }
}

fun say(phrase: String = ""): Say {
    return Say(phrase)
}

    // handle case with no arguments or string arguments

// Write your meaningfulLineCount function here

// Write your Quaternion data class here

// Write your Binary Search Tree interface and implementing classes here
