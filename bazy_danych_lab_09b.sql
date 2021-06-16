-- Zad. 1
ALTER TABLE projekty ADD CONSTRAINT pk_projekty PRIMARY KEY (id_projektu);
ALTER TABLE projekty ADD CONSTRAINT uk_projekty UNIQUE (opis_projektu);
ALTER TABLE projekty MODIFY opis_projektu NOT NULL;
ALTER TABLE projekty ADD CONSTRAINT constraint1 CHECK (data_rozpoczecia < data_zakonczenia);
ALTER TABLE projekty ADD CONSTRAINT constraint2 CHECK (fundusz >= 0 OR fundusz = NULL);

SELECT constraint_name,
       constraint_type,
       search_condition
FROM user_constraints
WHERE table_name = 'PROJEKTY';

-- Zad. 2
INSERT INTO projekty (opis_projektu, data_rozpoczecia, data_zakonczenia, fundusz)
VALUES ('Indeksy bitmapowe', '2015-04-12', '2016-09-30', 40000);
-- ORA-02264: nazwa jest już wykorzystana przez istniejące więzy

-- Zad. 3
CREATE TABLE przydzialy (id_projektu number(4),
                         nr_pracownika number(6),
                         od DATE DEFAULT sysdate,
                         do DATE, stawka number(7, 2),
                         rola varchar2(20 CHAR),
                         CONSTRAINT pk_przydzialy PRIMARY KEY (id_projektu, nr_pracownika),
                         CONSTRAINT fk_przydzialy_01 FOREIGN KEY (id_projektu) REFERENCES projekty(id_projektu),
                         CONSTRAINT fk_przydzialy_02 FOREIGN KEY (nr_pracownika) REFERENCES pracownicy(id_prac),
                         CONSTRAINT chk_przydzialy_daty CHECK (do > od),
                         CONSTRAINT chk_przydzialy_stawka CHECK (stawka > 0),
                         CONSTRAINT chck_przydzialy_rola CHECK (rola IN ('KIERUJĄCY', 'ANALITYK', 'PROGRAMISTA')));

-- Zad. 4
INSERT INTO przydzialy
VALUES ((SELECT id_projektu FROM projekty WHERE opis_projektu = 'Indeksy bitmapowe'), 170, '1999-04-10', '1999-05-10', 1000, 'KIERUJĄCY');

INSERT INTO przydzialy
VALUES ((SELECT id_projektu FROM projekty WHERE opis_projektu = 'Indeksy bitmapowe'), 140, '2000-12-01', NULL, 1500, 'ANALITYK');

INSERT INTO przydzialy
VALUES ((SELECT id_projektu FROM projekty WHERE opis_projektu = 'Sieci kręgoslupowe'), 140, '2015-09-14', NULL, 2500, 'KIERUJĄCY');

-- Zad. 5
ALTER TABLE przydzialy ADD godziny number(4) NOT NULL;
-- ORA-01758: aby dodać obowiązkową kolumnę (NOT NULL) tabela musi być pusta

 -- Zad. 6
ALTER TABLE przydzialy ADD godziny number(4);

UPDATE przydzialy
SET godziny = 100;

ALTER TABLE przydzialy MODIFY godziny number(4) NOT NULL;

-- Zad. 7
ALTER TABLE projekty DISABLE unique(opis_projektu);

-- Zad. 8
INSERT INTO projekty (opis_projektu, data_rozpoczecia, data_zakonczenia, fundusz)
VALUES ('Indeksy bitmapowe', '2015-09-12', '2016-09-30', 40000);

-- Zad. 9
ALTER TABLE projekty ENABLE unique(opis_projektu);
-- ORA-02299: nie można zweryfikować poprawności (BIO145177.UK_PROJEKTY) - znaleziono zduplikowane klucze

-- Zad. 10
UPDATE projekty
SET opis_projektu = 'Inne indeksy'
WHERE fundusz = 40000;

ALTER TABLE projekty ENABLE unique(opis_projektu);

-- Zad. 11
ALTER TABLE projekty MODIFY opis_projektu varchar2(10 CHAR);
--ORA-01441: nie można zmniejszyć długości kolumny, ponieważ niektóre wartości są zbyt duże

 -- Zad. 12
DELETE
FROM projekty
WHERE opis_projektu = 'Sieci kręgoslupowe';
--ORA-02292: naruszono więzy spójności (BIO145177.FK_PRZYDZIALY_01) - znaleziono rekord podrzędny

-- Zad. 13
ALTER TABLE przydzialy
DROP CONSTRAINT fk_przydzialy_01;

ALTER TABLE przydzialy ADD CONSTRAINT fk_przydzialy_01
FOREIGN KEY (id_projektu) REFERENCES projekty(id_projektu) ON
DELETE CASCADE;

-- Zad. 14
DROP TABLE projekty CASCADE CONSTRAINTS;

-- Zad. 15
DROP TABLE przydzialy;
DROP TABLE projekty;