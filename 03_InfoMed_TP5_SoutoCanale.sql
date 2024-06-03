SELECT pacientes.nombre, consultas.fecha, consultas.diagnostico
FROM pacientes
INNER JOIN consultas
	ON pacientes.id_paciente = consultas.id_paciente
WHERE EXTRACT(YEAR FROM fecha) = 2024 
  AND EXTRACT(MONTH FROM fecha) = 6;