-- =====================================
-- 1. ТАБЛИЦА ПРИЕМ КОРРЕСПОНДЕНЦИИ
-- =====================================

CREATE TABLE priem_korrespondencii (
    cod_pochti INTEGER NOT NULL,
    trek_number VARCHAR(50) NOT NULL,
    data_i_time TIMESTAMP,
    cennost NUMERIC(10,2),
    itog_stoimost NUMERIC(10,2),
    oplacheno BOOLEAN,
    data_i_time_otpravki TIMESTAMP,

    PRIMARY KEY (cod_pochti, trek_number),

    UNIQUE (trek_number)
);


-- =====================================
-- 2. ТАБЛИЦА КОРРЕСПОНДЕНЦИЯ
-- =====================================

CREATE TABLE korrespondenciya (
    trek_number VARCHAR(50) NOT NULL,
    cod_vida_korrespondencii INTEGER NOT NULL,
    ves NUMERIC(10,2),
    dlina NUMERIC(10,2),
    shirina NUMERIC(10,2),
    vysota NUMERIC(10,2),
    cod_otpravitelya INTEGER NOT NULL,
    summa_marok NUMERIC(10,2),

    PRIMARY KEY (cod_vida_korrespondencii, cod_otpravitelya),

    FOREIGN KEY (trek_number)
        REFERENCES priem_korrespondencii (trek_number)
);


-- =====================================
-- 3. ЗАПОЛНЕНИЕ ПЕРВОЙ ТАБЛИЦЫ
-- =====================================

INSERT INTO priem_korrespondencii
VALUES
(101, 'TRK001', '2026-10-20 09:30', 500, 150, TRUE, '2026-10-20 14:00'),
(102, 'TRK002', '2026-10-20 10:15', 1000, 250, TRUE, '2026-10-20 15:30'),
(103, 'TRK003', '2026-10-21 11:00', 300, 100, FALSE, NULL),
(104, 'TRK004', '2026-10-21 12:45', 750, 200, TRUE, '2026-10-21 16:00'),
(105, 'TRK005', '2026-10-22 08:20', 200, 80, TRUE, '2026-10-22 13:00'),
(106, 'TRK006', '2026-10-22 14:10', 1500, 350, FALSE, NULL),
(107, 'TRK007', '2026-10-23 09:00', 600, 180, TRUE, '2026-10-23 12:30'),
(108, 'TRK008', '2026-10-23 15:20', 900, 220, TRUE, '2026-10-24 10:00'),
(109, 'TRK009', '2026-10-24 10:40', 400, 120, FALSE, NULL),
(110, 'TRK010', '2026-10-24 13:15', 1200, 300, TRUE, '2026-10-25 11:00');


-- =====================================
-- 4. ЗАПОЛНЕНИЕ ВТОРОЙ ТАБЛИЦЫ
-- =====================================

INSERT INTO korrespondenciya
VALUES
('TRK001', 1, 0.50, 20, 15, 10, 201, 50),
('TRK002', 2, 1.20, 30, 20, 15, 202, 75),
('TRK003', 3, 0.30, 15, 10, 5, 203, 30),
('TRK004', 4, 2.00, 40, 30, 20, 204, 100),
('TRK005', 5, 0.80, 25, 18, 12, 205, 60),
('TRK006', 6, 3.50, 50, 35, 25, 206, 150),
('TRK007', 7, 0.60, 22, 16, 11, 207, 55),
('TRK008', 8, 1.50, 35, 25, 18, 208, 90),
('TRK009', 9, 0.40, 18, 12, 8, 209, 40),
('TRK010', 10, 2.50, 45, 30, 22, 210, 120);


-- =====================================
-- 5. ПРОВЕРКА СВЯЗИ ТАБЛИЦ
-- =====================================

SELECT *
FROM priem_korrespondencii
JOIN korrespondenciya
ON priem_korrespondencii.trek_number =
   korrespondenciya.trek_number;