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
