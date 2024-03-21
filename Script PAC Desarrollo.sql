-- Creación de la tabla Usuarios
CREATE TABLE Usuarios (
  id_usuario NUMBER PRIMARY KEY, -- Identificador único para cada usuario, clave primaria de la tabla.
  nombre_completo VARCHAR2(200), -- Nombre completo del usuario, permite hasta 200 caracteres.
  anio_nacimiento INT  -- Año de nacimiento del usuario
);

-- Creación de la tabla Libros
CREATE TABLE Libros (
  id_libro NUMBER PRIMARY KEY, -- Identificador único para cada libro, clave primaria de la tabla.
  titulo VARCHAR2(100), -- Título del libro, permite hasta 100 caracteres.
  autor VARCHAR2(100), -- Autor del libro, permite hasta 100 caracteres.
  cantidad NUMBER CHECK (cantidad >= 0) -- Cantidad de ejemplares del libro en la biblioteca, no puede ser negativa.
);

-- Creación de la tabla Prestamos
CREATE TABLE Prestamos (
  id_prestamo NUMBER PRIMARY KEY, -- Identificador único para cada préstamo, clave primaria de la tabla.
  id_usuario NUMBER, -- Identificador del usuario que realiza el préstamo, clave foránea que referencia a Usuarios.
  id_libro NUMBER, -- Identificador del libro prestado, clave foránea que referencia a Libros.
  fecha_prestamo DATE NOT NULL, -- Fecha en la que se realizó el préstamo, no pude ser NULL.
  fecha_devolucion DATE, -- Fecha en la que se devolvió el libro, puede ser NULL si el libro aún no se ha devuelto.
  FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario), -- Relación de clave foránea con la tabla Usuarios.
  FOREIGN KEY (id_libro) REFERENCES Libros(id_libro) -- Relación de clave foránea con la tabla Libros.
);

-- Inserciones para la tabla Usuarios
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (1, 'Ana Ruiz', 1985);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (2, 'Carlos López', 1972);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (3, 'Marta Hernández', 1990);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (4, 'David Jiménez', 2000);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (5, 'Lucía González', 1995);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (6, 'Sergio Martínez', 1988);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (7, 'María Fernández', 1975);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (8, 'Pablo Rodríguez', 1965);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (9, 'Sandra Gómez', 1982);
INSERT INTO Usuarios (id_usuario, nombre_completo, anio_nacimiento) VALUES (10, 'Raúl Navarro', 1999);

-- Inserciones para la tabla Libros
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (1, 'Cien años de soledad', 'Gabriel García Márquez', 3);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (2, '1984', 'George Orwell', 5);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (3, 'Don Quijote de la Mancha', 'Miguel de Cervantes', 2);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (4, 'El principito', 'Antoine de Saint-Exupéry', 4);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (5, 'Sapiens: De animales a dioses', 'Yuval Noah Harari', 6);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (6, 'La sombra del viento', 'Carlos Ruiz Zafón', 1);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (7, 'El señor de los anillos', 'J.R.R. Tolkien', 3);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (8, 'Harry Potter y la piedra filosofal', 'J.K. Rowling', 7);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (9, 'El código Da Vinci', 'Dan Brown', 2);
INSERT INTO Libros (id_libro, titulo, autor, cantidad) VALUES (10, 'El alquimista', 'Paulo Coelho', 5);

-- Inserciones para la tabla Préstamos
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (1, 1, 5, TO_DATE('2023-09-01', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (2, 2, 3, TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2023-09-19', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (3, 3, 7, TO_DATE('2023-09-10', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (4, 4, 2, TO_DATE('2023-09-15', 'YYYY-MM-DD'), TO_DATE('2023-09-25', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (5, 5, 1, TO_DATE('2023-09-20', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (6, 6, 4, TO_DATE('2023-09-25', 'YYYY-MM-DD'), TO_DATE('2023-10-15', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (7, 7, 8, TO_DATE('2023-09-30', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (8, 8, 6, TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2023-10-11', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (9, 9, 10, TO_DATE('2023-10-03', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (10, 10, 9, TO_DATE('2023-10-07', 'YYYY-MM-DD'), TO_DATE('2023-10-19', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (11, 1, 2, TO_DATE('2023-10-10', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (12, 2, 1, TO_DATE('2023-10-12', 'YYYY-MM-DD'), TO_DATE('2023-10-28', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (13, 3, 4, TO_DATE('2023-10-14', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (14, 4, 7, TO_DATE('2023-10-16', 'YYYY-MM-DD'), TO_DATE('2023-10-26', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (15, 5, 6, TO_DATE('2023-10-18', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (16, 6, 3, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-10-30', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (17, 7, 5, TO_DATE('2023-10-22', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (18, 8, 9, TO_DATE('2023-10-24', 'YYYY-MM-DD'), TO_DATE('2023-11-09', 'YYYY-MM-DD'));
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (19, 9, 8, TO_DATE('2023-10-26', 'YYYY-MM-DD'), NULL);
INSERT INTO Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion) VALUES (20, 10, 10, TO_DATE('2023-10-28', 'YYYY-MM-DD'), TO_DATE('2023-11-18', 'YYYY-MM-DD'));
