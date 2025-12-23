--TABELE I UNOS--
CREATE TABLE ZAPOSLENI
(
    JMBG VARCHAR2(13) PRIMARY KEY,
    IME VARCHAR2(15) NOT NULL,
    PREZIME VARCHAR2(15) NOT NULL,
    ULICA VARCHAR2(30) NOT NULL,
    BROJ NUMBER(5) NOT NULL,
    MESTO VARCHAR2(30) NOT NULL,
    PLATA NUMBER(7) CHECK (PLATA > 60000)
);

CREATE TABLE KOMPANIJA
(
    IDK NUMBER(5) PRIMARY KEY,
    IMEK VARCHAR2(30) NOT NULL,
    GODINA_OSN NUMBER(4),
    PIB NUMBER(9),
    ADRESA VARCHAR2(50)
);

CREATE TABLE RADNO_MESTO(
    IDK number references KOMPANIJA(IDK),
    ZJMBG varchar(30) references ZAPOSLENI(JMBG),
    POZICIJA varchar(30),
    DATUMOD date,
    DATUMDO date null,
    PRIMARY key (IDK, ZJMBG ,POZICIJA, DATUMOD),
    check (DATUMDO>= DATUMOD)
);


insert into ZAPOSLENI values ('0101965727123', 'Bata', 'Stojkovic', 'Ustanicka', 1, 'Beograd', 75000);
insert into ZAPOSLENI values ('0102985123123', 'Viktor', 'Savic', 'Vuka Karadzica', 12, 'Beograd', 90000);
insert into ZAPOSLENI values ('0101980321321', 'Vuk', 'Kostic', 'Niska', 33, 'Beograd', 80000);
insert into ZAPOSLENI values ('0101988234234', 'Milos', 'Bikovic', 'Milutina Milankovica', 22, 'Beograd', 100000);
insert into ZAPOSLENI values ('0101991567765', 'Aleksandar', 'Radoicic', 'Nikole Tesla', 122, 'Nis', 75000);
insert into ZAPOSLENI values ('0101985345345', 'Maja', 'Mandzuka', 'Aleksandra Medvedeva', 45, 'Nis', 105000);
insert into ZAPOSLENI values ('0101988456456', 'Jelena', 'Gavrilovic', 'Topolska', 4, 'Beograd', 75000);
insert into ZAPOSLENI values ('0101980345543', 'Marija', 'Karan', 'Vozda Karadjordja', 11, 'Nis', 99000);
insert into ZAPOSLENI values ('0101986678678', 'Tamara', 'Dragicevic', 'Beogradska', 33, 'Nis', 75000);

insert into KOMPANIJA values (1, 'Benni', 1996, 103337140, 'Kragujevacki oktobar 55, Nis, Niska Banja 18110');
insert into KOMPANIJA values (2, 'Nectar', 2001, 101922265, 'Kis Ernea 1, 21000 Novi Sad');
insert into KOMPANIJA values (3, 'Coca Cola Srbija', 1990, 100000709, 'BATAJNICKI DRUM 14-16, 11080 ZEMUN');
insert into KOMPANIJA values (4, 'Voda Vrnjci', 2003, 101077432, 'Kneza Milosa 162 36210 Vrnjacka Banja');
insert into KOMPANIJA values (5, 'Knjaz Milos', 1960, 100994867, 'KRCEVAČKI PUT 26, 34300 ARANDJELOVAC');

insert into RADNO_MESTO values (1, '0101965727123', 'prodavac', '01-JAN-2020', null);
insert into RADNO_MESTO values (1, '0102985123123', 'prodavac', '01-JAN-2015', '15-JAN-2020');
insert into RADNO_MESTO values (1, '0101986678678', 'prodavac', '01-JAN-2010', '15-JAN-2015');
insert into RADNO_MESTO values (2, '0101980321321', 'prodavac', '01-JAN-2005', '15-JAN-2015');
insert into RADNO_MESTO values (2, '0101988234234', 'vozac', '01-JAN-2018', null);
insert into RADNO_MESTO values (2, '0101980345543', 'prodavac', '01-JAN-2019', null);
insert into RADNO_MESTO values (3, '0101991567765', 'prodavac', '01-JUN-2018', null);
insert into RADNO_MESTO values (4, '0101985345345', 'horeka', '01-APR-2020', null);
insert into RADNO_MESTO values (4, '0101988456456', 'horeka', '01-JAN-2019', null);
insert into RADNO_MESTO values (4, '0101986678678', 'poslovodja', '16-JAN-2015', '15-JUN-2020');
insert into RADNO_MESTO values (5, '0102985123123', 'poslovodja', '16-JAN-2020', null);
insert into RADNO_MESTO values (5, '0101980321321', 'rukovodilac sektora', '16-JAN-2015', null);
insert into RADNO_MESTO values (5, '0101986678678', 'rukovodilac sektora', '16-JUN-2020', null);

--2) Napisati SQL upit koji za sve kompanije osnovane pre 2000. godine prikazuje ime kompanije, poreski identifikacini broj i broj trenutno zaposlenih osoba u kompaniji. Podatke sortirati u opadajući redosled prema broju zaposlenih u kompaniji. (15 poena)
select k.IMEK,k.PIB, count(z.jmbg) as Broj_zaposlenih
from Kompanija k, Radno_mesto r, zaposleni z
where k.idk=r.idk and z.jmbg=r.zjmbg and k.godina_osn<2000 and DATUMDO is null
group by k.IMEK, k.PIB 
order by count(z.jmbg) DESC

--3) Napisati SQL upit koji prikazuje ime i prezime radnika koji je imao najmanje 2 radna mesta u kompaniji računajući i trenutno radno mesto a nikada nije bio na radnom mestu rukovodioca sektora. (25 poena)
SELECT z.ime, z.prezime
FROM zaposleni z
JOIN radno_mesto r ON r.zjmbg = z.jmbg
GROUP BY z.ime, z.prezime, z.jmbg
HAVING COUNT(*) >= 2
   AND NOT EXISTS (
       SELECT 1
       FROM radno_mesto r2
       WHERE r2.zjmbg = z.jmbg
         AND r2.pozicija = 'rukovodilac%'
   );

--4) Napisati SQL upit prikazuje kompaniju koja trenutno ima najviše zaposlenih. (25 poena) 
select k.imek, count(r.idk)as KLKIMARADNAMESTA
from kompanija k, radno_mesto r
where k.idk=r.idk and r.datumdo is null
group by k.imek
order by KLKIMARADNAMESTA desc
FETCH first 1 row only

--kraj