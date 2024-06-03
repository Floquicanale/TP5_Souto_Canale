SELECT medicos.nombre, COUNT(recetas.id_medico) AS cantidad_recetas
FROM medicos
INNER JOIN recetas ON recetas.id_medico = medicos.id_medico
GROUP BY 