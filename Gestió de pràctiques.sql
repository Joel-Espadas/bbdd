DROP DATABASE IF EXISTS gestio_practiques;
CREATE DATABASE gestio_practiques;
USE gestio_practiques;

CREATE TABLE IF NOT EXISTS alumne (
    id_alumne INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_alumne VARCHAR(30),
    cognom_alumne VARCHAR(30),
    dataNaixement_alumne DATETIME,
    email_alumne VARCHAR(50),
    tlf_alumno CHAR(9),
    cicle_alumne VARCHAR(20),
    curs_alumne VARCHAR(50) NOT NULL,
    tutor_alumne VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS empresa (
    id_empresa INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom_empresa VARCHAR(30),
    direccio_empresa VARCHAR(30),
    tlf_empresa CHAR(9),
    homologat_empresa ENUM('FCT','DUAL'),
    estudis_empresa VARCHAR(30),
    tutor_empresa VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS practica (
    id_practica INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_alumne INT,
    id_empresa INT,
    dataInici_practica DATETIME,
    dataFinal_practica DATETIME,
    totalHores INT,
    homologat_practica ENUM('FCT','DUAL'),
    exempcio_practica ENUM('25%', '50%', '100%'),
    FOREIGN KEY (id_alumne) REFERENCES alumne (id_alumne),
    FOREIGN KEY (id_empresa) REFERENCES empresa (id_empresa)
);

delimiter //
CREATE TRIGGER practica_bi BEFORE INSERT ON practica
  FOR EACH ROW
  BEGIN

IF NEW.dataInici_practica > NOW() THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR! No es pot introduïr una pràctica d'una data anterior a la d'avui';
END IF;
END;
//
delimiter ;
