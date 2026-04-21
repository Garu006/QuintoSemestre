// random number generator
import kotlin.random.Random

fun main() {
    val random = List(10) {
        Random.nextInt(0, 10)
    }
    println(random)

    val nextValue = List(10) {
        Random.nextInt(0, 10)
    }
    println(nextValue)
    println("randomValues != nextValue es = ${random != nextValue}")
}