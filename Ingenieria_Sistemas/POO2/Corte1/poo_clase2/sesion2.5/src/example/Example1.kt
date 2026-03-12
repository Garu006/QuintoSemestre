package example

fun main() {
    val age: Int = 20
    val name: String = "Gabriel"
    val salary: Double = 1250.0
    val isSingle: Boolean = true

    println("Nombre $name tiene $age.")
    println("Posee un salario de $salary dolares semanales")

    if (isSingle)
        println("Feliz")
    else
        println("Feliz, pero solo con una.")

    println("$name se ha comído 6 o 7 slices de pizza")

    for (i in 10.. 1 step 2){
        println("si")
    }

    println("Esperando a la indicada.")
    for (i in 10 downTo 1 step 2){
        println("La indicada $i")
    }
    println("lo siento, en tora vida te toca ser ING.")
}