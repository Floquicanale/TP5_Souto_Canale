SELECT medicamentos.nombre
FROM medicamentos
INNER JOIN recetas
	ON recetas.id_medicamento = medicamentos.id_medicamento
WHERE recetas.id_medico =2 
GROUP BY medicamentos.nombre
HAVING COUNT(recetas.id_medicamento) > 1;