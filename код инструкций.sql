-- 1. Главная таблица
CREATE TABLE korrespondenciya (
    trek_number VARCHAR(50) PRIMARY KEY,
    cod_vida_korrespondencii INTEGER NOT NULL,
    ves NUMERIC(10,2) NOT NULL,
    dlina NUMERIC(10,2) NOT NULL,
    shirina NUMERIC(10,2) NOT NULL,
    vysota NUMERIC(10,2) NOT NULL,
    cod_otpravitelya INTEGER NOT NULL,
    summa_marok NUMERIC(10,2) NOT NULL
);

-- 2. Зависимая таблица
CREATE TABLE priem_korrespondencii (
    cod_pochti INTEGER NOT NULL,
    trek_number VARCHAR(50) NOT NULL,
    data_i_time TIMESTAMP NOT NULL,
    cennost NUMERIC(10,2) NOT NULL,
    itog_stoimost NUMERIC(10,2) NOT NULL,
    oplacheno BOOLEAN NOT NULL,
    data_i_time_otpravki TIMESTAMP,

    CONSTRAINT pk_priem_korrespondencii
    PRIMARY KEY (cod_pochti, trek_number),

    CONSTRAINT fk_priem_korrespondencii
    FOREIGN KEY (trek_number)
    REFERENCES korrespondenciya (trek_number)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);