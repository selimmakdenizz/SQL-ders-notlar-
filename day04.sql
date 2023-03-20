
/*--------------------ON DELETE CASCADE---------------------------------------------
ON DELETE CASCADE komutu sayesinde;
 
Direk parent tablodaki veriyi silebiliyoruz
Ayrıca,
Direk parent tabloyu silebiliyoruz
Bunun için FK olan satırın en sonuna ON DELETE CASCADE komutu yazmamız yeterli
-------------------------------------------------------------------------------------*/
CREATE TABLE parent 
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
    
INSERT INTO parent VALUES (101, 'Sony', 'Kim Lee');
INSERT INTO parent VALUES (102, 'Asus', 'George Clooney');
INSERT INTO parent VALUES (103, 'Monster', 'Johnny Deep');
INSERT INTO parent VALUES (104, 'Apple', 'Mick Jackson');


CREATE TABLE child
(
ted_vergino int, 
urun_id int, 
urun_isim VARCHAR(50), 
musteri_isim VARCHAR(50),
CONSTRAINT fk FOREIGN KEY(ted_vergino) REFERENCES parent(vergi_no)
ON DELETE CASCADE
);    
    
INSERT INTO child VALUES(101, 1001,'PC', 'Habip Sanli');
INSERT INTO child VALUES(102, 1002,'Kamera', 'Zehra Oz');
INSERT INTO child VALUES(102, 1003,'Saat', 'Mesut Kaya');
INSERT INTO child VALUES(102, 1004,'PC', 'Vehbi Koc');
INSERT INTO child VALUES(103, 1005,'Kamera', 'Cemal Sala');
INSERT INTO child VALUES(104, 1006,'Saat', 'Behlül Dana');
INSERT INTO child VALUES(104, 1007,'Kamera', 'Eymen Ozden');
select * from parent;
select * from child;
--SORU1: parent tablosundaki tum verileri siliniz   
delete from parent;
--> ON DELETE CASCADE sayesinde
-- Child tablodaki veri silinmeden Parent tablodaki veri silinmeye calisildiginda PgAdmin eror vermez.
-- Parent tablodaki veriyi siler.
-- Fakat bu durumda Child tablodaki veri de silinir.
select * from parent;
select * from child;
--SORU2: parent tablosunu siliniz..
drop table parent cascade;
--SORU3: child tablosunu siliniz
drop table child;


/*
FOREIGN KEY'LERDE ON DELETE CASCADE KOMUTU YAZILMAZSA
1-) Child tablo silinmeden Parent tablo silinmeye çalışıldıgında PgAdmin Eror verir.
yani Child tablo silinmeden Parent tablo silinemez
2-) Child tablodaki veri silinmeden Parent tablodaki veri silinmeye çalışıldıgında Pg Admin Eror verir.
yani Child tablodaki veri silinmeden Parent tablodaki veri silinemez
FOREIGN KEY'LERDE ON DELETE CASCADE KOMUTU YAZILIRSA
1-) Child tablo silinmeden Parent tablo silinebilir.
PgAdmin Eror vermez
2-) Child tablodaki veri silinmeden Parent tablodaki veri silinmeye çalışıldıgında PgAdmin Eror vermez
Parent tablodaki veriyi siler.
Fakat bu durumda Child tablodaki veride silinir.
*/



/*------------ AGGREGATE METHOD KULLANIMI ---------------------------
AGGREGATE METHODLARI:  Tek bir deger elde etmek istedigimizde kullanılır.
sum() ==>   Verilerin toplamını alır.
count() ==> Verilerin sayisini alır.
min() ==>   Verilerden en kücük degeri alır.
max() ==>   Verilerden en büyük degeri alır.
avg() ==>   Verilerin ortalamasını alır.
--------------------------------------------------------------------*/
create table arac
(
id int,
marka varchar(30),
model varchar(30),
fiyat int,
kilometre int,
vites varchar(20)
);
insert into arac values(100, 'Citroen', 'C3', 500000, 5000, 'Otomatik' );
insert into arac values(101, 'Mercedes', 'C180', 900000, 10000, 'Otomatik' );
insert into arac values(102, 'Honda', 'Cıvıc', 400000, 15000, 'Manuel' );
insert into arac values(103, 'Wolkswagen', 'Golf', 350000, 20000, 'Manuel' );
insert into arac values(104, 'Ford', 'Mustang', 750000, 5000, 'Otomatik' );
insert into arac values(105, 'Porsche', 'Panamera', 850000, 5000, 'Otomatik' );
insert into arac values(106, 'Bugatti', 'Veyron', 950000, 5000, 'Otomatik' );


--SORU1 : arac tablosundaki en yüksek fiyat'ı listele
select max(fiyat) as max_fiyat from arac;
--SORU2 : arac tablosundaki en düşük fiyat'ı listele
select min(fiyat) as min_fiyat from arac;
--SORU3 : arac tablosundaki fiyatların toplamını listele
select sum(fiyat) as toplam_fiyat from arac;
--SORU4 : arac tablosundaki fiyat ortalamalarını listele
select round(avg(fiyat),2) as ortalama_fiyat from arac;
-- round ==> ondalikli kısımdan kurtulmak icin kullanılan bir komuttur
--SORU5 : arac tablosunda kaç tane araç oldugunu listele
select count(id) as arac_sayisi from arac;
-- 2.YOL
select count(*) as arac_sayisi from arac;
/*============================SUBQUERY==============================
 SUBQUERY:  Sorgu içinde çalışan sorguya denir.
==========================================================================*/
CREATE TABLE malzemeler    
(
ted_vergino int, 
malzeme_id int, 
malzeme_isim VARCHAR(20), 
musteri_isim VARCHAR(25)
);    
    
INSERT INTO malzemeler VALUES(201, 1001,'Laptop', 'Aslı Can');
INSERT INTO malzemeler VALUES(202, 1002,'Telefon', 'Fatih Ak');
INSERT INTO malzemeler VALUES(202, 1003,'TV', 'Ramiz Özmen');
INSERT INTO malzemeler VALUES(202, 1004,'Laptop', 'Veli Tan');
INSERT INTO malzemeler VALUES(203, 1005,'Telefon', 'Cemile Al');
INSERT INTO malzemeler VALUES(204, 1006,'TV', 'Ali Can');
INSERT INTO malzemeler VALUES(204, 1007,'Telefon', 'Ahmet Yaman');
    
CREATE TABLE toptancilar    
(
vergi_no int,
sirket_ismi VARCHAR(40),
irtibat_ismi VARCHAR(30)
);
    
INSERT INTO toptancilar VALUES (201, 'IBM', 'Kadir Şen');
INSERT INTO toptancilar VALUES (202, 'Huawei', 'Çetin Hoş');
INSERT INTO toptancilar VALUES (203, 'Erikson', 'Mehmet Gör');
INSERT INTO toptancilar VALUES (204, 'Apple', 'Adem Coş');
select * from malzemeler;
-- SORU1: Malzemeler tablosundaki musteri_isim'i 'Ali Can' olanın malzeme_isim'ini,
--toptancilar  tablosunda irtibat_ismi 'Adem Coş' olan sirket_ismi ile güncelleyiniz.
update malzemeler set malzeme_isim=('Apple') where musteri_isim='Ali Can';
-- cevabı daha dinamik hale getirelim
update malzemeler set malzeme_isim=(select sirket_ismi from toptancilar where irtibat_ismi='Adem Coş')
where musteri_isim='Ali Can';
() ==> select sirket_ismi from toptancilar where irtibat_ismi='Adem Coş'
 -- SORU2: Malzemeler tablosundaki malzeme_isim'i 'Laptop' olan musteri_isim'lerini,
 -- toptancilar  tablosunda sirket_ismi 'Apple' in irtibat_ismi ile güncelleyiniz.
update malzemeler set musteri_isim=(select irtibat_ismi from toptancilar where sirket_ismi='Apple')
where malzeme_isim='Laptop';
-- cevabı daha dinamik hale getirelim
() ==> select irtibat_ismi from toptancilar where sirket_ismi='Apple'
/*================================ ORDER BY  ===================================
   ORDER BY komutu bir SORGU deyimi içerisinde belli bir SUTUN’a göre 
   SIRALAMA yapmak için kullanılır.
   
   Syntax
   -------
    ORDER BY sutun_adı              İNT==>KÜÇÜKTEN BÜYÜGE  STRİNG==>A-Z
    ORDER BY sutun_adı DESC         İNT==>BÜYÜKTEN KÜÇÜGE  STRİNG==>Z-A
==============================================================================*/   
CREATE TABLE meslekler
(
id int PRIMARY KEY,
isim VARCHAR(50), 
soyisim VARCHAR(50),
meslek CHAR(9),
maas int
);
        
INSERT INTO meslekler VALUES(1, 'Ali', 'Can', 'Doktor', '20000' );
INSERT INTO meslekler VALUES(2, 'Veli', 'Cem', 'Mühendis', '18000');
INSERT INTO meslekler VALUES(3, 'Mine', 'Bulut', 'Avukat', '17000');
INSERT INTO meslekler VALUES(4, 'Mahmut', 'Bulut', 'Ögretmen', '15000');
INSERT INTO meslekler VALUES (5, 'Mine', 'Yasa', 'Teknisyen', '13000');
INSERT INTO meslekler VALUES (6, 'Veli', 'Yilmaz', 'Hemşire', '12000');
INSERT INTO meslekler VALUES(7, 'Ali', 'Kan', 'Marangoz', '10000' );
INSERT INTO meslekler VALUES(8, 'Veli', 'Cem', 'Tekniker', '14000');
select * from meslekler;
-- SORU1: meslekler tablosunu isim'e göre kucukten buyuge sıralayarak listeleyiniz.
select * from meslekler order by isim;
select * from meslekler;
-- SORU2: meslekler tablosunu maas'i buyukten kucuge sıralayarak listeleyiniz
select * from meslekler order by maas desc;
select * from meslekler;
-- SORU3: meslekler tablosunda isim'i 'Ali' olanları,
-- maas'a göre büyükten küçüge sıralayarak listeleyiniz
select * from meslekler where isim='Ali' order by maas desc;
select * from meslekler;
-- SORU4: meslekler tablosunda soyisim 'i 'Bulut' olanları,
-- maas'a gore sıralayarak listeleyiniz.
select * from meslekler where soyisim='Bulut' order by maas;
--LİMİT--
-- sınır koymak icin kullanılır
create table musteriler
(
id int,
musteri_isim varchar(50),
maas int
);
insert into musteriler values(1,'Ayse',10000);
insert into musteriler values(2,'Adem',15000);
insert into musteriler values(3,'Halit',20000);
insert into musteriler values(4,'Hasan',25000);
insert into musteriler values(5,'Recep',30000);
insert into musteriler values(6,'Harun',35000);
insert into musteriler values(7,'Hatice',40000);
insert into musteriler values(8,'Poyraz',50000);
insert into musteriler values(9,'Ayse',60000);
insert into musteriler values(10,'Adem',70000);
--SORU1: musteriler tablosundaki ilk 5 kisinin bilgilerini listeleyiniz.
select * from musteriler limit 5;
-- SORU2: musteriler tablosunda id degeri 2 den büyük olan,
-- ilk 3 veriyi listeleyiniz
select * from musteriler where id>2 limit 3;
-- SORU3: musteriler tablosunda maas'i 20000'den büyük olan,
-- ilk 3 veriyi listeleyiniz
select * from musteriler where maas>20000 limit 3;
-- SORU4: musteriler tablosunda maası en yüksek 3 kişinin bilgilerini listeleyiniz
select * from musteriler order by maas desc limit 3;
--SORU5: musteriler tablosunda maası en yüksek ilk 2 veriden sonra 5 veriyi listeleyin 
select * from musteriler order by maas desc offset 2 limit 5;
-- SORU6: musteriler tablosunda en yüksek maaşı alan 3. 4. 5. 6. kişilerin bilgilerini listeleyiniz
select * from musteriler order by maas desc offset 2 limit 4;
