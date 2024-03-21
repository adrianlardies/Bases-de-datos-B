CREATE OR REPLACE PROCEDURE ActualizarDevolucion(

  p_id_prestamo IN Prestamos.id_prestamo%TYPE,

  p_fecha_devolucion IN Prestamos.fecha_devolucion%TYPE,

  p_nombre_usuario OUT Usuarios.nombre_completo%TYPE,

  p_titulo_libro OUT Libros.titulo%TYPE,

  p_dias_prestado OUT INT

) AS

  v_fecha_prestamo Prestamos.fecha_prestamo%TYPE;

BEGIN

  -- Actualizar la fecha de devolución del préstamo

  UPDATE Prestamos

  SET fecha_devolucion = p_fecha_devolucion

  WHERE id_prestamo = p_id_prestamo;

   

  -- Verificar si se ha actualizado algún registro

  IF SQL%ROWCOUNT = 0 THEN

    RAISE NO_DATA_FOUND;

  END IF;

   

  -- Obtener información adicional del préstamo

  SELECT u.nombre_completo, l.titulo, p.fecha_prestamo

  INTO p_nombre_usuario, p_titulo_libro, v_fecha_prestamo

  FROM Prestamos p

  JOIN Usuarios u ON p.id_usuario = u.id_usuario

  JOIN Libros l ON p.id_libro = l.id_libro

  WHERE p.id_prestamo = p_id_prestamo;

   

  -- Calcular los días prestados

  p_dias_prestado := p_fecha_devolucion - v_fecha_prestamo;

   

  -- Si todo es correcto, hacer commit

  COMMIT;



EXCEPTION

  WHEN NO_DATA_FOUND THEN

     RAISE_APPLICATION_ERROR(-20001, 'No se encontró el préstamo con el ID ' || p_id_prestamo);

  WHEN OTHERS THEN

    RAISE_APPLICATION_ERROR(-20002, 'Error en tiempo de ejecución: ' || SQLERRM);

END;

/

CREATE OR REPLACE FUNCTION estado_prestamo(p_id_prestamo IN Prestamos.id_prestamo%TYPE)

RETURN VARCHAR2 AS

  v_fecha_prestamo Prestamos.fecha_prestamo%TYPE;

  v_fecha_devolucion Prestamos.fecha_devolucion%TYPE;

  v_estado VARCHAR2(100);

BEGIN

  -- Buscar la información del préstamo

  SELECT fecha_prestamo, fecha_devolucion

  INTO v_fecha_prestamo, v_fecha_devolucion

  FROM Prestamos

  WHERE id_prestamo = p_id_prestamo;



  -- Verificar si se ha encontrado el préstamo

  IF v_fecha_prestamo IS NULL THEN

    RAISE NO_DATA_FOUND;

  END IF;



  -- Determinar el estado del préstamo

  IF v_fecha_devolucion IS NULL THEN

    v_estado := 'Préstamo ACTIVO';

  ELSIF v_fecha_devolucion - v_fecha_prestamo <= 15 THEN

    v_estado := 'Préstamo devuelto a tiempo';

  ELSE

    v_estado := 'Préstamo devuelto con retraso';

  END IF;



  RETURN v_estado;

EXCEPTION

  WHEN NO_DATA_FOUND THEN

    RAISE_APPLICATION_ERROR(-20001, 'No se encontró el préstamo con el ID ' || p_id_prestamo);

    RETURN 'Préstamo No encontrado.';

  WHEN OTHERS THEN

    RAISE_APPLICATION_ERROR(-20002, 'Error en estado_prestamo: ' || SQLERRM);

    RETURN 'Error en estado_prestamo: ' || SQLERRM;

END;

/

CREATE OR REPLACE TRIGGER limitar_prestamos_activos

BEFORE INSERT ON Prestamos

FOR EACH ROW

DECLARE

  v_prestamos_activos NUMBER;

  limite_excedido EXCEPTION;

BEGIN

  -- Contar el número de préstamos activos para el usuario

  SELECT COUNT(*)

  INTO v_prestamos_activos

  FROM Prestamos

  WHERE id_usuario = :NEW.id_usuario

  AND fecha_devolucion IS NULL;



  -- Si el usuario ya tiene 2 préstamos activos, lanzar una excepción

  IF v_prestamos_activos >= 2 THEN

    RAISE limite_excedido;

  END IF;

EXCEPTION

  WHEN limite_excedido THEN

    RAISE_APPLICATION_ERROR(-20001, 'El usuario con id ' || :NEW.id_usuario || ' tiene ' || v_prestamos_activos || ' préstamos activos, que es el máximo ');

END;



/

CREATE OR REPLACE TRIGGER gestion_cantidad_stock

AFTER INSERT OR UPDATE OF fecha_devolucion ON Prestamos

FOR EACH ROW

DECLARE

  v_stock_actual Libros.cantidad%TYPE;

BEGIN

    -- Comprobar el stock actual del libro

  SELECT cantidad INTO v_stock_actual FROM Libros WHERE id_libro = :NEW.id_libro;



  -- Si estamos insertando un nuevo préstamo (fecha_devolucion es NULL)

  IF INSERTING AND :NEW.fecha_devolucion IS NULL THEN



    IF v_stock_actual > 0 THEN

      -- Disminuir el stock en 1 unidad

      UPDATE Libros SET cantidad = cantidad - 1 WHERE id_libro = :NEW.id_libro;

    ELSE

      -- Si no hay stock, lanzar una excepción

      RAISE_APPLICATION_ERROR(-20002, 'No hay suficiente stock para realizar el préstamo.');

    END IF;

  END IF;

   

  -- Si estamos actualizando la fecha de devolución (pasando de NULL a un valor)

  IF UPDATING ('fecha_devolucion') AND :OLD.fecha_devolucion IS NULL AND :NEW.fecha_devolucion IS NOT NULL THEN

    -- Aumentar el stock en 1 unidad

    UPDATE Libros SET cantidad = cantidad + 1 WHERE id_libro = :NEW.id_libro;

  END IF;

EXCEPTION

  WHEN NO_DATA_FOUND THEN

    RAISE_APPLICATION_ERROR(-20001, 'El libro no existe.');

END;

/

-- Inserción para la tabla Usuarios
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (13602, 'Adrian Lardies', 1990);

-- Inserción para la tabla Libros
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (13602, 'Siddhartha', 'Hermann Hesse', 5);

-- Inserción para la tabla Préstamos
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (13602, 13602, 13602, TO_DATE('2023-11-08', 'YYYY-MM-DD'), NULL);