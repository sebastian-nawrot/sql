-- Zad. 1
CREATE TABLE projekty (id_projektu NUMBER(4) GENERATED ALWAYS AS IDENTITY,
                       opis_projektu VARCHAR2(20 CHAR),
                       data_rozpoczecia DATE DEFAULT SYSDATE,
                       data_zakonczenia DATE, fundusz NUMBER(7, 2));


-- Zad. 2
INSERT INTO projekty (opis_projektu, data_rozpoczecia, data_zakonczenia, fundusz)
VALUES ('Indeksy bitmapowe', '1999-04-02', '2001-08-31', 25000);

INSERT INTO projekty (opis_projektu, data_rozpoczecia, data_zakonczenia, fundusz)
VALUES ('Sieci kręgoslupowe', '2001-08-31', NULL, 19000);


-- Zad. 3
SELECT *
FROM projekty;


-- Zad. 4
INSERT INTO projekty (id_projektu, opis_projektu, data_rozpoczecia, data_zakonczenia, fundusz)
VALUES (10, 'Indeksy drzewiaste', '2013-12-24', '2014-01-01', 1200);
-- ORA-32795: nie można wstawić do kolumny tożsamości utworzonej jako GENERATED ALWAYS


-- Zad. 5
UPDATE projekty
SET id_projektu = 10
WHERE opis_projektu = 'Indeksy drzewiaste';
-- ORA-32796: nie można zaktualizować kolumny tożsamości utworzonej jako GENERATED ALWAYS


-- Zad. 6
CREATE TABLE projekty_kopia AS
SELECT *
FROM projekty;


-- Zad. 7
INSERT INTO projekty_kopia
VALUES (10, 'Sieci lokalne', SYSDATE, SYSDATE + interval '1' YEAR, 24500);
-- Atrybut GENERATED ALWAYS AS IDENTITY nie został skopiowany razem z relacją


-- Zad. 8
DELETE
FROM projekty
WHERE opis_projektu = 'Indeksy drzewiaste';


-- Zad. 9
SELECT TABLE_NAME
FROM user_tables;