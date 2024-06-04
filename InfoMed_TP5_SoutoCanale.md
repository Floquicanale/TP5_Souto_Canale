# Parte 1
**¿Qué tipo de base de datos es?**

Es una base de datos SQL transaccional, por lo que su información es relacional y está estructurada en un sistema de filas y columnas. 

**Armar el diagrama de entidad relación.**

Ya esta hecho pero no lo pude pegar

**Considera que la base de datos está normalizada. En caso que no lo esté, ¿cómo
podría hacerlo?**

Si bien se cumple que celda de la tabla solo puede tener un valor y hay tablas dimensionales que simplifican y estandarizan el uso de la BD, hay algunas cosas que se podrían hacer para terminar de normalizar la base.
Primero, los nombres de pacientes y médicos deberían estar serparados en nombre y apellido como 2 campos distintos.
Segundo, las ciudades podrían estar en una tabla aparte para evitar las inconscistencias de mayusculas, minúsculas y espacios que aparecen al usar un string.

# Parte 2
**1. Obtener el nombre y la dirección de los pacientes que viven en Buenos Aires.**

Código:
```
SELECT nombre, calle, numero
FROM pacientes
WHERE ciudad = 'Buenos Aires' OR ciudad = 'buenos aires';
```
