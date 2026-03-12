package example

fun evaluarNota(nota: Int){
    when (nota) {
        in 0..69 -> println("$nota Aprendizaje inicial")
        in 70..79 -> println("$nota Aprendizaje fundamental")
        in 80..89 -> println("$nota Aprendizaje satisfactorio")
        in 90..100 -> println("$nota Aprendizaje avanzado")
        else -> println("Nota invalida")
    }
}

fun main() {
    println(evaluarNota(71))
}