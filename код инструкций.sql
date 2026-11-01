
-- 1. Главная таблица
CREATE TABLE korrespondenciya1 (
    id_korrespondencii INTEGER PRIMARY KEY,
    trek_number VARCHAR(50),
    cod_vida_korrespondencii INTEGER,
    ves NUMERIC(10,2),
    dlina NUMERIC(10,2),
    shirina NUMERIC(10,2),
    vysota NUMERIC(10,2),
    cod_otpravitelya INTEGER,
    summa_marok NUMERIC(10,2)
);

-- 2. Дочерняя таблица
CREATE TABLE priem_korrespondencii_1 (
    id_priema INTEGER PRIMARY KEY,
    cod_pochti INTEGER NOT NULL,
    id_korrespondencii INTEGER NOT NULL,
    data_i_time TIMESTAMP,
    cennost NUMERIC(10,2),
    itog_stoimost NUMERIC(10,2),
    oplacheno BOOLEAN,
    data_i_time_otpravki TIMESTAMP,

    CONSTRAINT fk_priem_to_korrespondenciya
    FOREIGN KEY (id_korrespondencii)
    REFERENCES korrespondenciya1 (id_korrespondencii)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- 3. Заполнение главной таблицы
INSERT INTO korrespondenciya1 VALUES
(1, 'TRK001RU', 1, 0.45, 10, 5, 2, 101, 50),
(2, 'TRK002RU', 2, 1.20, 15, 10, 5, 102, 100),
(3, 'TRK003RU', 1, 0.30, 8, 4, 1.5, 103, 30),
(4, 'TRK004RU', 3, 2.50, 20, 15, 10, 104, 200),
(5, 'TRK005RU', 2, 0.85, 12, 6, 3, 105, 75),
(6, 'TRK006RU', 1, 0.50, 10, 5, 2, 101, 50),
(7, 'TRK007RU', 3, 3.10, 25, 20, 15, 106, 250),
(8, 'TRK008RU', 2, 1.10, 14, 9, 4, 102, 90),
(9, 'TRK009RU', 1, 0.20, 7, 3, 1, 107, 25),
(10, 'TRK010RU', 3, 4.00, 30, 25, 20, 108, 300);

-- 4. Заполнение дочерней таблицы
INSERT INTO priem_korrespondencii_1 VALUES
(1, 101000, 1, '2026-10-22 10:00:00', 1000, 150, TRUE, '2026-10-22 12:00:00'),
(2, 101000, 2, '2026-10-22 10:15:00', 2500, 220, TRUE, '2026-10-22 12:30:00'),
(3, 102000, 3, '2026-10-22 10:30:00', 500, 100, FALSE, NULL),
(4, 102000, 4, '2026-10-22 10:45:00', 5000, 450, TRUE, '2026-10-22 14:00:00'),
(5, 103000, 5, '2026-10-22 11:00:00', 1200, 180, TRUE, '2026-10-22 13:00:00'),
(6, 103000, 6, '2026-10-22 11:15:00', 800, 130, FALSE, NULL),
(7, 104000, 7, '2026-10-22 11:30:00', 10000, 800, TRUE, '2026-10-22 15:00:00'),
(8, 104000, 8, '2026-10-22 11:45:00', 3000, 250, TRUE, '2026-10-22 13:30:00'),
(9, 105000, 9, '2026-10-22 12:00:00', 300, 80, TRUE, '2026-10-22 12:40:00'),
(10, 105000, 10, '2026-10-22 12:15:00', 15000, 1100, FALSE, NULL);
