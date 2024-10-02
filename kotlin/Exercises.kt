import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException
import java.lang.StringBuilder
import java.io.File


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


fun meaningfulLineCount(filename: String): Long {
    val file = File(filename)

    if (!file.exists()) {
        throw IOException("No such file")
    }

    return file.bufferedReader().use { reader ->
        reader.lines()
            .filter { line ->
                val trimmed = line.trim()
                trimmed.isNotEmpty() && !trimmed.startsWith("#")
            }
            .count()
    }
}
data class Quaternion(val a: Double, val b: Double, val c: Double, val d: Double) {

    companion object {
        val ZERO = Quaternion(0.0, 0.0, 0.0, 0.0)
        val I = Quaternion(0.0, 1.0, 0.0, 0.0)
        val J = Quaternion(0.0, 0.0, 1.0, 0.0)
        val K = Quaternion(0.0, 0.0, 0.0, 1.0)
    }

    operator fun plus(other: Quaternion): Quaternion {
        return Quaternion(
            a + other.a,
            b + other.b,
            c + other.c,
            d + other.d
        )
    }

    operator fun times(other: Quaternion): Quaternion {
        val newA = a * other.a - b * other.b - c * other.c - d * other.d
        val newB = a * other.b + b * other.a + c * other.d - d * other.c
        val newC = a * other.c - b * other.d + c * other.a + d * other.b
        val newD = a * other.d + b * other.c - c * other.b + d * other.a
        return Quaternion(newA, newB, newC, newD)
    }

    fun conjugate(): Quaternion {
        return Quaternion(a, -b, -c, -d)
    }

    fun coefficients(): List<Double> {
        return listOf(a, b, c, d)
    }

    override fun toString(): String {
        val parts = mutableListOf<String>()

        if (a != 0.0) parts.add("$a")
        if (b == 1.0) parts.add("i")
        else if (b == -1.0) parts.add("-i")
        else if (b != 0.0) parts.add("${b}i")

        if (c == 1.0) parts.add("j")
        else if (c == -1.0) parts.add("-j")
        else if (c != 0.0) parts.add("${c}j")

        if (d == 1.0) parts.add("k")
        else if (d == -1.0) parts.add("-k")
        else if (d != 0.0) parts.add("${d}k")

        return if (parts.isEmpty()) "0" else parts.joinToString(separator = "")
    }
}

// Write your Binary Search Tree interface and implementing classes here
