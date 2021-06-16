-- Zad. 1
SELECT nazwisko,
       pracownicy.id_zesp,
       nazwa
FROM pracownicy
LEFT JOIN zespoly ON pracownicy.id_zesp = zespoly.id_zesp
ORDER BY nazwisko;

-- Zad. 2
SELECT nazwa,
       zespoly.id_zesp,
       coalesce(nazwisko, 'brak pracowników') AS nazwisko
FROM pracownicy
RIGHT JOIN zespoly ON pracownicy.id_zesp = zespoly.id_zesp
ORDER BY nazwa,
         nazwisko;

-- Zad. 3
SELECT coalesce(nazwa, 'brak zespołu') AS nazwa,
       coalesce(nazwisko, 'brak pracowników') AS nazwisko
FROM pracownicy
FULL JOIN zespoly ON pracownicy.id_zesp = zespoly.id_zesp
ORDER BY nazwa,
         nazwisko;

-- Zad. 4
SELECT nazwa,
       count(pracownicy.id_zesp) AS liczba,
       coalesce(sum(pracownicy.placa_pod), 0) AS suma_plac
FROM pracownicy
RIGHT JOIN zespoly ON pracownicy.id_zesp = zespoly.id_zesp
GROUP BY nazwa
ORDER BY nazwa;

-- Zad. 5
SELECT nazwa
FROM pracownicy
RIGHT JOIN zespoly ON pracownicy.id_zesp = zespoly.id_zesp
GROUP BY nazwa
HAVING count(pracownicy.id_zesp) = 0;

-- Zad. 6
SELECT p.nazwisko AS pracownik,
       p.id_prac,
       s.nazwisko AS szef,
       s.id_prac AS id_szefa
FROM pracownicy p
LEFT JOIN pracownicy s ON p.id_szefa = s.id_prac
ORDER BY p.nazwisko;

-- Zad. 7
SELECT p.nazwisko AS pracownik,
       count(s.nazwisko) AS liczba_podwladnych
FROM pracownicy p
LEFT JOIN pracownicy s ON p.id_prac = s.id_szefa
GROUP BY p.nazwisko
ORDER BY p.nazwisko;

-- Zad. 8
SELECT p.nazwisko,
       p.etat,
       p.placa_pod,
       nazwa,
       s.nazwisko AS szef
FROM pracownicy p
LEFT JOIN pracownicy s ON p.id_szefa = s.id_prac
LEFT JOIN zespoly ON p.id_zesp = zespoly.id_zesp
ORDER BY p.nazwisko;

-- Zad. 9
SELECT nazwisko,
       nazwa
FROM pracownicy
CROSS JOIN zespoly
ORDER BY nazwisko,
         nazwa;

-- Zad. 10
SELECT count(*)
FROM pracownicy
CROSS JOIN zespoly
CROSS JOIN etaty;

-- Zad. 11
SELECT p.etat
FROM pracownicy p
CROSS JOIN pracownicy p2
WHERE extract(YEAR FROM p.zatrudniony) = 1992
  AND extract(YEAR FROM p2.zatrudniony) = 1993
GROUP BY p.etat
ORDER BY p.etat;

-- Zad. 12
SELECT zespoly.id_zesp
FROM pracownicy
RIGHT JOIN zespoly ON pracownicy.id_zesp = zespoly.id_zesp
GROUP BY zespoly.id_zesp
HAVING count(pracownicy.id_zesp) = 0;

-- Zad. 13
SELECT zespoly.id_zesp,
       zespoly.nazwa
FROM pracownicy
RIGHT JOIN zespoly ON pracownicy.id_zesp = zespoly.id_zesp
GROUP BY zespoly.id_zesp,
         zespoly.nazwa
HAVING count(pracownicy.id_zesp) = 0;

-- Zad. 14
SELECT nazwisko,
       placa_pod,
       'Poniżej 480 złotych' AS prog
FROM pracownicy
WHERE placa_pod < 480
UNION
SELECT nazwisko,
       placa_pod,
       'Dokładnie 480 złotych' AS prog
FROM pracownicy
WHERE placa_pod = 480
UNION
SELECT nazwisko,
       placa_pod,
       'Poniżej 480 złotych' AS prog
FROM pracownicy
WHERE placa_pod > 480
ORDER BY placa_pod;