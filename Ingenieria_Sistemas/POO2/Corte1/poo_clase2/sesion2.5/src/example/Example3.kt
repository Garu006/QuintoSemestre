package example

fun saludar(){
    println("Hola pipi")
}
fun saludar(nombre: String): String{
    return "Hola $nombre, mucho gusto."
}
fun sumar(num1: Int, num2: Int):Int = num1 + num2

fun acceder(name: String, pw:String): Boolean{
    return name == "admin" && pw == "123"
}

fun calcularSalario(salario: Double, inss: Double = 0.07): Double = salario * (1+inss)

fun main(args: Array<String>) {
    saludar()
    println(saludar("Gabriel"))
    println("Suma = ${sumar(1,2)}")

    val estado = acceder("admin", "123")
    println(estado)

    val salario = calcularSalario(1000.0)
    println(salario)

    val salarioNeto = calcularSalario(inss = 0.1, salario = 1000.0)
    println(salarioNeto)
}

