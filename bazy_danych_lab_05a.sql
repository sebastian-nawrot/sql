-- Zad. 1
SELECT nazwisko,
       etat,
       pracownicy.id_zesp,
       nazwa
FROM pracownicy
JOIN zespoly ON pracownicy.id_zesp = zespoly.id_zesp
ORDER BY nazwisko;

-- Zad. 2
SELECT nazwisko,
       etat,
       pracownicy.id_zesp,
       nazwa
FROM pracownicy
JOIN zespoly ON pracownicy.id_zesp = zespoly.id_zesp
WHERE zespoly.adres = 'PIOTROWO 3A'
ORDER BY nazwisko;

-- Zad. 3
SELECT nazwisko,
       pracownicy.etat,
       placa_pod,
       placa_min,
       placa_max
FROM pracownicy
JOIN etaty ON pracownicy.etat = etaty.nazwa;

-- Zad. 4
SELECT nazwisko,
       pracownicy.etat,
       placa_pod,
       placa_min,
       placa_max,
       CASE
           WHEN placa_min <= placa_pod
                AND placa_pod <= placa_max THEN 'OK'
           ELSE 'NIE'
       END AS czy_pensja_ok
FROM pracownicy
JOIN etaty ON pracownicy.etat = etaty.nazwa;

-- Zad. 5
SELECT nazwisko,
       pracownicy.etat,
       placa_pod,
       placa_min,
       placa_max,
       CASE
           WHEN placa_min <= placa_pod
                AND placa_pod <= placa_max THEN 'OK'
           ELSE 'NIE'
       END AS czy_pensja_ok
FROM pracownicy
JOIN etaty ON pracownicy.etat = etaty.nazwa
WHERE placa_min > placa_pod
  OR placa_pod > placa_max;

-- Zad. 6
SELECT nazwisko,
       placa_pod,
       etat,
       nazwa AS kat_plac,
       placa_min,
       placa_max
FROM pracownicy
JOIN etaty ON placa_pod BETWEEN placa_min AND placa_max
ORDER BY nazwisko,
         nazwa;

-- Zad. 7
SELECT nazwisko,
       placa_pod,
       etat,
       nazwa AS kat_plac,
       placa_min,
       placa_max
FROM pracownicy
JOIN etaty ON placa_pod BETWEEN placa_min AND placa_max
WHERE nazwa = 'SEKRETARKA'
ORDER BY nazwisko,
         nazwa;

-- Zad. 8
SELECT p.nazwisko AS pracownik,
       p.id_prac,
       s.nazwisko AS szef,
       s.id_szefa
FROM pracownicy p
JOIN pracownicy s ON p.id_szefa = s.id_prac
WHERE s.id_szefa IS NOT NULL;

-- Zad. 9
SELECT p.nazwisko AS pracownik,
       p.zatrudniony AS prac_zatrudniony,
       s.nazwisko AS szef,
       s.zatrudniony AS szef_zatrudniony,
       extract(YEAR FROM (p.zatrudniony - s.zatrudniony) YEAR TO MONTH) AS lata
FROM pracownicy p
JOIN pracownicy s ON p.id_szefa = s.id_prac
WHERE extract(YEAR FROM (p.zatrudniony - s.zatrudniony) YEAR TO MONTH) < 10
ORDER BY p.zatrudniony,
         p.nazwisko;

-- Zad. 10
SELECT nazwa,
       count(*),
       avg(placa_pod) AS srednia_placa
FROM pracownicy
JOIN zespoly ON pracownicy.id_zesp = zespoly.id_zesp
GROUP BY nazwa
ORDER BY nazwa;

-- Zad. 11
SELECT nazwa,
       CASE
           WHEN count(*) < 3 THEN 'mały'
           WHEN 3 <= count(*)
                AND count(*) <= 6 THEN 'średni'
           ELSE 'duży'
       END
FROM pracownicy
JOIN zespoly ON pracownicy.id_zesp = zespoly.id_zesp
GROUP BY nazwa
ORDER BY nazwa;