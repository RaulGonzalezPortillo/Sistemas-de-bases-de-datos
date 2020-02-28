-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: ic18rgp
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Ej1_Alumnos`
--

DROP TABLE IF EXISTS `Ej1_Alumnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ej1_Alumnos` (
  `alumnoId` int(11) NOT NULL AUTO_INCREMENT,
  `nombreAlumno` varchar(30) DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `genero` enum('H','M') DEFAULT NULL,
  PRIMARY KEY (`alumnoId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ej1_Alumnos`
--

LOCK TABLES `Ej1_Alumnos` WRITE;
/*!40000 ALTER TABLE `Ej1_Alumnos` DISABLE KEYS */;
INSERT INTO `Ej1_Alumnos` VALUES (1,'César Mauricio','2000-02-17','H'),(2,'Allan Jair','1994-09-20','H'),(3,'Próculo','1994-10-21','H'),(4,'Herculano','1997-06-09','H'),(5,'Filemón','1998-01-26','H'),(6,'Petronila','1998-04-03','M'),(7,'Pancracia','2000-02-04','M'),(8,'Tiburcio','2001-02-06','H'),(9,'Clodomira','2001-02-28','M'),(10,'Agapito','2001-07-18','H');
/*!40000 ALTER TABLE `Ej1_Alumnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ej1_Ausencias`
--

DROP TABLE IF EXISTS `Ej1_Ausencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ej1_Ausencias` (
  `ausenciaId` int(11) NOT NULL AUTO_INCREMENT,
  `alumnoId` int(11) DEFAULT NULL,
  `fechaAusencia` date DEFAULT NULL,
  PRIMARY KEY (`ausenciaId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ej1_Ausencias`
--

LOCK TABLES `Ej1_Ausencias` WRITE;
/*!40000 ALTER TABLE `Ej1_Ausencias` DISABLE KEYS */;
INSERT INTO `Ej1_Ausencias` VALUES (1,2,'2020-03-18'),(2,5,'2020-03-25'),(3,5,'2020-05-21'),(4,6,'2020-06-24'),(5,3,'2020-08-14');
/*!40000 ALTER TABLE `Ej1_Ausencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ej1_Calificaciones`
--

DROP TABLE IF EXISTS `Ej1_Calificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ej1_Calificaciones` (
  `alumnoId` int(11) NOT NULL,
  `examenId` int(11) NOT NULL,
  `calificacion` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`alumnoId`,`examenId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ej1_Calificaciones`
--

LOCK TABLES `Ej1_Calificaciones` WRITE;
/*!40000 ALTER TABLE `Ej1_Calificaciones` DISABLE KEYS */;
INSERT INTO `Ej1_Calificaciones` VALUES (1,1,9.45),(1,2,8.96),(1,3,6.11),(1,4,6.22),(1,5,8.72),(1,6,8.69),(1,7,6.72),(1,8,5.58),(1,9,9.45),(1,10,8.39),(1,11,9.64),(1,12,8.88),(1,13,9.38),(1,14,9.03),(1,15,5.52),(1,16,7.39),(1,17,7.83),(1,18,7.58),(1,19,9.71),(1,20,8.78),(1,21,8.75),(1,22,7.42),(1,23,6.10),(1,24,8.61),(2,1,7.16),(2,2,6.79),(2,3,5.14),(2,4,9.77),(2,5,6.78),(2,6,7.08),(2,7,6.50),(2,8,9.11),(2,9,6.48),(2,10,6.30),(2,11,9.67),(2,12,9.58),(2,13,7.61),(2,14,6.59),(2,15,6.52),(2,16,8.15),(2,17,9.65),(2,18,7.51),(2,19,6.10),(2,20,9.23),(2,21,9.80),(2,22,7.98),(2,23,8.57),(2,24,8.06),(3,1,5.47),(3,2,6.72),(3,3,6.63),(3,4,9.41),(3,5,8.96),(3,6,10.00),(3,7,8.43),(3,8,5.49),(3,9,5.06),(3,10,6.75),(3,11,7.44),(3,12,7.82),(3,13,5.71),(3,14,5.97),(3,15,6.64),(3,16,9.43),(3,17,7.29),(3,18,8.26),(3,19,8.65),(3,20,6.69),(3,21,8.14),(3,22,8.26),(3,23,6.40),(3,24,7.10),(4,1,9.38),(4,2,8.86),(4,3,8.22),(4,4,6.96),(4,5,7.12),(4,6,9.85),(4,7,5.78),(4,8,7.56),(4,9,9.54),(4,10,9.35),(4,11,6.27),(4,12,7.85),(4,13,5.34),(4,14,6.94),(4,15,8.21),(4,16,6.63),(4,17,6.68),(4,18,8.13),(4,19,6.33),(4,20,9.30),(4,21,9.68),(4,22,6.77),(4,23,9.44),(4,24,6.46),(5,1,6.91),(5,2,9.29),(5,3,7.37),(5,4,6.04),(5,5,6.21),(5,6,6.21),(5,7,5.16),(5,8,6.43),(5,9,5.27),(5,10,7.78),(5,11,9.27),(5,12,9.40),(5,13,8.77),(5,14,6.12),(5,15,7.73),(5,16,5.66),(5,17,8.39),(5,18,8.24),(5,19,5.14),(5,20,8.06),(5,21,6.16),(5,22,6.60),(5,23,8.61),(5,24,8.18),(6,1,8.67),(6,2,9.51),(6,3,8.32),(6,4,8.71),(6,5,9.61),(6,6,5.12),(6,7,8.87),(6,8,7.25),(6,9,6.40),(6,10,8.15),(6,11,7.52),(6,12,9.84),(6,13,7.27),(6,14,7.40),(6,15,7.18),(6,16,7.15),(6,17,8.81),(6,18,8.18),(6,19,5.32),(6,20,8.75),(6,21,9.19),(6,22,9.95),(6,23,8.53),(6,24,6.80),(7,1,6.67),(7,2,6.62),(7,3,8.80),(7,4,5.94),(7,5,5.34),(7,6,8.88),(7,7,5.88),(7,8,5.56),(7,9,7.03),(7,10,8.94),(7,11,9.60),(7,12,7.71),(7,13,9.16),(7,14,6.66),(7,15,6.99),(7,16,8.70),(7,17,5.38),(7,18,7.37),(7,19,5.96),(7,20,7.94),(7,21,8.12),(7,22,7.09),(7,23,7.04),(7,24,8.80),(8,1,6.13),(8,2,6.87),(8,3,7.00),(8,4,6.55),(8,5,5.38),(8,6,6.26),(8,7,5.41),(8,8,8.40),(8,9,7.09),(8,10,5.29),(8,11,8.27),(8,12,5.10),(8,13,6.31),(8,14,9.36),(8,15,7.06),(8,16,6.97),(8,17,9.59),(8,18,5.06),(8,19,6.57),(8,20,5.78),(8,21,9.28),(8,22,7.60),(8,23,5.37),(8,24,7.92),(9,1,6.87),(9,2,5.43),(9,3,5.67),(9,4,6.92),(9,5,6.18),(9,6,8.70),(9,7,7.50),(9,8,6.97),(9,9,5.59),(9,10,6.57),(9,11,6.41),(9,12,5.82),(9,13,5.55),(9,14,9.72),(9,15,7.73),(9,16,5.30),(9,17,9.13),(9,18,5.20),(9,19,9.93),(9,20,7.43),(9,21,6.15),(9,22,7.78),(9,23,7.96),(9,24,5.55),(10,1,7.38),(10,2,6.26),(10,3,6.75),(10,4,9.49),(10,5,9.28),(10,6,7.22),(10,7,5.43),(10,8,9.49),(10,9,8.53),(10,10,8.34),(10,11,6.01),(10,12,5.22),(10,13,8.15),(10,14,7.67),(10,15,6.12),(10,16,7.88),(10,17,5.47),(10,18,9.51),(10,19,5.02),(10,20,5.80),(10,21,5.08),(10,22,6.55),(10,23,8.48),(10,24,8.97);
/*!40000 ALTER TABLE `Ej1_Calificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ej1_Examenes`
--

DROP TABLE IF EXISTS `Ej1_Examenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ej1_Examenes` (
  `examenId` int(11) NOT NULL AUTO_INCREMENT,
  `materiaId` int(11) DEFAULT NULL,
  `tipoId` int(11) DEFAULT NULL,
  `fechaExamen` date DEFAULT NULL,
  PRIMARY KEY (`examenId`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ej1_Examenes`
--

LOCK TABLES `Ej1_Examenes` WRITE;
/*!40000 ALTER TABLE `Ej1_Examenes` DISABLE KEYS */;
INSERT INTO `Ej1_Examenes` VALUES (1,1,1,'2020-02-24'),(2,1,1,'2020-03-04'),(3,1,2,'2020-03-09'),(4,1,2,'2020-03-12'),(5,1,3,'2020-03-13'),(6,1,3,'2020-03-16'),(7,2,1,'2020-04-21'),(8,2,1,'2020-04-30'),(9,2,2,'2020-05-22'),(10,2,2,'2020-05-26'),(11,2,3,'2020-06-23'),(12,2,3,'2020-07-08'),(13,3,1,'2020-07-21'),(14,3,1,'2020-07-22'),(15,3,2,'2020-08-11'),(16,3,2,'2020-08-13'),(17,3,3,'2020-08-19'),(18,3,3,'2020-08-21'),(19,4,1,'2020-09-17'),(20,4,1,'2020-09-25'),(21,4,2,'2020-10-16'),(22,4,2,'2020-10-27'),(23,4,3,'2020-11-19'),(24,4,3,'2020-11-23');
/*!40000 ALTER TABLE `Ej1_Examenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ej1_Materias`
--

DROP TABLE IF EXISTS `Ej1_Materias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ej1_Materias` (
  `materiaId` int(11) NOT NULL AUTO_INCREMENT,
  `nombreMateria` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`materiaId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ej1_Materias`
--

LOCK TABLES `Ej1_Materias` WRITE;
/*!40000 ALTER TABLE `Ej1_Materias` DISABLE KEYS */;
INSERT INTO `Ej1_Materias` VALUES (1,'Ciencia del Cannabis'),(2,'El arte de caminar'),(3,'La religión según Los Simpsons'),(4,'Televisión para ciegos');
/*!40000 ALTER TABLE `Ej1_Materias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ej1_TipoExamen`
--

DROP TABLE IF EXISTS `Ej1_TipoExamen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ej1_TipoExamen` (
  `tipoId` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` enum('S','M','F') DEFAULT NULL,
  PRIMARY KEY (`tipoId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ej1_TipoExamen`
--

LOCK TABLES `Ej1_TipoExamen` WRITE;
/*!40000 ALTER TABLE `Ej1_TipoExamen` DISABLE KEYS */;
INSERT INTO `Ej1_TipoExamen` VALUES (1,'S'),(2,'M'),(3,'F');
/*!40000 ALTER TABLE `Ej1_TipoExamen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `Ej1_vistaEstudiantes`
--

DROP TABLE IF EXISTS `Ej1_vistaEstudiantes`;
/*!50001 DROP VIEW IF EXISTS `Ej1_vistaEstudiantes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `Ej1_vistaEstudiantes` AS SELECT 
 1 AS `nombreAlumno`,
 1 AS `calificacion`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `presidentes`
--

DROP TABLE IF EXISTS `presidentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presidentes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ap_paterno` varchar(30) DEFAULT NULL,
  `ap_materno` varchar(30) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `ciudad` varchar(30) DEFAULT NULL,
  `estado` varchar(15) DEFAULT NULL,
  `nacimiento` date NOT NULL,
  `muerte` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presidentes`
--

LOCK TABLES `presidentes` WRITE;
/*!40000 ALTER TABLE `presidentes` DISABLE KEYS */;
INSERT INTO `presidentes` VALUES (1,'Juárez','García','Benito','San Pablo Guelatao','Oaxaca','1806-03-21','1872-07-18'),(2,'Lerdo de Tejada','y Corral','Sebastián','Jalapa','Veracruz','1823-04-24','1889-04-21'),(3,'Iglesias','Inzurruaga','José María','México','D.F.','1823-01-05','1891-12-17'),(4,'Méndez','Sánchez','Juan Nepomuceno','Tetela de Ocampo','Puebla','1820-07-02','1894-11-29'),(5,'González','Flores','Manuel del Refugio','Matamoros','Tamaulipas','1833-06-17','1893-05-08'),(6,'Díaz','Mori','José de la Cruz Porfirio','Oaxaca','Oaxaca','1830-09-15','1915-07-02'),(7,'León','de la Barca','Francisco','Querétaro','Querétaro','1863-06-16','1939-09-23'),(8,'Madero','González','Francisco Ignacio','Parras','Coahuila','1873-10-30','1913-02-22'),(9,'Lascuráin','Paredes','Pedro José Domingo de la Calzada Manuel María','México','D.F.','1858-05-12','1952-06-21'),(10,'Huerta','Márquez','José Victoriano','Colotlán','Jalisco','1845-03-23','1916-01-03'),(11,'Carbajal','','Francisco Sebastián','Campeche','Campeche','1870-12-09','1932-09-30'),(12,'Carranza','Garza','Venustiano','Cuatro Ciénegas','Coahuila','1859-12-29','1920-05-21'),(13,'Gutiérrez','Ortiz','Eulalio','Ramos Arizpe','Coahuila','1881-02-02','1939-08-12'),(14,'González','Garza','Roque','Saltillo','Coahuila','1885-03-23','1962-11-12'),(15,'Lagos','Cházaro','Francisco','Tlacotalpan','Veracruz','1878-09-30','1932-11-13'),(16,'de la Huerta','Marcor','Felipe Adolfo','Hermosillo','Sonora','1881-05-26','1955-07-09'),(17,'Obregón','Salido','Álvaro','Navojoa','Sonora','1880-02-19','1928-07-17'),(18,'Elías','Calles','Plutarco','Guaymas','Sonora','1877-09-25','1945-10-19'),(19,'Portes','Gil','Emilio','Ciudad Victoria','Tamaulipas','1890-10-03','1978-12-10'),(20,'Ortiz','Rubio','Pascual','Morelia','Michoacán','1877-03-10','1963-11-04'),(21,'Rodríguez','Luján','Abelardo','Guaymas','Sonora','1889-05-12','1967-02-13'),(22,'Cárdenas','Del Río','Lázaro','Jiquilpan','Michoacán','1895-05-21','1970-10-19'),(23,'Ávila','Camacho','Manuel','Tezuitlán','Puebla','1897-04-24','1955-10-13'),(24,'Alemán','Valdés','Miguel','Sayula','Veracruz','1903-09-29','1983-05-14'),(25,'Ruiz','Cortines','Adolfo','Veracruz','Veracruz','1890-12-30','1973-12-03'),(26,'López','Mateos','Adolfo','Atizapán','México','1910-05-26','1969-09-22'),(27,'Díaz','Ordaz','Gustavo','Cd. Serdan','Puebla','1911-03-11','1979-07-15'),(28,'Echeverría','Álvarez','Luis','México','D.F.','1922-01-17',NULL),(29,'López','Portillo','José','México','D.F.','1920-06-16','2004-02-17'),(30,'De la Madrid','Hurtado','Miguel','Colima','Colima','1934-12-12','2012-04-01'),(31,'Salinas','de Gortari','Carlos','México','D.F.','1948-04-03',NULL),(32,'Zedillo','Ponce de León','Ernesto','México','D.F.','1951-12-17',NULL),(33,'Fox','Quezada','Vicente','México','D.F.','1942-07-02',NULL),(34,'Calderón','Hinojosa','Felipe','Morelia','Michoacán','1962-08-18',NULL),(35,'Peña','Nieto','Enrique','Atlacomulco','Mexico','1966-07-20',NULL),(36,'López','Obrador','Andrés Manuel','Macuspana','Tabasco','1953-11-13',NULL);
/*!40000 ALTER TABLE `presidentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ic18rgp'
--

--
-- Dumping routines for database 'ic18rgp'
--
/*!50003 DROP FUNCTION IF EXISTS `edad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ic18rgp`@`localhost` FUNCTION `edad`(date1 date, date2 date) RETURNS int(11)
begin
  declare age int;
  set age = (year(date2) - year(date1)) - if(right(date2, 5) < right(1, 5), 1, 0);
  return age;
  end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `factorial_loop` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ic18rgp`@`localhost` FUNCTION `factorial_loop`(numero INT) RETURNS int(11)
BEGIN
DECLARE resultado, contador INT;
SET resultado = 1;
SET contador = 1;
factorial: LOOP
	SET resultado = resultado * contador;
    SET contador = contador + 1;
    IF (contador > numero) THEN
		LEAVE factorial;
    END IF;
END LOOP factorial;
RETURN resultado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `factorial_repeat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ic18rgp`@`localhost` FUNCTION `factorial_repeat`(numero INT) RETURNS int(11)
BEGIN
	DECLARE resultado, contador INT;
  SET resultado = 1;
  SET contador = 1;
  REPEAT
    SET resultado = resultado * contador;
    SET contador = contador + 1;
  UNTIL contador > numero
  END REPEAT;
RETURN resultado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `factorial_while` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ic18rgp`@`localhost` FUNCTION `factorial_while`(numero INT) RETURNS int(11)
BEGIN
DECLARE resultado, contador INT;
SET resultado = 1;
SET contador = 1;
factorial: WHILE
    contador <= numero DO
		SET resultado = resultado * contador;
		SET contador = contador + 1;
	END WHILE factorial;
RETURN resultado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `potencia_loop` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ic18rgp`@`localhost` FUNCTION `potencia_loop`(base INT, exponente INT) RETURNS int(11)
BEGIN
DECLARE resultado, contador INT;
  SET resultado = 1;
  SET contador = 1;
  potencia: LOOP
    SET resultado = resultado * base;
    SET contador = contador + 1;
    IF contador > exponente THEN
      LEAVE potencia;
    END IF;
  END LOOP potencia;
RETURN resultado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `potencia_repeat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ic18rgp`@`localhost` FUNCTION `potencia_repeat`(base INT, exponente INT) RETURNS int(11)
BEGIN
	DECLARE resultado, contador INT;
    SET resultado = 1;
    SET contador = 1;
    potencia: REPEAT
		SET resultado = resultado * base;
        SET contador = contador + 1;
	UNTIL contador > exponente
    END REPEAT potencia;
RETURN resultado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `potencia_while` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ic18rgp`@`localhost` FUNCTION `potencia_while`(base INT, exponente INT) RETURNS int(11)
BEGIN
	DECLARE resultado, contador INT;
    SET resultado = 1;
    SET contador = 1;
    potencia: WHILE
    contador <= exponente DO
		SET resultado = resultado * base;
        SET contador = contador + 1;
	END WHILE potencia;
RETURN resultado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Ej1_mejorPromedio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ic18rgp`@`localhost` PROCEDURE `Ej1_mejorPromedio`(OUT mejorPromedio DECIMAL(4, 2), OUT mejorAlumno CHAR(40))
BEGIN
	DECLARE salida, calif, contador INT;
    DECLARE nombreAlumnoTemp CHAR(40);
    DECLARE promedio, calTotal DECIMAL(6, 2);
    DECLARE curCalif CURSOR FOR
		SELECT calificacion FROM Ej1_vistaEstudiantes WHERE nombreAlumno = nombreAlumnoTemp;
	DECLARE curAlumnos CURSOR FOR
		SELECT nombreAlumno FROM Ej1_Alumnos;
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET salida = 1;
	SET promedio = 0;
    SET calTotal = 0;
    SET contador = 0;
    SET salida = 0;
    OPEN curAlumnos;
    curAl: REPEAT
		FETCH curAlumnos INTO nombreAlumnoTemp;
        IF salida = 1 THEN
			LEAVE curAl;
		END IF;
        OPEN curCalif;
        curCal: REPEAT
			FETCH curCalif INTO calif;
            IF Salida = 1 THEN
				LEAVE curCal;
			END IF;
            SET calTotal = calTotal + calif;
            SET contador = contador + 1;
		UNTIL salida = 1
        END REPEAT curCal;
        CLOSE curCalif;
        SET salida = 0;
        IF contador > 0 THEN
			SET calTotal = calTotal / contador;
		END IF;
        IF promedio < calTotal THEN
			SET mejorAlumno = nombreAlumnoTemp;
            SET promedio = calTotal;
		END IF;
	UNTIL salida = 1
    END REPEAT curAl;
    CLOSE curAlumnos;
    SET mejorPromedio = promedio;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Ej1_mejorPromedioOptimizado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ic18rgp`@`localhost` PROCEDURE `Ej1_mejorPromedioOptimizado`(OUT mejorPromedio DECIMAL(4, 2), OUT mejorAlumno CHAR(40))
BEGIN
	DECLARE salida INT;
    DECLARE nombreAlumnoTemp CHAR(40);
    DECLARE promedioTemp DECIMAL(4, 2);
    DECLARE curPromedio CURSOR FOR
		SELECT AVG(calificacion), nombreAlumno FROM Ej1_vistaEstudiantes GROUP BY nombreAlumno;
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET salida = 1;
	SET mejorPromedio = 0;
    SET salida = 0;
    OPEN curPromedio;
    curPr: REPEAT
		FETCH curPromedio INTO promedioTemp, nombreAlumnoTemp;
        IF salida = 1 THEN
			LEAVE curPr;
		END IF;
		IF mejorPromedio < promedioTemp THEN
			SET mejorAlumno = nombreAlumnoTemp;
            SET mejorPromedio = promedioTemp;
		END IF;
	UNTIL salida = 1
    END REPEAT curPr;
    CLOSE curPromedio;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `nacio_en_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ic18rgp`@`localhost` PROCEDURE `nacio_en_anio`(anio_nacimiento int)
select nombre, ap_paterno, nacimiento, muerte from presidentes where year(nacimiento) = anio_nacimiento ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `Ej1_vistaEstudiantes`
--

/*!50001 DROP VIEW IF EXISTS `Ej1_vistaEstudiantes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ic18rgp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Ej1_vistaEstudiantes` AS select `Ej1_Alumnos`.`nombreAlumno` AS `nombreAlumno`,`Ej1_Calificaciones`.`calificacion` AS `calificacion` from (`Ej1_Alumnos` left join `Ej1_Calificaciones` on((`Ej1_Alumnos`.`alumnoId` = `Ej1_Calificaciones`.`alumnoId`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-28  8:32:44
