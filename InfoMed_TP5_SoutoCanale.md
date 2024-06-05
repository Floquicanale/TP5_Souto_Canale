# Parte 1
**¿Qué tipo de base de datos es?**

Es una base de datos SQL transaccional, por lo que su información es relacional y está estructurada en un sistema de filas y columnas. 

**Armar el diagrama de entidad relación.**

![image](https://github.com/Floquicanale/TP5_Souto_Canale/assets/92120272/25ffc912-660b-4ad3-b06a-9359a4d2b91a)

**¿Considera que la base de datos está normalizada? en caso que no lo esté, ¿cómo
podría hacerlo?**

Si bien se cumple que cada celda de la tabla solo puede tener un valor y, además, tenemos tablas dimensionales que simplifican y estandarizan el uso de la BD, hay algunas cosas que se podrían hacer para terminar de normalizar la base.
Primero, los nombres de pacientes y médicos deberían estar serparados en nombre y apellido como 2 campos distintos.
Segundo, las ciudades podrían estar en una tabla aparte para evitar las inconscistencias de mayúsculas, minúsculas y espacios que aparecen al usar un string.

# Parte 2
**1. Obtener el nombre y la dirección de los pacientes que viven en Buenos Aires.**

Código:
```
SELECT nombre, calle, numero
FROM pacientes
WHERE ciudad = 'Buenos Aires' OR ciudad = 'buenos aires';
```
Salida:

<img width="494" alt="01" src="https://github.com/Floquicanale/TP5_Souto_Canale/assets/92120272/dea728ba-d134-455d-afb4-de238109df18">

**2. Obtener la cantidad de recetas emitidas por cada médico.**

Código:
```
SELECT medicos.nombre, COUNT(recetas.id_medico) AS cantidad_recetas
FROM medicos
INNER JOIN recetas ON recetas.id_medico = medicos.id_medico
GROUP BY medicos.nombre
```
Salida:

<img width="523" alt="02" src="https://github.com/Floquicanale/TP5_Souto_Canale/assets/92120272/16ade52a-13ff-44a3-a61b-924f82aadc2e">

**3. Obtener el nombre de los pacientes junto con la fecha y el diagnóstico de todas las
consultas médicas realizadas en junio del 2024.**

Código:
```
SELECT pacientes.nombre, consultas.fecha, consultas.diagnostico
FROM pacientes
INNER JOIN consultas
	ON pacientes.id_paciente = consultas.id_paciente
WHERE EXTRACT(YEAR FROM fecha) = 2024 
  AND EXTRACT(MONTH FROM fecha) = 6;
```
Salida:

<img width="504" alt="03" src="https://github.com/Floquicanale/TP5_Souto_Canale/assets/92120272/3423d4db-0a3c-43b3-9f4f-0b9d85581f49">

**4. Obtener el nombre de los medicamentos prescritos más de una vez por el médico
con ID igual a 2.**

Código:
```
SELECT medicamentos.nombre
FROM medicamentos
INNER JOIN recetas
	ON recetas.id_medicamento = medicamentos.id_medicamento
WHERE recetas.id_medico =2 
GROUP BY medicamentos.nombre
HAVING COUNT(recetas.id_medicamento) > 1;
```
Salida:

<img width="429" alt="04" src="https://github.com/Floquicanale/TP5_Souto_Canale/assets/92120272/0fdcd499-a5d7-4d34-a363-e35a86f55ea1">

**5. Obtener el nombre de los pacientes junto con la cantidad total de recetas que han
recibido.**

Código:
```
SELECT pacientes.nombre, COUNT(recetas.id_receta)
FROM pacientes
INNER JOIN recetas
	ON recetas.id_paciente = pacientes.id_paciente
GROUP BY pacientes.nombre
ORDER BY COUNT;
```
Salida:

<img width="422" alt="05" src="https://github.com/Floquicanale/TP5_Souto_Canale/assets/92120272/9187532e-b4aa-4838-8a91-68c00a166eb2">

**6. Obtener el nombre del medicamento más recetado junto con la cantidad de recetas
emitidas para ese medicamento.**

Código:
```
SELECT medicamentos.nombre, COUNT(recetas.id_receta) AS cantidad_recetas
FROM recetas
INNER JOIN medicamentos
    ON recetas.id_medicamento = medicamentos.id_medicamento
GROUP BY medicamentos.nombre
ORDER BY cantidad_recetas DESC
LIMIT 1;
```

Salida:

<img width="831" alt="image" src="https://github.com/Floquicanale/TP5_Souto_Canale/assets/107826437/4cef4a48-d454-4bad-8b8d-0b2b3c1b74f9">


**7.Obtener el nombre del paciente junto con la fecha de su última consulta y el
diagnóstico asociado.**
Código:

```
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
```

Salida: 

<img width="835" alt="image" src="https://github.com/Floquicanale/TP5_Souto_Canale/assets/107826437/a83bc1d0-fa6b-4f44-b23b-d3ffa86264bc">

**8.Obtener el nombre del médico junto con el nombre del paciente y el número total de
consultas realizadas por cada médico para cada paciente, ordenado por médico y
paciente.**

```
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

```

Salida:

<img width="800" alt="image" src="https://github.com/Floquicanale/TP5_Souto_Canale/assets/107826437/ba8e3d84-2820-4612-9eb0-e70e44d2e5be">


**9.Obtener el nombre del medicamento junto con el total de recetas prescritas para ese
medicamento, el nombre del médico que lo recetó y el nombre del paciente al que se
le recetó, ordenado por total de recetas en orden descendente.**

```
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

```
Salida:

<img width="826" alt="image" src="https://github.com/Floquicanale/TP5_Souto_Canale/assets/107826437/0271b0a6-0848-434a-b065-d9cb4a6d6c6e">


**10.Obtener el nombre del médico junto con el total de pacientes a los que ha atendido,
ordenado por el total de pacientes en orden descendente.**

```
SELECT 
    medicos.nombre AS nombre_medico,
    COUNT(DISTINCT consultas.id_paciente) AS total_pacientes
FROM 
    consultas
INNER JOIN 
    medicos 
    ON consultas.id_medico = medicos.id_medico
GROUP BY 
    medicos.nombre
ORDER BY 
    total_pacientes DESC;

```

Salida:

<img width="832" alt="image" src="https://github.com/Floquicanale/TP5_Souto_Canale/assets/107826437/923f9dc7-27a1-4649-bef0-7a2bdeaf6c7c">

