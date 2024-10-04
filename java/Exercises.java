import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Optional;
import java.util.function.Predicate;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Exercises {
    static Map<Integer, Long> change(long amount) {
        if (amount < 0) {
            throw new IllegalArgumentException("Amount cannot be negative");
        }
        var counts = new HashMap<Integer, Long>();
        for (var denomination : List.of(25, 10, 5, 1)) {
            counts.put(denomination, amount / denomination);
            amount %= denomination;
        }
        return counts;
    }

    public static Optional<String> firstThenLowerCase(List<String> strings, Predicate<String> predicate) {
        return strings.stream().filter(predicate).findFirst().map(String::toLowerCase);
    }

    public static record Sayer(String phrase) {
        Sayer and(String word) {
            String newPhrase = (!phrase.isEmpty() || word.isEmpty())
                    ? phrase + " " + word
                    : phrase + word;
            return new Sayer(newPhrase);
        }

        public String phrase() {
            return phrase;
        }
    }

    public static Sayer say() {
        return new Sayer("");
    }

    public static Sayer say(String word) {
        return new Sayer(word);
    }

    public static long meaningfulLineCount(String filename) throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            return reader.lines()
                         .filter(line -> !line.trim().isEmpty() && !line.trim().startsWith("//"))
                         .count();
        }
    }
}

record Quaternion(double a, double b, double c, double d) {
    public static final Quaternion ZERO = new Quaternion(0, 0, 0, 0);
    public static final Quaternion I = new Quaternion(0, 1, 0, 0);
    public static final Quaternion J = new Quaternion(0, 0, 1, 0);
    public static final Quaternion K = new Quaternion(0, 0, 0, 1);

    public Quaternion {
        if (Double.isNaN(a) || Double.isNaN(b) || Double.isNaN(c) || Double.isNaN(d)) {
            throw new IllegalArgumentException("Coefficients cannot be NaN");
        }
    }

    public double a() {
        return this.a;
    }

    public double b() {
        return this.b;
    }

    public double c() {
        return this.c;
    }

    public double d() {
        return this.d;
    }

    public Quaternion plus(Quaternion q) {
        return new Quaternion(a + q.a, b + q.b, c + q.c, d + q.d);
    }

    public Quaternion times(Quaternion q) {
        double newA = a * q.a - b * q.b - c * q.c - d * q.d;
        double newB = a * q.b + b * q.a + c * q.d - d * q.c;
        double newC = a * q.c - b * q.d + c * q.a + d * q.b;
        double newD = a * q.d + b * q.c - c * q.b + d * q.a;
        return new Quaternion(newA, newB, newC, newD);
    }

    public List<Double> coefficients() {
        return List.of(a, b, c, d);
    }

    public Quaternion conjugate() {
        return new Quaternion(a, -b, -c, -d);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();

        if (a != 0) {
            sb.append(a);
        }

        if (b != 0) {
            if (b == 1) {
                sb.append(sb.length() > 0 ? "+i" : "i");
            } else if (b == -1) {
                sb.append(sb.length() > 0 ? "-i" : "-i");
            } else {
                sb.append(b > 0 && sb.length() > 0 ? "+" : "").append(b).append("i");
            }
        }

        if (c != 0) {
            if (c == 1) {
                sb.append(sb.length() > 0 ? "+j" : "j");
            } else if (c == -1) {
                sb.append(sb.length() > 0 ? "-j" : "-j");
            } else {
                sb.append(c > 0 && sb.length() > 0 ? "+" : "").append(c).append("j");
            }
        }

        if (d != 0) {
            if (d == 1) {
                sb.append(sb.length() > 0 ? "+k" : "k");
            } else if (d == -1) {
                sb.append(sb.length() > 0 ? "-k" : "-k");
            } else {
                sb.append(d > 0 && sb.length() > 0 ? "+" : "").append(d).append("k");
            }
        }
        return sb.length() == 0 ? "0" : sb.toString();
    }
}

sealed interface BinarySearchTree permits Empty, Node {
    int size();
    boolean contains(String value);
    BinarySearchTree insert(String value);
}

final record Empty() implements BinarySearchTree {
    @Override
    public int size() {
        return 0;
    }

    @Override
    public boolean contains(String value) {
        return false;
    }

    @Override
    public BinarySearchTree insert(String value) {
        return new Node(value, this, this);
    }

    @Override
    public String toString() {
        return "()";
    }
}

final class Node implements BinarySearchTree {
    private final String value;
    private final BinarySearchTree left;
    private final BinarySearchTree right;

    Node(String value, BinarySearchTree left, BinarySearchTree right) {
        this.value = value;
        this.left = left;
        this.right = right;
    }

    @Override
    public int size() {
        return 1 + left.size() + right.size();
    }

    @Override
    public boolean contains(String value) {
        return this.value.equals(value) || left.contains(value) || right.contains(value);
    }

    @Override
    public BinarySearchTree insert(String value) {
        if (value.compareTo(this.value) < 0) {
            return new Node(this.value, left.insert(value), right);
        } else {
            return new Node(this.value, left, right.insert(value));
        }
    }

    @Override
    public String toString() {
        return "(" + left + value + right + ")";
    }
}


