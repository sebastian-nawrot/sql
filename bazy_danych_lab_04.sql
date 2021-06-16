-- Zad. 1
SELECT min(placa_pod) AS minimum,
       max(placa_pod) AS maksimum,
       max(placa_pod) - min(placa_pod) AS roznica
FROM pracownicy;

-- Zad. 2
SELECT etat,
       avg(placa_pod) AS srednia
FROM pracownicy
GROUP BY etat
ORDER BY srednia DESC;

-- Zad. 3
SELECT count(etat) AS profesorowie
FROM pracownicy
WHERE etat = 'PROFESOR'
GROUP BY etat;

-- Zad. 4
SELECT id_zesp,
       sum(placa_pod) + sum(placa_dod) AS sumaryczne_place
FROM pracownicy
GROUP BY id_zesp
ORDER BY id_zesp;

-- Zad. 5
SELECT max(sum(placa_pod) + sum(placa_dod)) AS maks_sum_placa
FROM pracownicy
GROUP BY id_zesp
ORDER BY id_zesp;

-- Zad. 6
SELECT id_szefa,
       min(placa_pod) AS minimalna
FROM pracownicy
WHERE id_szefa IS NOT NULL
GROUP BY id_szefa
ORDER BY minimalna DESC;

-- Zad. 7
SELECT id_zesp,
       count(*) AS ilu_pracuje
FROM pracownicy
HAVING ilu_pracuje > 3
GROUP BY id_zesp
ORDER BY ilu_pracuje DESC;

-- Zad. 8
SELECT id_zesp,
       count(*) AS ilu_pracuje
FROM pracownicy
GROUP BY id_zesp
HAVING count(*) > 3
ORDER BY ilu_pracuje DESC;

-- Zad. 9
SELECT id_prac,
       count(*)
FROM pracownicy
GROUP BY id_prac
HAVING count(*) > 1;

-- Zad. 10
SELECT etat,
       avg(placa_pod) AS srednia,
       count(*) AS liczba
FROM pracownicy
WHERE zatrudniony < DATE '1990-01-01'
GROUP BY etat;

-- Zad. 11
SELECT id_zesp,
       etat,
       floor(avg(coalesce(placa_pod, 0) + coalesce(placa_dod, 0))) AS srednia,
       floor(max(coalesce(placa_pod, 0) + coalesce(placa_dod, 0))) AS maksymalna
FROM pracownicy
WHERE etat = 'PROFESOR'
  OR etat = 'ASYSTENT'
GROUP BY id_zesp,
         etat
ORDER BY id_zesp,
         etat;

-- Zad. 12
SELECT extract(YEAR FROM zatrudniony) AS rok,
       count(*)
FROM pracownicy
GROUP BY extract(YEAR FROM zatrudniony)
ORDER BY extract(YEAR FROM zatrudniony);

-- Zad. 13
SELECT length(nazwisko) AS ile_liter,
       count(*) AS w_ilu_nazwiskach
FROM pracownicy
GROUP BY length(nazwisko)
ORDER BY ile_liter;

-- Zad. 14
SELECT count(*) AS ile_nazwisk_z_a
FROM pracownicy
WHERE (nazwisko LIKE '%a%'
       OR nazwisko LIKE '%A%');

-- Zad. 15
SELECT DISTINCT
  (SELECT count(*)
   FROM pracownicy
   WHERE (nazwisko LIKE '%a%'
          OR nazwisko LIKE '%A%')) AS ile_nazwisk_z_a,

  (SELECT count(*)
   FROM pracownicy
   WHERE (nazwisko LIKE '%e%'
          OR nazwisko LIKE '%E%')) AS ile_nazwisk_z_e
FROM pracownicy;

-- Zad. 16
SELECT id_zesp,
       sum(placa_pod) AS suma_plac,
       listagg(nazwisko || ':' || placa_pod, ';') within GROUP (
                                                                ORDER BY nazwisko) AS pracownicy
FROM pracownicy
GROUP BY id_zesp
ORDER BY id_zesp;