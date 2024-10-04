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

    // Fixed toString method
    override fun toString(): String {
        val parts = mutableListOf<String>()

        // Add real part (a)
        if (a != 0.0) parts.add("$a")

        // Add imaginary part (b, c, d) with proper sign handling
        if (b == 1.0) parts.add("i")
        else if (b == -1.0) parts.add("-i")
        else if (b != 0.0) parts.add("${if (b > 0 && parts.isNotEmpty()) "+" else ""}${b}i")

        if (c == 1.0) parts.add("j")
        else if (c == -1.0) parts.add("-j")
        else if (c != 0.0) parts.add("${if (c > 0 && parts.isNotEmpty()) "+" else ""}${c}j")

        if (d == 1.0) parts.add("k")
        else if (d == -1.0) parts.add("-k")
        else if (d != 0.0) parts.add("${if (d > 0 && parts.isNotEmpty()) "+" else ""}${d}k")

        // If no parts were added, return "0"
        return if (parts.isEmpty()) "0" else parts.joinToString("")  // Ensures no spaces between parts
    }
}






// Write your Binary Search Tree interface and implementing classes 

sealed class BinarySearchTree {
    abstract fun size(): Int
    abstract fun contains(value: String): Boolean
    abstract fun insert(value: String): BinarySearchTree

    object Empty : BinarySearchTree() {
        override fun size() = 0
        override fun contains(value: String) = false
        override fun insert(value: String): BinarySearchTree = Node(value, this, this)
        override fun toString() = "()"
    }

    data class Node(
        val value: String,
        val left: BinarySearchTree,
        val right: BinarySearchTree
    ) : BinarySearchTree() {
        private val _size = 1 + left.size() + right.size()

        override fun size() = _size

        override fun contains(value: String): Boolean {
            return when {
                value < this.value -> left.contains(value)
                value > this.value -> right.contains(value)
                else -> true
            }
        }

        override fun insert(value: String): BinarySearchTree {
            return when {
                value < this.value -> Node(this.value, left.insert(value), right)
                value > this.value -> Node(this.value, left, right.insert(value))
                else -> this
            }
        }

        override fun toString(): String {
            val leftStr = if (left is Empty) "" else left.toString()
            val rightStr = if (right is Empty) "" else right.toString()
            return "($leftStr$value$rightStr)"
        }
    }
}
