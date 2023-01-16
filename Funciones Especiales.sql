
/* FUNCIONES ESPECIALES EN POSTGRESQL

ON CONFLICT DO
RETURNING
LIKE / ILIKE
IS / IS NOT

ON CONFLICT DO
Esta instruccion nos permite especificar que debemos hacer en caso de un conflicto.
Ejemplo: Imaginamos que realizamos una consulta donde el id ya ha sido utilizado.
Podemos especificar que en ese caso, actualize los datos. */

NSERT INTO pasajero (id, nombre, direccion_residencia, fecha_nacimiento)
	values (1, '', '','2010-01-01')
	ON CONFLICT ("ID") DO 
	UPDATE SET 
	nombre = '', direccion_residencia='', fecha_nacimiento='2010-01-01';

/* RETURNING
Returning nos devuelve una consulta select de los campos sobre los que ha tenido efecto la instruccion.
Ejemplo: Queremos saber cual es el id que le fue asignado a un dato insertado. */

INSERT INTO tren (modelo, capacidad)
	 VALUES('modelo x', 100)
	 RETURNING "ID";

INSERT INTO tren (modelo, capacidad)
	 VALUES('modelo x', 100)
	 RETURNING "ID";

INSERT INTO tren (modelo, capacidad)
	 VALUES('modelo x', 100)
	 RETURNING "ID", capacidad;

/* Like / Ilike
Las funciones like y ilike sirven para crear consultas a base de expresiones regulares.
Like considera mayusculas y minusculas, mientras que ilike solo considera las letras.
Ejemplo: Busquemos a los pasajeros con nombre que terminen con la letra 'o': */

-- Usando LIKE
SELECT * FROM PASAJERO
WHERE pasajero.nombre LIKE '%O'
-- No devulve nada, porque ningun nombre terminara con una letra mayuscula


-- Usando ILIKE
SELECT * FROM PASAJERO
WHERE pasajero.nombre LIKE '%O'
-- Devolvera los nombres que terminen con o, independiente si es mayuscula o minuscula.

/* IS / IS NOT
Permite hacer comprobacion de valores especiales como null 
Ejemplo: Consultemos a todos los usuarios que tengan como direccion_residencia NULL */

-- IS
SELECT * FROM PASAJERO
WHERE pasajero.nombre IS null;

-- Ahora a los que si tengan la direccion_recidencia con algun valor 

-- IS NOT
SELECT * FROM PASAJERO
WHERE pasajero.nombre IS NOT null;