# Postgresql ile Yılbaşı Çekilişi Hazırlama

Merhaba, aşağıdaki adımları uygulayarak postgresql veritabanında hızlı bir şekilde yılbaşı çekilişi yapabilirsiniz :)

# Adımlar
### 1.Adım - Personel Tablosu Oluşturma
```
create table personel  
(  
    id serial  
 constraint personel_pk  
            primary key,  
    ad_soyad varchar(50)  
);
```

veya repodaki ```create_personel_table.sql``` dosyasını çalıştırabilirsiniz

### 2.Adım - Yılbaşı Tablosu Oluşturma
```
create table yilbasi  
(  
    id serial  
 constraint yilbasi_pk  
            primary key,  
    hediye_veren_id integer  
 constraint yilbasi_personel_id_fk  
            references personel,  
    hediye_veren varchar(50),  
    hediye_alan_id integer,  
    hediya_alan varchar(50)  
);
```

veya repodaki ```create_yilbasi_table.sql``` dosyasını çalıştırabilirsiniz

### 3.Adım - yilbasi_cekilis() Procedure Oluşturma
Repo içerisindeki ```create_yilbasi_cekili_procedure.sql``` procedureyi çalıştırmanız yeterli.

### 4.Adım - Çalıştırma
İlk 3.adımı hatasız bir şekilde yaptıysanız;
- Personel tablosuna çekilişe katılacak kişilerin bilgilerini girebilirsiniz. (ID kısmı otomatik olarak artacaktır)
- CALL ```yilbasi_cekilis()``` procedurunu çalıştırabilirsiniz.
- Artık ```yilbasi``` tablosunda kayitlariniza bakabilirsiniz :) 

### Mantık
1. Personel tablosundaki kayıtlar for döngüsü ile alınır. Bu kayıtlara hediye_veren diyelim
2. hediye_veren kişilerin karşısına hediye_alan kişileri getirmemiz lazım. 
3. hediye_alan kişileri bulmak için şartlar;
** yilbasi tablosundaki hediye_alan kişi sayısı birden fazla olamaz
** yilbasi tablosunda hediye alan ile hediye veren kişisi aynı olmaza 
