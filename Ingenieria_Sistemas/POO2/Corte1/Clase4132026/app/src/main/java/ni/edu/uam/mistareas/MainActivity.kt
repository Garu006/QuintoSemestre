package ni.edu.uam.mistareas

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FilterChip
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.TextButton
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.compose.material3.rememberDatePickerState
import ni.edu.uam.mistareas.ui.theme.MisTareasTheme
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

enum class EstadoTarea {
    REGISTRADA,
    EN_PROCESO,
    FINALIZADA
}

class MainActivity : ComponentActivity() {
    @OptIn(ExperimentalMaterial3Api::class)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            MisTareasTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    RegistroTareasScreen()
                }
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RegistroTareasScreen() {
    var nombre by remember { mutableStateOf("") }

    var fechaInicioMillis by remember { mutableStateOf<Long?>(null) }
    var fechaFinalMillis by remember { mutableStateOf<Long?>(null) }

    var mostrarCalendarioInicio by remember { mutableStateOf(false) }
    var mostrarCalendarioFinal by remember { mutableStateOf(false) }

    var estado by remember { mutableStateOf(EstadoTarea.REGISTRADA) }
    var mensaje by remember { mutableStateOf("Ingrese los datos de la tarea") }

    val formatoFecha = remember {
        SimpleDateFormat("dd/MM/yyyy", Locale.getDefault())
    }

    val fechaInicioTexto = fechaInicioMillis?.let { formatoFecha.format(Date(it)) } ?: ""
    val fechaFinalTexto = fechaFinalMillis?.let { formatoFecha.format(Date(it)) } ?: ""

    if (mostrarCalendarioInicio) {
        val datePickerState = rememberDatePickerState()

        DatePickerDialog(
            onDismissRequest = { mostrarCalendarioInicio = false },
            confirmButton = {
                TextButton(
                    onClick = {
                        fechaInicioMillis = datePickerState.selectedDateMillis
                        mostrarCalendarioInicio = false
                    }
                ) {
                    Text("Aceptar")
                }
            },
            dismissButton = {
                TextButton(
                    onClick = { mostrarCalendarioInicio = false }
                ) {
                    Text("Cancelar")
                }
            }
        ) {
            DatePicker(state = datePickerState)
        }
    }

    if (mostrarCalendarioFinal) {
        val datePickerState = rememberDatePickerState()

        DatePickerDialog(
            onDismissRequest = { mostrarCalendarioFinal = false },
            confirmButton = {
                TextButton(
                    onClick = {
                        fechaFinalMillis = datePickerState.selectedDateMillis
                        mostrarCalendarioFinal = false
                    }
                ) {
                    Text("Aceptar")
                }
            },
            dismissButton = {
                TextButton(
                    onClick = { mostrarCalendarioFinal = false }
                ) {
                    Text("Cancelar")
                }
            }
        ) {
            DatePicker(state = datePickerState)
        }
    }

    Scaffold(
        topBar = {
            TopAppBar(
                title = {
                    Text(
                        text = "Registro de Tareas",
                        style = MaterialTheme.typography.titleLarge
                    )
                }
            )
        }
    ) { innerPadding ->

        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
                .padding(16.dp),
            verticalArrangement = Arrangement.Top
        ) {
            Text(
                text = "Organiza tus tareas por período de tiempo",
                style = MaterialTheme.typography.headlineSmall
            )

            Spacer(modifier = Modifier.height(16.dp))

            Card(
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(
                    modifier = Modifier.padding(16.dp)
                ) {
                    OutlinedTextField(
                        value = nombre,
                        onValueChange = { nombre = it },
                        label = { Text("Nombre de la tarea") },
                        modifier = Modifier.fillMaxWidth()
                    )

                    Spacer(modifier = Modifier.height(12.dp))

                    OutlinedTextField(
                        value = fechaInicioTexto,
                        onValueChange = {},
                        readOnly = true,
                        label = { Text("Fecha de inicio") },
                        placeholder = { Text("Seleccione una fecha") },
                        modifier = Modifier.fillMaxWidth()
                    )

                    Spacer(modifier = Modifier.height(8.dp))

                    Button(
                        onClick = { mostrarCalendarioInicio = true },
                        modifier = Modifier.fillMaxWidth()
                    ) {
                        Text("Seleccionar fecha de inicio")
                    }

                    Spacer(modifier = Modifier.height(12.dp))

                    OutlinedTextField(
                        value = fechaFinalTexto,
                        onValueChange = {},
                        readOnly = true,
                        label = { Text("Fecha final") },
                        placeholder = { Text("Seleccione una fecha") },
                        modifier = Modifier.fillMaxWidth()
                    )

                    Spacer(modifier = Modifier.height(8.dp))

                    Button(
                        onClick = { mostrarCalendarioFinal = true },
                        modifier = Modifier.fillMaxWidth()
                    ) {
                        Text("Seleccionar fecha final")
                    }

                    Spacer(modifier = Modifier.height(16.dp))

                    Text(
                        text = "Estado de ejecución",
                        style = MaterialTheme.typography.titleMedium
                    )

                    Spacer(modifier = Modifier.height(8.dp))

                    Row(
                        modifier = Modifier.fillMaxWidth()
                    ) {
                        FilterChip(
                            selected = estado == EstadoTarea.REGISTRADA,
                            onClick = { estado = EstadoTarea.REGISTRADA },
                            label = { Text("Registrada") }
                        )

                        Spacer(modifier = Modifier.width(8.dp))

                        FilterChip(
                            selected = estado == EstadoTarea.EN_PROCESO,
                            onClick = { estado = EstadoTarea.EN_PROCESO },
                            label = { Text("En proceso") }
                        )

                        Spacer(modifier = Modifier.width(8.dp))

                        FilterChip(
                            selected = estado == EstadoTarea.FINALIZADA,
                            onClick = { estado = EstadoTarea.FINALIZADA },
                            label = { Text("Finalizada") }
                        )
                    }

                    Spacer(modifier = Modifier.height(20.dp))

                    Button(
                        onClick = {
                            mensaje = when {
                                nombre.isBlank() -> {
                                    "Ingrese el nombre de la tarea."
                                }
                                fechaInicioMillis == null || fechaFinalMillis == null -> {
                                    "Seleccione ambas fechas."
                                }
                                fechaFinalMillis!! < fechaInicioMillis!! -> {
                                    "La fecha final no puede ser menor que la fecha de inicio."
                                }
                                else -> {
                                    "Tarea \"$nombre\" registrada correctamente.\n" +
                                            "Inicio: $fechaInicioTexto\n" +
                                            "Final: $fechaFinalTexto\n" +
                                            "Estado: ${estado.name.replace("_", " ")}"
                                }
                            }
                        },
                        modifier = Modifier.fillMaxWidth()
                    ) {
                        Text("Guardar tarea")
                    }
                }
            }

            Spacer(modifier = Modifier.height(16.dp))

            Text(
                text = mensaje,
                style = MaterialTheme.typography.bodyLarge,
                color = MaterialTheme.colorScheme.primary
            )
        }
    }
}