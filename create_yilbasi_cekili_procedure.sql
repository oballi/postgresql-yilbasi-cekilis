create procedure yilbasi_cekilis()
    language plpgsql
as
$$
DECLARE
    r         record;
    x         record;
    random_id int;
    hediye_a  int;
BEGIN

    for r in select * from personel order by id
        loop
            --RAISE NOTICE 'Döngüden Gelen ID : % Gelen Ad %',r.id,r.ad_soyad;

            /* hediye alan kişi bulunur - random id üretilir */
            SELECT floor(random() * max(id) + 1)::int into random_id from personel;
            --RAISE NOTICE 'Hediye Alan Kiş İçin Random ID Üretildi : %',random_id;

            /*Hediye Alan ID ile Hediye Veren ID birbirlerine eşit mi kontrol ediliyor..*/
            while random_id = r.id
                loop
                    SELECT floor(random() * max(id) + 1)::int into random_id from personel;
                    --RAISE NOTICE 'Hediye veren ID ile hediye alan ID eşit. Yeni ID üretiliyor.. %',random_id;
                end loop;

            /*hediye alan kişi yilbasi tablosunda var mi kontrol et*/
            SELECT hediye_alan_id into hediye_a FROM yilbasi where hediye_alan_id = random_id;

            while hediye_a = random_id
                loop
                    SELECT floor(random() * max(id) + 1)::int into random_id from personel;
                    while random_id = (select hediye_alan_id from yilbasi where hediye_alan_id = random_id)
                        loop
                            SELECT floor(random() * max(id) + 1)::int into random_id from personel;
                            --RAISE NOTICE 'Hediye alan ID daha önce yilbasi tablosunda kayitli. Tekrardan random id üretiliyor.. %',random_id;
                        end loop;
                end loop;

            /*Artık Hediye Alan kişiyi ve Hediye veren Kişi kaydedebiliriz*/
            SELECT * into x FROM personel where id = random_id;
            INSERT INTO yilbasi (hediye_veren_id, hediye_veren, hediye_alan_id, hediya_alan)
            VALUES (r.id, r.ad_soyad, x.id, x.ad_soyad);
            COMMIT;
        end loop;
end;
$$;
