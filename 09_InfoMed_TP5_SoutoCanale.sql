SELECT 
	medicamentos.nombre AS nombre_medicamento, 
	COUNT(recetas.id_receta) AS total_recetas, 
	medicos.nombre AS nombre_medico, 
	pacientes.nombre AS nombre_paciente
FROM recetas
INNER JOIN medicamentos
	ON recetas.id_medicamento = medicamentos.id_medicamento
INNER JOIN medicos
	ON recetas.id_medico = medicos.id_medico
INNER JOIN pacientes
	ON recetas.id_paciente = pacientes.id_paciente
GROUP BY 
	medicamentos.nombre, 
	medicos.nombre, 
	pacientes.nombre
ORDER BY total_recetas DESC
