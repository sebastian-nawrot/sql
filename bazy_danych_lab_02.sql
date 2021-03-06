-- Zad. 1
SELECT *
FROM zespoly
ORDER BY id_zesp ASC;

-- Zad. 2
SELECT *
FROM pracownicy
ORDER BY id_prac ASC;

-- Zad. 3
SELECT nazwisko,
       placa_pod * 12
FROM pracownicy
ORDER BY nazwisko;

-- Zad. 4
SELECT nazwisko,
       etat,
       placa_pod + coalesce(placa_dod, 0) AS miesieczne_zarobki
FROM pracownicy
ORDER BY miesieczne_zarobki DESC;

-- Zad. 5
SELECT *
FROM zespoly
ORDER BY nazwa ASC;

-- Zad. 6
SELECT DISTINCT etat
FROM pracownicy
ORDER BY etat ASC;

-- Zad. 7
SELECT *
FROM pracownicy
WHERE etat = 'ASYSTENT'
ORDER BY nazwisko ASC;

-- Zad. 8
SELECT id_prac,
       nazwisko,
       etat,
       placa_pod,
       id_zesp
FROM pracownicy
WHERE id_zesp IN (30, 40)
ORDER BY placa_pod DESC;

-- Zad. 9
SELECT nazwisko,
       id_zesp,
       placa_pod
FROM pracownicy
WHERE placa_pod BETWEEN 300 AND 800
ORDER BY nazwisko ASC;

-- Zad. 10
SELECT nazwisko,
       etat,
       id_zesp
FROM pracownicy
WHERE nazwisko LIKE '%SKI'
ORDER BY nazwisko ASC;

-- Zad. 11
SELECT id_prac,
       id_szefa,
       nazwisko,
       placa_pod
FROM pracownicy
WHERE placa_pod > 1000
  AND id_szefa IS NOT NULL
ORDER BY nazwisko ASC;

-- Zad. 12

SELECT nazwisko,
       id_zesp
FROM pracownicy
WHERE id_zesp = 20
  AND (nazwisko LIKE 'M%'
       OR nazwisko LIKE '%SKI')
ORDER BY nazwisko ASC;

-- Zad. 13
SELECT nazwisko,
       etat,
       placa_pod / 20 / 8 AS stawka
FROM pracownicy
WHERE etat NOT IN ('ADIUNKT', 'ASYSTENT', 'STAZYSTA')
  AND placa_pod NOT BETWEEN 400 AND 800
ORDER BY stawka ASC;

-- Zad. 14
SELECT nazwisko,
       etat,
       placa_pod,
       placa_dod
FROM pracownicy
WHERE placa_pod + coalesce(placa_dod, 0) > 1000
ORDER BY etat ASC,
         nazwisko ASC;

-- Zad. 15
SELECT nazwisko || ' pracuje od ' || zatrudniony || ' i zarabia ' || placa_pod AS profesorowie
FROM pracownicy
WHERE etat = 'PROFESOR'
ORDER BY placa_pod DESC;