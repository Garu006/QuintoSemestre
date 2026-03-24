package ni.edu.uam.practica323

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import ni.edu.uam.practica323.ui.theme.Practica323Theme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            Practica323Theme {
                TablaMultiplicar()
            }
        }
    }
}

@Composable
fun TablaMultiplicar() {
    var numero by remember { mutableStateOf("") }
    var resultado by remember { mutableStateOf("") }

    Column(modifier = Modifier.padding(16.dp)) {
        Text(text = "Tabla de Multiplicar")

        Spacer(modifier = Modifier.height(10.dp))

        TextField(
            value = numero,
            onValueChange = { numero = it },
            label = { Text("Ingrese un número") }
        )

        Spacer(modifier = Modifier.height(10.dp))

        Button(onClick = {
            val num = numero.toIntOrNull()

            if (num != null) {
                if (num % 5 == 0) {
                    resultado = ""
                    for (i in 1..10) {
                        resultado += "$num x $i = ${num * i}\n"
                    }
                } else {
                    resultado = "$num no es múltiplo de 5"
                }
            } else {
                resultado = "Por favor, ingrese un número válido."
            }
        }) {
            Text("Mostrar tabla")
        }

        Spacer(modifier = Modifier.height(16.dp))

        Text(text = resultado)
    }
}