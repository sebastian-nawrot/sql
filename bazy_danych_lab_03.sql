-- Zad. 1
SELECT nazwisko,
       substr(etat, 1, 2) || id_prac AS kod
FROM pracownicy;

-- Zad. 2
SELECT nazwisko,
       translate(nazwisko, 'KLM', 'XXX') AS wojna_literom
FROM pracownicy;

-- Zad. 3
SELECT nazwisko
FROM pracownicy
WHERE instr(nazwisko, 'L') BETWEEN 1 AND length(nazwisko) / 2;

-- Zad. 4
SELECT nazwisko,
       round(placa_pod * 1.15) AS podwyzka
FROM pracownicy;

-- Zad. 5
SELECT nazwisko,
       placa_pod,
       placa_pod * 0.2 AS inwestycja,
       placa_pod * 0.2 * power(1.1, 10) AS kapital,
       placa_pod * 0.2 * power(1.1, 10) - placa_pod * 0.2 AS zysk
FROM pracownicy;

-- Zad. 6
SELECT nazwisko,
       to_char(zatrudniony, 'RR/MM/DD'),
       extract(YEAR FROM (DATE '2000-01-01'-zatrudniony) YEAR TO MONTH)
FROM pracownicy;

-- Zad. 7
SELECT nazwisko,
       to_char(zatrudniony, 'fmMONTH, DD YYYY') AS data_zatrudnienia
FROM pracownicy
WHERE id_zesp = 20;

-- Zad. 8
SELECT to_char(CURRENT_DATE, 'fmDAY') AS dzis
FROM pracownicy;

-- Zad. 9
SELECT nazwa,
       adres,
       CASE
           WHEN adres LIKE 'PIOTROWO%' THEN 'NOWE MIASTO'
           WHEN adres LIKE 'STRZELECKA%'
                OR adres LIKE 'MIELZYNSKIEGO%' THEN 'STARE MIASTO'
           WHEN adres LIKE 'WLODKOWICA%' THEN 'GRUNWALD'
       END AS dzielnica
FROM zespoly;

-- Zad. 10