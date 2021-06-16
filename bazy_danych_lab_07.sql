-- Zad. 1.1
SELECT nazwisko,
       placa_pod
FROM pracownicy
ORDER BY placa_pod DESC FETCH FIRST 3 ROWS ONLY;

-- Zad. 1.2
SELECT nazwisko,
       placa_pod
FROM
  (SELECT nazwisko,
          placa_pod
   FROM pracownicy
   ORDER BY placa_pod DESC)
WHERE ROWNUM <= 3;

-- Zad. 2.1
SELECT nazwisko,
       placa_pod
FROM pracownicy
ORDER BY placa_pod DESC
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;

-- Zad. 2.2
SELECT nazwisko,
       placa_pod
FROM
  (SELECT *
   FROM
     (SELECT *
      FROM
        (SELECT *
         FROM pracownicy
         ORDER BY placa_pod DESC)
      WHERE ROWNUM <= 10)
   ORDER BY placa_pod ASC)
WHERE ROWNUM <= 5
ORDER BY placa_pod DESC;

-- Zad. 3
WITH srednia_placa AS
  (SELECT id_zesp,
          AVG(placa_pod) AS srednia
   FROM pracownicy
   GROUP BY id_zesp)
SELECT nazwisko,
       placa_pod,
       (placa_pod - srednia) AS ROZNICA
FROM pracownicy
NATURAL JOIN srednia_placa
WHERE (placa_pod - srednia) > 0
ORDER BY nazwisko;

-- Zad. 4
WITH zatrudnieni_lata AS
  (SELECT TO_CHAR(zatrudniony, 'YYYY') AS rok,
          COUNT(*) AS liczba
   FROM pracownicy
   GROUP BY TO_CHAR(zatrudniony, 'YYYY'))
SELECT *
FROM zatrudnieni_lata
ORDER BY liczba DESC;

-- Zad. 5
WITH zatrudnieni_lata AS
  (SELECT TO_CHAR(zatrudniony, 'YYYY') AS rok,
          COUNT(*) AS liczba
   FROM pracownicy
   GROUP BY TO_CHAR(zatrudniony, 'YYYY'))
SELECT *
FROM zatrudnieni_lata
ORDER BY liczba DESC FETCH FIRST 1 ROWS ONLY;

-- Zad. 6
WITH asystenci AS
  (SELECT nazwisko,
          etat,
          id_zesp
   FROM pracownicy
   WHERE etat = 'ASYSTENT'),
     zespoly_piotrowo AS
  (SELECT nazwa,
          adres,
          id_zesp
   FROM ZESPOLY
   WHERE adres = 'PIOTROWO 3A')
SELECT nazwisko,
       etat,
       nazwa,
       adres
FROM asystenci
NATURAL JOIN zespoly_piotrowo;

-- Zad. 7
WITH maks_sumy_plac AS
  (SELECT id_zesp,
          SUM(placa_pod) AS maks_suma_plac
   FROM pracownicy
   GROUP BY id_zesp)
SELECT nazwa,
       maks_suma_plac
FROM maks_sumy_plac
NATURAL JOIN ZESPOLY FETCH FIRST 1 ROWS ONLY;

-- Zad. 8.1
WITH podwladni(id_prac, id_szefa, nazwisko, pozycja_w_hierarchii) AS
  (SELECT id_prac,
          id_szefa,
          nazwisko,
          1 AS pozycja_w_hierarchii
   FROM pracownicy
   WHERE nazwisko = 'BRZEZINSKI'
   UNION ALL SELECT p2.id_prac,
                    p2.id_szefa,
                    p2.nazwisko,
                    pozycja_w_hierarchii + 1
   FROM podwladni p1
   JOIN pracownicy p2 ON p1.id_prac = p2.id_szefa) SEARCH DEPTH FIRST BY nazwisko
SET scalone
SELECT nazwisko,
       pozycja_w_hierarchii
FROM podwladni
ORDER BY scalone;

-- Zad. 8.2
SELECT nazwisko,
       LEVEL AS pozycja_w_hierarchii
FROM pracownicy CONNECT BY id_szefa =
PRIOR id_prac
START WITH nazwisko = 'BRZEZINSKI'
ORDER SIBLINGS BY nazwisko;

-- Zad. 9.1
WITH podwladni(id_prac, id_szefa, nazwisko, pozycja_w_hierarchii) AS
  (SELECT id_prac,
          id_szefa,
          nazwisko,
          1 AS pozycja_w_hierarchii
   FROM pracownicy
   WHERE nazwisko = 'BRZEZINSKI'
   UNION ALL SELECT p2.id_prac,
                    p2.id_szefa,
                    p2.nazwisko,
                    pozycja_w_hierarchii + 1
   FROM podwladni p1
   JOIN pracownicy p2 ON p1.id_prac = p2.id_szefa) SEARCH DEPTH FIRST BY nazwisko
SET scalone
SELECT LPAD(nazwisko, LENGTH(nazwisko) + (pozycja_w_hierarchii - 1), ' ') AS nazwisko,
       pozycja_w_hierarchii
FROM podwladni
ORDER BY scalone;