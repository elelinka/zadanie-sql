CREATE SCHEMA pracownik_zadanie;

CREATE TABLE pracownik(
	id INT auto_increment PRIMARY KEY,
    imie VARCHAR(50),
    nazwisko VARCHAR(50) NOT NULL,
    data_urodzenia DATE,
    wyplata DECIMAL(5,2),
    stanowisko VARCHAR(50)
);

ALTER TABLE pracownik
MODIFY COLUMN wyplata DECIMAL(7,2);

INSERT INTO pracownik(imie, nazwisko, data_urodzenia, wyplata, stanowisko)
VALUES
('Ewelina', 'Gregoraszczuk', '1992-09-14', 5000.00, 'senior dev engineer'),
('Aneta', 'Tołyż', '1991-07-06', 3200.00, 'dev engineer'),
('Kamil', 'Robak', '1990-07-04', 6000.00, 'team leader'),
('Ola', 'Siwkow', '1993-05-14', 6000.00, 'scrum master'),
('Mariusz', 'Cłapiński', '1989-08-04', 3000.00, 'team leader'),
('Wiktor', 'Wolski', '1990-07-04', 4500.00, 'dev engineer');

SELECT * FROM pracownik
ORDER BY nazwisko;

SELECT * FROM pracownik
WHERE stanowisko LIKE '%engineer';

SELECT * FROM pracownik
WHERE EXTRACT(YEAR FROM CURDATE()) - EXTRACT(YEAR FROM data_urodzenia) >= 30;

SELECT *, wyplata * 1.1 'powiekszona_wyplata' FROM pracownik
WHERE stanowisko LIKE '%engineer';

SELECT * FROM pracownik
ORDER BY data_urodzenia DESC;

DELETE FROM pracownik
WHERE id = (SELECT id FROM pracownik WHERE data_urodzenia = (SELECT MAX(data_urodzenia) FROM pracownik));

DROP TABLE pracownik;

CREATE TABLE stanowisko(
	id INT auto_increment PRIMARY KEY,
    nazwa_stanowiska VARCHAR(50) NOT NULL,
    opis VARCHAR(200),
    wyplata DECIMAL(7,2)
);

CREATE TABLE adres(
	id INT auto_increment PRIMARY KEY,
    ulica VARCHAR(50),
    nr_domu VARCHAR(10),
    nr_mieszkania VARCHAR(10),
    kod_pocztowy VARCHAR(10),
    miejscowosc VARCHAR(50)
);

CREATE TABLE pracownik (
	id INT auto_increment PRIMARY KEY,
    imie VARCHAR(50),
    nazwisko VARCHAR(50) NOT NULL,
    adres_id INT,
    stanowisko_id INT
);

INSERT INTO stanowisko(nazwa_stanowiska, opis, wyplata)
VALUES 
('senior dev engineer', 'deweloper oprogramowania Java', 10000.00),
('dev engineer', 'deweloper oprogramowania Java', 5000.00),
('team leader', 'leader zespołu deweloperów', 15000.00),
('product owner', 'odpowiedzialny za rozwój produktu', 10000.00);

INSERT INTO adres(ulica, nr_domu, nr_mieszkania, kod_pocztowy, miejscowosc)
VALUES
('Laurowa', '1', '1', '51-180', 'Wrocław'),
('Robotnicza', '11', NULL, '53-670', 'Wrocław');

INSERT INTO pracownik(imie, nazwisko, adres_id, stanowisko_id)
VALUES
('Ewelina', 'Gregoraszczuk', 1, 1),
('Aneta', 'Tołyż', 2, 4),
('Kamil', 'Robak', 1, 3);

SELECT * FROM pracownik p
JOIN stanowisko s ON p.stanowisko_id = s.id 
JOIN adres a ON p.adres_id = a.id;

SELECT SUM(wyplata) 'suma_wszystkich_wyplat' FROM pracownik p 
JOIN stanowisko s ON p.stanowisko_id = s.id;

SELECT * FROM pracownik p
JOIN adres a ON p.adres_id = a.id
WHERE kod_pocztowy = '51-180';

DROP TABLE adres, pracownik, stanowisko;
