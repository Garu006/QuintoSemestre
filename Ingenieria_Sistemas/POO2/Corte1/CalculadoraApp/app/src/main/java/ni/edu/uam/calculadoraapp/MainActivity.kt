package ni.edu.uam.calculadoraapp

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableDoubleStateOf
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import ni.edu.uam.calculadoraapp.ui.theme.CalculadoraAppTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            CalculadoraAppTheme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    Evaluador(
                        modifier = Modifier.padding(innerPadding)
                    )
                }
            }
        }
    }
}

@Composable
fun Evaluador(modifier : Modifier){
    var corte1 by remember { mutableIntStateOf(0) }
    var corte2 by remember { mutableIntStateOf(0) }
    var corte3 by remember { mutableIntStateOf(0) }
    var promedio by remember { mutableDoubleStateOf(0.0) }
    Column(
        modifier = Modifier
            .padding(25.dp)
    ) {
        Text(text = "Ingrese la nota de cada corte: ")
        Spacer(Modifier.padding(10.dp))
        TextField(
            label = {Text("Corte 1: ")},
            value = corte1.toString(),
            onValueChange = {corte1 = it.toIntOrNull() ?:0}
        )
        Spacer(Modifier.padding(10.dp))
        TextField(
            label = {Text("Corte 2: ")},
            value = corte2.toString(),
            onValueChange = {corte2 = it.toIntOrNull() ?:0}
        )
        Spacer(Modifier.padding(10.dp))
        TextField(
            label = {Text("Corte 3: ")},
            value = corte3.toString(),
            onValueChange = {corte3 = it.toIntOrNull() ?:0}
        )
        Spacer(Modifier.padding(10.dp))
        Button(
            onClick = {
                promedio = (corte1 + corte2 + corte3) / 3.0
            }
        ) {
            Text(text = "Calcular Promedio")
        }
        Spacer(Modifier.padding(10.dp))
        Text(text = "Promedio ${promedio.toInt()}")
    }
}
