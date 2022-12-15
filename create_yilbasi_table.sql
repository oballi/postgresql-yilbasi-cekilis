create table yilbasi
(
    id              serial
        constraint yilbasi_pk
            primary key,
    hediye_veren_id integer
        constraint yilbasi_personel_id_fk
            references personel,
    hediye_veren    varchar(50),
    hediye_alan_id  integer,
    hediya_alan     varchar(50)
);
