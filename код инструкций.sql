CREATE TABLE priem_korrespondencii_1 (
    cod_pochti INTEGER NOT NULL,
    trek_number VARCHAR(50) PRIMARY KEY,
    data_i_time TIMESTAMP,
    cennost NUMERIC(10,2),
    itog_stoimost NUMERIC(10,2),
    oplacheno BOOLEAN,
    data_i_time_otpravki TIMESTAMP
);

CREATE TABLE korrespondenciya1 (
    trek_number VARCHAR(50) PRIMARY KEY,
    cod_vida_korrespondencii INTEGER,
    ves NUMERIC(10,2),
    dlina NUMERIC(10,2),
    shirina NUMERIC(10,2),
    vysota NUMERIC(10,2),
    cod_otpravitelya INTEGER,
    summa_marok NUMERIC(10,2)
);
-- 1. Добавляем 10 записей в главную таблицу
INSERT INTO korrespondenciya1 
(trek_number, cod_vida_korrespondencii, ves, dlina, shirina, vysota, cod_otpravitelya, summa_marok)
VALUES 
('TRK001RU', 1, 0.45, 10.0, 5.0, 2.0, 101, 50.00),
('TRK002RU', 2, 1.20, 15.0, 10.0, 5.0, 102, 100.00),
('TRK003RU', 1, 0.30, 8.0, 4.0, 1.5, 103, 30.00),
('TRK004RU', 3, 2.50, 20.0, 15.0, 10.0, 104, 200.00),
('TRK005RU', 2, 0.85, 12.0, 6.0, 3.0, 105, 75.00),
('TRK006RU', 1, 0.50, 10.0, 5.0, 2.0, 101, 50.00),
('TRK007RU', 3, 3.10, 25.0, 20.0, 15.0, 106, 250.00),
('TRK008RU', 2, 1.10, 14.0, 9.0, 4.0, 102, 90.00),
('TRK009RU', 1, 0.20, 7.0, 3.0, 1.0, 107, 25.00),
('TRK010RU', 3, 4.00, 30.0, 25.0, 20.0, 108, 300.00);

-- 2. Добавляем 10 записей в дочернюю таблицу (с теми же трек-номерами)
INSERT INTO priem_korrespondencii_1 
(cod_pochti, trek_number, data_i_time, cennost, itog_stoimost, oplacheno, data_i_time_otpravki)
VALUES 
(101000, 'TRK001RU', '2026-10-22 10:00:00', 1000.00, 150.00, TRUE, '2026-10-22 12:00:00'),
(101000, 'TRK002RU', '2026-10-22 10:15:00', 2500.00, 220.00, TRUE, '2026-10-22 12:30:00'),
(102000, 'TRK003RU', '2026-10-22 10:30:00', 500.00, 100.00, FALSE, NULL),
(102000, 'TRK004RU', '2026-10-22 10:45:00', 5000.00, 450.00, TRUE, '2026-10-22 14:00:00'),
(103000, 'TRK005RU', '2026-10-22 11:00:00', 1200.00, 180.00, TRUE, '2026-10-22 13:00:00'),
(103000, 'TRK006RU', '2026-10-22 11:15:00', 800.00, 130.00, FALSE, NULL),
(104000, 'TRK007RU', '2026-10-22 11:30:00', 10000.00, 800.00, TRUE, '2026-10-22 15:00:00'),
(104000, 'TRK008RU', '2026-10-22 11:45:00', 3000.00, 250.00, TRUE, '2026-10-22 13:30:00'),
(105000, 'TRK009RU', '2026-10-22 12:00:00', 300.00, 80.00, TRUE, '2026-10-22 12:40:00'),
(105000, 'TRK010RU', '2026-10-22 12:15:00', 15000.00, 1100.00, FALSE, NULL);

-- 1. Удаляем ограничение по его реальному имени, которое сейчас уже существует в базе
ALTER TABLE priem_korrespondencii_1 
DROP CONSTRAINT IF EXISTS fk_priem_to_korrespondenciya;

-- 2. Сразу же создаем его заново с поддержкой каскадного обновления и удаления
ALTER TABLE priem_korrespondencii_1 
ADD CONSTRAINT fk_priem_to_korrespondenciya 
FOREIGN KEY (trek_number) 
REFERENCES korrespondenciya1 (trek_number)
ON UPDATE CASCADE 
ON DELETE CASCADE;