SELECT pacientes.nombre, COUNT(recetas.id_receta)
FROM pacientes
INNER JOIN recetas
	ON recetas.id_paciente = pacientes.id_paciente
GROUP BY pacientes.nombre
ORDER BY COUNT;