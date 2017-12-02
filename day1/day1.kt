import java.io.FileInputStream
import java.nio.channels.FileChannel
import java.nio.charset.Charset 

fun main (args: Array<String>) {
    var inputFileString: String = "input.txt"

    if (!args.isEmpty()) {
        inputFileString = args[0]
    }

    val input = FileInputStream (inputFileString).getChannel()
    val buffer = input.map(FileChannel.MapMode.READ_ONLY, 0, input.size())
    val charbuf = Charset.forName("UTF-8").decode(buffer);

    var digits = charbuf.filter({ it.isDigit() })
    var last = digits.last()
    var count: Int = 0

    for (d in digits) {
        if (d == last) {
            count += last.toString().toInt()
        }
        last = d
    }

    println (count)
}
