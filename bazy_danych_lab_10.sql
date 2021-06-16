-- Zad. 1
CREATE VIEW asystenci (nazwisko, placa, staz) AS
SELECT nazwisko,
       placa_pod + placa_dod,
       DATE '2021-01-01' - zatrudniony
FROM pracownicy;

-- Zad. 2
CREATE VIEW place (id_zesp, srednia, minimum, maximum, fundusz, l_pensji, l_dodatkow) AS
SELECT id_zesp,
       avg(placa_pod + placa_dod),
       min(placa_pod + placa_dod),
       max(placa_pod + placa_dod),
       sum(placa_pod + placa_dod),
       count(placa_pod),
       count(placa_dod)
FROM pracownicy
GROUP BY id_zesp;

-- Zad. 3
SELECT nazwisko,
       placa_pod
FROM pracownicy p
JOIN place p2 ON p.id_zesp = p2.id_zesp
WHERE p.placa_pod < p2.srednia;

-- Zad. 4
CREATE VIEW place_minimalne AS
SELECT id_prac,
       nazwisko,
       etat,
       placa_pod
FROM pracownicy
WHERE placa_pod < 700 WITH CHECK OPTION CONSTRAINT za_wysoka_placa;

-- Zad. 5
UPDATE place_minimalne
SET placa_pod = 800
WHERE id_prac =
    (SELECT id_prac
     FROM pracownicy
     WHERE nazwisko = 'HAPKE');
--ORA-01402: naruszenie klauzuli WHERE dla perspektywy z WITH CHECK OPTION

 -- Zad. 6
CREATE VIEW prac_szef AS
SELECT p.id_prac,
       p.id_szefa,
       p.nazwisko,
       p.etat,
       p2.nazwisko AS szef
FROM pracownicy p
LEFT JOIN pracownicy p2 ON p.id_szefa = p2.id_prac;

-- Zad. 7
CREATE VIEW zarobki AS
SELECT p.id_prac,
       p.nazwisko,
       p.etat,
       p.placa_pod
FROM pracownicy p
LEFT JOIN pracownicy p2 ON p.id_szefa = p2.id_prac
WHERE p.placa_pod < p2.placa_pod WITH CHECK OPTION CONSTRAINT za_wysoka_placa2;

-- Zad. 8
SELECT COLUMN_NAME,
       updatable,
       insertable,
       deletable
FROM user_updatable_columns
WHERE TABLE_NAME = 'PRAC_SZEF';