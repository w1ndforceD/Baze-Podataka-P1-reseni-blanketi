--1) a)
--Tabele
CREATE TABLE ODELJENJE
(
    ID NUMBER(10,0) NOT NULL,
    NAZIV NVARCHAR2(50),
    LOKACIJA NVARCHAR2(50),
    CONSTRAINT ODELJENJE_PK PRIMARY KEY (ID),
    CONSTRAINT ODELJENJE_LOK_CHK CHECK (LOKACIJA IN ('Nis','Stokholm'))
);

CREATE TABLE RADNO_MESTO
(
    ID        NUMBER(10,0) NOT NULL,
    NAZIV     NVARCHAR2(50) NOT NULL,
    MIN_PLATA NUMBER(12,2) NOT NULL,
    MAX_PLATA NUMBER(12,2) NOT NULL,
    CONSTRAINT RADNO_MESTO_PK PRIMARY KEY (ID),
    CONSTRAINT RM_PLATA_CHK CHECK (MIN_PLATA <= MAX_PLATA)
);

CREATE TABLE ZAPOSLENI
(
    ID              NUMBER(10,0) NOT NULL,
    IME             NVARCHAR2(20),
    PREZIME         NVARCHAR2(50),
    BRTEL           NVARCHAR2(20),
    DAT_POSTAVLJENJA DATE NOT NULL,
    PLATA           NUMBER(12,2),
    ID_R_MESTO      NUMBER(10,0),
    ID_ODELJENJE    NUMBER(10,0),
    CONSTRAINT ZAPOSLENI_PK PRIMARY KEY (ID),
    CONSTRAINT ZAPOSLENI_RM_FK FOREIGN KEY (ID_R_MESTO) REFERENCES RADNO_MESTO(ID),
    CONSTRAINT ZAPOSLENI_ODELJ_FK FOREIGN KEY (ID_ODELJENJE) REFERENCES ODELJENJE(ID)
);

CREATE TABLE ISTORIJA_RADNIH_MESTA
(
    ID_ZAP      NUMBER(10,0) NOT NULL,
    ID_R_MESTO  NUMBER(10,0) NOT NULL,
    ID_ODELJ    NUMBER(10,0) NOT NULL,
    DATUM_POC   DATE NOT NULL,
    DATUM_KRAJA DATE,
    CONSTRAINT IRM_PK PRIMARY KEY (ID_ZAP, DATUM_POC),
    CONSTRAINT IRM_ZAP_FK FOREIGN KEY (ID_ZAP) REFERENCES ZAPOSLENI(ID),
    CONSTRAINT IRM_RM_FK  FOREIGN KEY (ID_R_MESTO) REFERENCES RADNO_MESTO(ID),
    CONSTRAINT IRM_OD_FK  FOREIGN KEY (ID_ODELJ) REFERENCES ODELJENJE(ID),
    CONSTRAINT IRM_DAT_CHK CHECK (DATUM_KRAJA IS NULL OR DATUM_KRAJA > DATUM_POC)
);

--Unos
INSERT INTO ODELJENJE(ID, NAZIV, LOKACIJA) VALUES (1, 'Proizvodnja', 'Nis');
INSERT INTO ODELJENJE(ID, NAZIV, LOKACIJA) VALUES (2, 'Prodaja', 'Stokholm');
INSERT INTO ODELJENJE(ID, NAZIV, LOKACIJA) VALUES (3, 'Kontrola kvaliteta', 'Nis');
INSERT INTO ODELJENJE(ID, NAZIV, LOKACIJA) VALUES (4, 'Uprava', 'Stokholm');

INSERT INTO RADNO_MESTO(ID, NAZIV, MIN_PLATA, MAX_PLATA) VALUES (1, 'Radnik u proizvodnji', 30000, 50000);
INSERT INTO RADNO_MESTO(ID, NAZIV, MIN_PLATA, MAX_PLATA) VALUES (2, 'Sef smene', 40000, 60000);
INSERT INTO RADNO_MESTO(ID, NAZIV, MIN_PLATA, MAX_PLATA) VALUES (3, 'Kontrolor kvaliteta', 40000, 70000);
INSERT INTO RADNO_MESTO(ID, NAZIV, MIN_PLATA, MAX_PLATA) VALUES (4, 'Prodavac', 40000, 50000);
INSERT INTO RADNO_MESTO(ID, NAZIV, MIN_PLATA, MAX_PLATA) VALUES (5, 'Direktor prodaje', 60000, 100000);
INSERT INTO RADNO_MESTO(ID, NAZIV, MIN_PLATA, MAX_PLATA) VALUES (6, 'Zamenik generalnog direktora', 60000, 100000);
INSERT INTO RADNO_MESTO(ID, NAZIV, MIN_PLATA, MAX_PLATA) VALUES (7, 'Generalni direktor', 100000, 150000);

INSERT INTO ZAPOSLENI VALUES (1, 'Anton', 'Rajsman', '0641234321', '10-JAN-15', 40000, 1, 1);
INSERT INTO ZAPOSLENI VALUES (2, 'Milica', 'Antic', '0634342343', '10-FEB-16', 35000, 1, 1);
INSERT INTO ZAPOSLENI VALUES (3, 'Anita', 'Vesnic', '0643433312', '10-MAR-17', 50000, 2, 1);
INSERT INTO ZAPOSLENI VALUES (4, 'Ivan', 'Vesic', '0634454542', '10-APR-15', 70000, 3, 3);
INSERT INTO ZAPOSLENI VALUES (5, 'Marko', 'Milosevic', '0641122334', '10-MAR-17', 50000, 4, 2);
INSERT INTO ZAPOSLENI VALUES (6, 'Nikola', 'Nikic', '06333424344', '10-JUN-16', 50000, 4, 2);
INSERT INTO ZAPOSLENI VALUES (7, 'Igor', 'Denic', '06499876766', '10-JAN-15', 90000, 5, 2);
INSERT INTO ZAPOSLENI VALUES (8, 'Bojan', 'Banic', '06043223341', '10-FEB-15', 100000, 6, 4);
INSERT INTO ZAPOSLENI VALUES (9, 'Mirko', 'Kosanovic', '06955423322', '10-MAR-15', 120000, 7, 4);
                     
INSERT INTO ISTORIJA_RADNIH_MESTA(ID_ZAP, ID_R_MESTO, ID_ODELJ, DATUM_POC, DATUM_KRAJA) VALUES (3, 1, 1, '10-JAN-16', '10-JAN-17');
INSERT INTO ISTORIJA_RADNIH_MESTA(ID_ZAP, ID_R_MESTO, ID_ODELJ, DATUM_POC, DATUM_KRAJA) VALUES (3, 3, 3, '10-JAN-17', '10-FEB-17');
INSERT INTO ISTORIJA_RADNIH_MESTA(ID_ZAP, ID_R_MESTO, ID_ODELJ, DATUM_POC, DATUM_KRAJA) VALUES (4, 1, 1, '10-JAN-16', '10-JAN-17');
INSERT INTO ISTORIJA_RADNIH_MESTA(ID_ZAP, ID_R_MESTO, ID_ODELJ, DATUM_POC, DATUM_KRAJA) VALUES (5, 3, 3, '10-JAN-16', '10-JAN-17');
INSERT INTO ISTORIJA_RADNIH_MESTA(ID_ZAP, ID_R_MESTO, ID_ODELJ, DATUM_POC, DATUM_KRAJA) VALUES (6, 3, 3, '10-JAN-16', '10-APR-16');
INSERT INTO ISTORIJA_RADNIH_MESTA(ID_ZAP, ID_R_MESTO, ID_ODELJ, DATUM_POC, DATUM_KRAJA) VALUES (7, 4, 2, '10-JAN-13', '10-JAN-14');
INSERT INTO ISTORIJA_RADNIH_MESTA(ID_ZAP, ID_R_MESTO, ID_ODELJ, DATUM_POC, DATUM_KRAJA) VALUES (8, 4, 2, '10-JAN-13', '10-JAN-14');
INSERT INTO ISTORIJA_RADNIH_MESTA(ID_ZAP, ID_R_MESTO, ID_ODELJ, DATUM_POC, DATUM_KRAJA) VALUES (8, 5, 2, '10-JAN-14', '10-JAN-15');
INSERT INTO ISTORIJA_RADNIH_MESTA(ID_ZAP, ID_R_MESTO, ID_ODELJ, DATUM_POC, DATUM_KRAJA) VALUES (9, 6, 4, '10-JAN-14', '10-JAN-15');

--2) Napisati SQL upit koji prikazuje nazive svih radnih mesta kod kojih je razlika između minimalne i maksimalne zarade veda od 30000. Podatke sortirati u opadajudi redosled prema razlici između minimalne i maksimalne zarade. (10 poena)
select Naziv
from radno_mesto
where (MAX_PLATA-MIN_PLATA)>30000
order by (MAX_PLATA-MIN_PLATA) DESC

--3) Napisati SQL upit koji prikazuje ime, prezime, naziv odeljenja u kome radi i naziv radnog mesta za svakog zaposlenog koji radi u odeljenju u kome je prosečna plata svih zaposlenih manja od 50000
SELECT z.ime, z.prezime, o.naziv, r.naziv
FROM zaposleni z, odeljenje o, radno_mesto r
WHERE z.id_odeljenje = o.id
  AND z.id_r_mesto = r.id
  AND z.id_odeljenje IN (
        SELECT id_odeljenje
        FROM zaposleni
        GROUP BY id_odeljenje
        HAVING AVG(plata) < 50000
  );

--4) Napisati SQL upit prikazuje naziv radnog mesta na kome je radio najvedi broj različitih zaposlenih, ne računajudi trenutna radna mesta. (15 poena)
SELECT r.naziv
FROM radno_mesto r, istorija_radnih_mesta i
WHERE r.id = i.id_r_mesto
GROUP BY r.naziv
HAVING COUNT(DISTINCT i.id_zap) = (
    SELECT MAX(CNT)
    FROM (
        SELECT COUNT(DISTINCT id_zap) AS CNT
        FROM istorija_radnih_mesta
        GROUP BY id_r_mesto
    )
);

--5) Napisati SQL upit koji prikazije nazive radnih mesta na kojima je radio bar jedan zaposleni koji  trenutno radi u odeljenju "Prodaja" i nikada nije radio nijedan zaposleni koji trenutno radi u  odeljenju "Uprava".
SELECT r.naziv
FROM radno_mesto r
WHERE EXISTS (
        SELECT 1
        FROM istorija_radnih_mesta i, zaposleni z, odeljenje o
        WHERE i.id_r_mesto = r.id
          AND i.id_zap = z.id
          AND z.id_odeljenje = o.id
          AND o.naziv = 'Prodaja'
      )
  AND NOT EXISTS (
        SELECT 1
        FROM istorija_radnih_mesta i, zaposleni z, odeljenje o
        WHERE i.id_r_mesto = r.id
          AND i.id_zap = z.id
          AND z.id_odeljenje = o.id
          AND o.naziv = 'Uprava'
      );
      
