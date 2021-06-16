-- Zad. 1
SELECT *
FROM zespoly
WHERE id_zesp NOT IN
    (SELECT id_zesp
     FROM pracownicy
     WHERE id_zesp IS NOT NULL);

-- Zad. 2
SELECT nazwisko,
       placa_pod,
       etat
FROM pracownicy p
WHERE placa_pod >
    (SELECT avg(placa_pod)
     FROM pracownicy
     GROUP BY etat
     HAVING p.etat = etat)
ORDER BY placa_pod DESC;

-- Zad. 3
SELECT nazwisko,
       placa_pod
FROM pracownicy p
WHERE placa_pod >=
    (SELECT 0.75 * placa_pod
     FROM pracownicy
     WHERE id_prac = p.id_szefa)
ORDER BY nazwisko ASC;

-- Zad. 4
SELECT nazwisko
FROM pracownicy p
WHERE etat = 'PROFESOR'
  AND id_prac NOT IN
    (SELECT id_szefa
     FROM pracownicy
     WHERE id_szefa = p.id_prac
       AND etat = 'STAZYSTA');

-- Zad. 5
SELECT nazwa,
       maks_suma_placa
FROM (
        (SELECT max(sum(placa_pod)) AS maks_suma_placa
         FROM pracownicy
         GROUP BY id_zesp)
      INNER JOIN
        (SELECT id_zesp,
                sum(placa_pod) AS suma_plac
         FROM pracownicy
         GROUP BY id_zesp) ON maks_suma_placa = suma_plac) NATURAL
INNER JOIN zespoly;

-- Zad. 6
SELECT nazwisko,
       placa_pod
FROM pracownicy p
WHERE 3 >=
    (SELECT count(placa_pod)
     FROM pracownicy
     WHERE placa_pod >= p.placa_pod)
ORDER BY placa_pod DESC;

-- Zad. 7
SELECT to_char(zatrudniony, 'YYYY') AS rok,
       count(*) AS liczba
FROM pracownicy
GROUP BY to_char(zatrudniony, 'YYYY')
ORDER BY liczba DESC;

-- Zad. 8
SELECT to_char(zatrudniony, 'YYYY') AS rok,
       count(*) AS liczba
FROM pracownicy
GROUP BY to_char(zatrudniony, 'YYYY')
HAVING count(*) =
  (SELECT max(count(*))
   FROM pracownicy
   GROUP BY extract(YEAR
                    FROM zatrudniony));

-- Zad. 9.1
SELECT nazwisko,
       placa_pod,

  (SELECT p.placa_pod - avg(placa_pod)
   FROM pracownicy
   GROUP BY id_zesp
   HAVING id_zesp = p.id_zesp) AS roznica
FROM pracownicy p;

-- Zad. 9.2
SELECT nazwisko,
       placa_pod,
       (placa_pod - srednia) AS roznica
FROM
  (SELECT id_zesp,
          avg(placa_pod) AS srednia
   FROM pracownicy
   GROUP BY id_zesp) p
INNER JOIN pracownicy p2 ON p.id_zesp = p2.id_zesp;

-- Zad. 10.1
SELECT nazwisko,
       placa_pod,

  (SELECT p.placa_pod - avg(placa_pod)
   FROM pracownicy
   GROUP BY id_zesp
   HAVING id_zesp = p.id_zesp) AS roznica
FROM pracownicy p
WHERE (placa_pod -
         (SELECT avg(placa_pod)
          FROM pracownicy
          GROUP BY id_zesp
          HAVING id_zesp = p.id_zesp)) > 0;

-- Zad. 10.2
SELECT nazwisko,
       placa_pod,
       (placa_pod - srednia) AS roznica
FROM
  (SELECT id_zesp,
          avg(placa_pod) AS srednia
   FROM pracownicy
   GROUP BY id_zesp) p
INNER JOIN pracownicy p2 ON p.id_zesp = p2.id_zesp
WHERE (placa_pod - srednia) > 0;

-- Zad. 11
SELECT nazwisko,

  (SELECT count(*)
   FROM pracownicy
   WHERE id_szefa = p.id_prac) AS podwladni
FROM pracownicy p
JOIN zespoly p2 ON p.id_zesp = p2.id_zesp
WHERE etat = 'PROFESOR'
  AND adres LIKE 'PIOTROWO 3A'
ORDER BY podwladni DESC;

-- Zad. 12
SELECT *
FROM etaty e
ORDER BY
  (SELECT count(*)
   FROM pracownicy
   WHERE etat = e.nazwa) DESC, nazwa;