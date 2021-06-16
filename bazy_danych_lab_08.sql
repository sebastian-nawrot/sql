-- Zad. 1
INSERT INTO pracownicy
VALUES (250, 'KOWALSKI', 'ASYSTENT', NULL, '2015-01-13', 1500, NULL, 10);

INSERT INTO pracownicy
VALUES (260, 'ADAMSKI', 'ASYSTENT', NULL, '2014-09-10', 1500, NULL, 10);

INSERT INTO pracownicy
VALUES (270, 'NOWAK', 'ADIUNKT', NULL, '1990-05-01', 2050, 540, 20);

SELECT *
FROM pracownicy
WHERE id_prac IN (250, 260, 270);


-- Zad. 2
UPDATE pracownicy
SET placa_pod = (1.1 * placa_pod),
    placa_dod = COALESCE((1.2 * placa_dod), 100)
WHERE id_prac IN (250, 260, 270);

SELECT *
FROM pracownicy
WHERE id_prac IN (250, 260, 270);


-- Zad. 3
INSERT INTO zespoly
VALUES (60, 'BAZY DANYCH', 'PIOTROWO 2');

SELECT *
FROM zespoly
WHERE id_zesp = 60;


-- Zad. 4
UPDATE pracownicy
SET id_zesp =
  (SELECT id_zesp
   FROM zespoly
   WHERE nazwa = 'BAZY DANYCH')
WHERE id_prac IN (250, 260, 270);

SELECT *
FROM pracownicy
WHERE id_zesp =
    (SELECT id_zesp
     FROM zespoly
     WHERE nazwa = 'BAZY DANYCH');


-- Zad. 5
UPDATE pracownicy
SET id_szefa =
  (SELECT id_prac
   FROM pracownicy
   WHERE nazwisko = 'MORZY')
WHERE id_zesp =
    (SELECT id_zesp
     FROM zespoly
     WHERE nazwa = 'BAZY DANYCH');

SELECT *
FROM pracownicy
WHERE id_szefa =
    (SELECT id_prac
     FROM pracownicy
     WHERE nazwisko = 'MORZY');


-- Zad. 6
DELETE
FROM zespoly
WHERE nazwa = 'BAZY DANYCH';
-- ORA-02292: naruszono więzy spójności (BIO145177.FK_ID_ZESP) - znaleziono rekord podrzędny


 -- Zad. 7
DELETE
FROM pracownicy
WHERE id_zesp =
    (SELECT id_zesp
     FROM zespoly
     WHERE nazwa = 'BAZY DANYCH');

DELETE
FROM zespoly
WHERE nazwa = 'BAZY DANYCH';

SELECT *
FROM pracownicy
WHERE id_zesp =
    (SELECT id_zesp
     FROM zespoly
     WHERE nazwa = 'BAZY DANYCH');

SELECT *
FROM zespoly
WHERE nazwa = 'BAZY DANYCH';


-- Zad. 8
SELECT nazwisko,
       placa_pod,
  (SELECT 0.1 * AVG(placa_pod)
   FROM pracownicy p
   WHERE p.id_zesp = p2.id_zesp) AS podwyzka
FROM pracownicy p2
ORDER BY nazwisko;


-- Zad. 9
UPDATE pracownicy p
SET placa_pod = placa_pod +
  (SELECT 0.1 * AVG(placa_pod)
   FROM pracownicy p2
   WHERE p2.id_zesp = p.id_zesp);

SELECT nazwisko,
       placa_pod
FROM pracownicy
ORDER BY nazwisko;


-- Zad. 10
SELECT *
FROM pracownicy
WHERE placa_pod =
    (SELECT MIN(placa_pod)
     FROM pracownicy);


-- Zad. 11
UPDATE pracownicy
SET placa_pod = ROUND((SELECT AVG(placa_pod) FROM pracownicy), 2)
WHERE placa_pod =
    (SELECT MIN(placa_pod)
     FROM pracownicy);


-- Zad. 12
UPDATE pracownicy
SET placa_dod =
  (SELECT AVG(placa_pod)
   FROM pracownicy
   WHERE id_szefa =
       (SELECT id_prac
        FROM pracownicy
        WHERE nazwisko = 'MORZY'))
WHERE id_zesp = 20;


-- Zad. 13
UPDATE
  (SELECT nazwisko,
          placa_pod
   FROM pracownicy X
   JOIN zespoly Y ON X.id_zesp = Y.id_zesp
   WHERE nazwa = 'SYSTEMY ROZPROSZONE')
SET placa_pod = 1.25 * placa_pod;


-- Zad. 14
DELETE
FROM
  (SELECT p.nazwisko,
          p2.nazwisko AS nazwisko_szefa
   FROM pracownicy p
   JOIN pracownicy p2 ON p.id_szefa = p2.id_prac)
WHERE nazwisko_szefa LIKE 'MORZY';


-- Zad. 15
SELECT *
FROM pracownicy;


-- Zad. 16
CREATE SEQUENCE PRAC_SEQ
START WITH 300 INCREMENT BY 10;


-- Zad. 17
INSERT INTO pracownicy (id_prac, nazwisko, placa_pod)
VALUES (PRAC_SEQ.NEXTVAL, 'TRABCZYNSKI', 1000);


-- Zad. 18
UPDATE pracownicy
SET placa_dod = PRAC_SEQ.CURRVAL
WHERE nazwisko = 'TRABCZYNSKI';


-- Zad. 19
DELETE
FROM pracownicy
WHERE nazwisko = 'TRABCZYNSKI';


-- Zad. 20
CREATE SEQUENCE MALA_SEQ
START WITH 2 INCREMENT BY 2 MAXVALUE 10;

SELECT MALA_SEQ.NEXTVAL
FROM dual;
-- ORA-02287: w tym miejscu numer sekwencji jest niedozwolony


 -- Zad. 21
DROP SEQUENCE MALA_SEQ;