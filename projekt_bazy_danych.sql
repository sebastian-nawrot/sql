CREATE TABLE uzytkownicy (
  id_uzytkownika INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  imie VARCHAR2(20) NOT NULL,
  nazwisko VARCHAR2(20) NOT NULL,
  adres_email VARCHAR2(50) NOT NULL,
  data_rejestracji DATE DEFAULT CURRENT_DATE NOT NULL,
  data_urodzenia DATE);

CREATE TABLE przedmioty (
  id_przedmiotu INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nazwa VARCHAR2(100) NOT NULL,
  cena DECIMAL(6,2) NOT NULL);

CREATE TABLE adresy_dostawy (
  id_adresu_dostawy INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  miasto VARCHAR2(40) UNIQUE NOT NULL,  
  ulica VARCHAR2(40) UNIQUE NOT NULL,
  numer_domu VARCHAR2(40) UNIQUE NOT NULL);

CREATE TABLE kody_rabatowe (
  id_kodu_rabatowego INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  kod VARCHAR2(20) UNIQUE NOT NULL,
  kwota_rabatu DECIMAL(6,2) NOT NULL);

CREATE TABLE zamowienia (
  id_zamowienia INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  id_uzytkownika INTEGER CONSTRAINT fk_uzytkownicy REFERENCES uzytkownicy(id_uzytkownika) NOT NULL,
  id_przedmiotu INTEGER CONSTRAINT fk_przedmioty REFERENCES przedmioty(id_przedmiotu) NOT NULL,
  id_adresu_dostawy INTEGER CONSTRAINT fk_adresy_dostawy REFERENCES adresy_dostawy(id_adresu_dostawy) NOT NULL,
  id_kodu_rabatowego INTEGER CONSTRAINT fk_kody_rabatowe REFERENCES kody_rabatowe(id_kodu_rabatowego),
  data_zamowienia DATE DEFAULT CURRENT_DATE NOT NULL);