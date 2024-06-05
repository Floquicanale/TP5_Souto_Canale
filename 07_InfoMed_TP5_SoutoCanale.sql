SELECT pacientes.nombre, consultas.fecha AS ultima_consulta, consultas.diagnostico
FROM pacientes
INNER JOIN consultas 
    ON pacientes.id_paciente = consultas.id_paciente
INNER JOIN (
    SELECT id_paciente, MAX(fecha) AS ultima_fecha
    FROM consultas
    GROUP BY id_paciente
) ultimas_consultas 
    ON consultas.id_paciente = ultimas_consultas.id_paciente 
    AND consultas.fecha = ultimas_consultas.ultima_fecha;