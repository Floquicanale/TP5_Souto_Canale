SELECT 
 	medicos.nombre AS nombre_medico,
    pacientes.nombre AS nombre_paciente,
    COUNT(consultas.id_consulta) AS total_consultas
FROM 
    consultas
INNER JOIN 
    pacientes 
    ON consultas.id_paciente = pacientes.id_paciente
INNER JOIN 
    medicos 
    ON consultas.id_medico = medicos.id_medico
GROUP BY 
    medicos.nombre, 
    pacientes.nombre
ORDER BY 
    medicos.nombre, 
    pacientes.nombre;
