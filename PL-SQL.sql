/* PL Procedural language, también conocido como procedimientos almacenados, 
estas nos ayuda a desarrollar código directamente en el motor de bases de datos.

Estructura de un Pl es: Declaración + uso de variable+ código +fin + retorno de valores o no retorna valores.

UN bloque de código se ejecuta con la palabra DO $$ BEGIN --insert código here END $$
RAISE NOTICE ‘message’, esta sentencia es para enviar un mensaje en el log de postgres

Retornar una tabla
Retornar una tabla.

DO$$ -Declaración de un bloque de código SQL
Estructura */

DO $BODY$ 
    BEGIN 
        --insert código here 
    END 
$BODY$

ejemplo:

DO $$
DECLARE 
 rec record;
BEGIN
 FOR rec IN SELECT * FROM PASAJERO LOOP
	RAISE NOTICE 'Un pasajero se llama %', rec.nombre;
end LOOP;
END
$$

/*Otro ejemplo puede ser adicionar un contador para el número de datos de la consulta*/

DO $$
DECLARE 
 rec record;
 contador integer := 0;
BEGIN
 FOR rec IN SELECT * FROM PASAJERO LOOP
	RAISE NOTICE 'Un pasajero se llama %', rec.nombre;
	contador := contador +1;
end LOOP;
RAISE NOTICE 'Conteo es %', contador;
END
$$

/*También podemos crear una función para llamarla como llamamos las consultas materializadas*/

CREATE FUNCTION inportantePL()
RETURNS void -- Indicamos que la función inportantePL() retorna nada... o void.
AS $$
DECLARE 
 rec record;
 contador integer := 0;
BEGIN
 FOR rec IN SELECT * FROM PASAJERO LOOP
	RAISE NOTICE 'Un pasajero se llama %', rec.nombre;
	contador := contador +1;
end LOOP;
RAISE NOTICE 'Conteo es %', contador;
END
$$
LANGUAGE PLPGSQL; -- Debemos indicarle el lenguaje que estamos usando, en este paso es PLPGSQL

/* Si deseamos que la función retorne, por ejemplo un integer, podemos cambiarlo, en el siguiente caso, para que retorne 
el contador */

DROP FUNCTION inportantePL(); -- Primero borramos la función anterior, ya que no se puede tener una función distinta con el mismo nombre
CREATE OR REPLACE FUNCTION inportantePL() 
RETURNS integer
AS $$
DECLARE 
 rec record;
 contador integer := 0;
BEGIN
 FOR rec IN SELECT * FROM PASAJERO LOOP
	RAISE NOTICE 'Un pasajero se llama %', rec.nombre;
	contador := contador +1;
end LOOP;
RAISE NOTICE 'Conteo es %', contador;
RETURN contador;
END
$$
LANGUAGE PLPGSQL;

SELECT inportantePL();