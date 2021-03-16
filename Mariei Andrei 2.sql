use DezmembrariAuto;

SELECT id_evacuare, nume from Evacuare 
WHERE nume='Akrapovik' 
GROUP BY id_evacuare,nume;

SELECT DISTINCT id_caros,nume FROM Caroserie
WHERE nume='Portiera_Dreapta' 
GROUP BY id_caros,nume 
HAVING MAX(id_caros)<25;

SELECT DISTINCT id_masina,marca,model,combustibil FROM Masini
WHERE model='A3' 
GROUP BY id_masina,marca,model,combustibil 
HAVING MAX(id_masina)<12;

SELECT id_piesa,categorie_piesa FROM Vanzari 
WHERE id_vanzare=1;

SELECT id_vanzare,id_piesa FROM Vanzari 
Where id_client=2;

SELECT C.nume FROM Clienti C 
INNER JOIN Vanzari O ON C.id_client=O.id_client 
INNER JOIN Angajati A ON A.id_angajat=O.id_angajat;

SELECT O.id_piesa FROM Clienti C 
INNER JOIN Vanzari O ON C.id_client=O.id_client 
INNER JOIN Angajati A ON A.id_angajat=O.id_angajat;

SELECT O.id_vanzare FROM Clienti C 
INNER JOIN Vanzari O ON C.id_client=O.id_client 
INNER JOIN Angajati A ON A.id_angajat=O.id_angajat;

SELECT A.id_angajat FROM Clienti C 
INNER JOIN Vanzari O ON C.id_client=O.id_client 
INNER JOIN Angajati A ON A.id_angajat=O.id_angajat;

SELECT A.nume FROM Clienti C 
INNER JOIN Vanzari O ON C.id_client=O.id_client 
INNER JOIN Angajati A ON A.id_angajat=O.id_angajat;

SELECT O.categorie_piesa FROM Clienti C 
INNER JOIN Vanzari O ON C.id_client=O.id_client 
INNER JOIN Angajati A ON A.id_angajat=O.id_angajat;

SELECT C.id_client FROM Clienti C 
INNER JOIN Vanzari O ON C.id_client=O.id_client 
INNER JOIN Angajati A ON A.id_angajat=O.id_angajat;

INSERT INTO Evacuare(id_evacuare,nume) VALUES (1,'Akrapovik');
INSERT INTO Evacuare(id_evacuare,nume) VALUES (2,'KTM');
INSERT INTO Evacuare(id_evacuare,nume) VALUES (3,'OEM');
INSERT INTO Caroserie(id_caros,nume) VALUES (1,'Portiera_Dreapta');
INSERT INTO Caroserie(id_caros,nume) VALUES (26,'Portiera_Dreapta');
INSERT INTO Caroserie(id_caros,nume) VALUES (2,'Portiera_Stanga');
INSERT INTO Caroserie(id_caros,nume) VALUES (3,'Haion');
INSERT INTO Masini(id_masina,marca,model,combustibil) VALUES (1,'Audi','A3','Motorina');
INSERT INTO Masini(id_masina,marca,model,combustibil) VALUES (2,'BMW','320i','Benzina');
INSERT INTO Masini(id_masina,marca,model,combustibil) VALUES (13,'Audi','A4','Motorina');
INSERT INTO Dezmembrare(id,nume,adresa) VALUES (1,'AutoBunesti','Bunesti');
INSERT INTO Angajati(id,id_angajat,nume) VALUES (1,2,'Marius');
INSERT INTO Clienti(id,id_client,nume) VALUES (1,2,'Mihai');
INSERT INTO Vanzari(id_vanzare,id_piesa,categorie_piesa,id_angajat,id_client) VALUES (2,1,'evacuare',2,2);
INSERT INTO Vanzari(id_vanzare,id_piesa,categorie_piesa) VALUES (1,1,'evacuare');
