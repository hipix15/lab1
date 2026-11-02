
-- 1. Главная таблица: Корреспонденция
CREATE TABLE korrespondenciya_26 (
    trek_number VARCHAR(50) PRIMARY KEY,
    cod_vida_korrespondencii INTEGER,
    ves NUMERIC(10,2),
    dlina NUMERIC(10,2),
    shirina NUMERIC(10,2),
    vysota NUMERIC(10,2),
    cod_otpravitelya INTEGER,
    summa_marok NUMERIC(10,2)
);

-- 2. Дочерняя таблица: Прием корреспонденции
CREATE TABLE priem_korrespondencii_26 (
    cod_pochti INTEGER NOT NULL,
    trek_number VARCHAR(50) NOT NULL,
    data_i_time TIMESTAMP,
    cennost NUMERIC(10,2),
    itog_stoimost NUMERIC(10,2),
    oplacheno BOOLEAN,
    data_i_time_otpravki TIMESTAMP,

    -- Делаем трек-номер первично-внешним ключом для связи с главной таблицей
    CONSTRAINT pk_priem_korrespondencii PRIMARY KEY (cod_pochti, trek_number),
    CONSTRAINT fk_priem_to_korrespondenciya
    FOREIGN KEY (trek_number)
    REFERENCES korrespondenciya_26 (trek_number)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- 3. Заполнение главной таблицы (Корреспонденция)
INSERT INTO korrespondenciya_26 VALUES
('TRK001RU', 1, 0.45, 10, 5, 2, 101, 50),
('TRK002RU', 2, 1.20, 15, 10, 5, 102, 100),
('TRK003RU', 1, 0.30, 8, 4, 1.5, 103, 30),
('TRK004RU', 3, 2.50, 20, 15, 10, 104, 200),
('TRK005RU', 2, 0.85, 12, 6, 3, 105, 75),
('TRK006RU', 1, 0.50, 10, 5, 2, 101, 50),
('TRK007RU', 3, 3.10, 25, 20, 15, 106, 250),
('TRK008RU', 2, 1.10, 14, 9, 4, 102, 90),
('TRK009RU', 1, 0.20, 7, 3, 1, 107, 25),
('TRK010RU', 3, 4.00, 30, 25, 20, 108, 300);

-- 4. Заполнение дочерней таблицы (Прием корреспонденции)
INSERT INTO priem_korrespondencii_26 VALUES
(101000, 'TRK001RU', '2026-10-22 10:00:00', 1000, 150, TRUE, '2026-10-22 12:00:00'),
(101000, 'TRK002RU', '2026-10-22 10:15:00', 2500, 220, TRUE, '2026-10-22 12:30:00'),
(102000, 'TRK003RU', '2026-10-22 10:30:00', 500, 100, FALSE, NULL),
(102000, 'TRK004RU', '2026-10-22 10:45:00', 5000, 450, TRUE, '2026-10-22 14:00:00'),
(103000, 'TRK005RU', '2026-10-22 11:00:00', 1200, 180, TRUE, '2026-10-22 13:00:00'),
(103000, 'TRK006RU', '2026-10-22 11:15:00', 800, 130, FALSE, NULL),
(104000, 'TRK007RU', '2026-10-22 11:30:00', 10000, 800, TRUE, '2026-10-22 15:00:00'),
(104000, 'TRK008RU', '2026-10-22 11:45:00', 3000, 250, TRUE, '2026-10-22 13:30:00'),
(105000, 'TRK009RU', '2026-10-22 12:00:00', 300, 80, TRUE, '2026-10-22 12:40:00'),
(105000, 'TRK010RU', '2026-10-22 12:15:00', 15000, 1100, FALSE, NULL);