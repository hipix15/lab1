-- ============================================================================
-- 26 ВАРИАНТ: СОЗДАНИЕ ТАБЛИЦ И ИХ ЗАПОЛНЕНИЕ
-- ============================================================================

-- Удаляем старые таблицы, если они были (сначала дочернюю, потом главную)
DROP TABLE IF EXISTS "acceptance" CASCADE;
DROP TABLE IF EXISTS "correspondence" CASCADE;

-- 1. Создание главной таблицы "Корреспонденция" (Correspondence)
CREATE TABLE "correspondence" (
    -- Автоинкремент для первичного ключа
    "correspondence_id" SERIAL PRIMARY KEY, 
    -- Трек-номер делаем уникальным, так как он тоже уникален, 
    -- но автоинкремент по методичке должен быть на первичном ключе.
    "tracking_number"   VARCHAR(50) UNIQUE NOT NULL, 
    "mail_type_code"    INTEGER NOT NULL,
    "weight_g"          NUMERIC(10,2) NOT NULL CHECK ("weight_g" > 0),
    "length_mm"         NUMERIC(10,2) NOT NULL CHECK ("length_mm" > 0),
    "width_mm"          NUMERIC(10,2) NOT NULL CHECK ("width_mm" > 0),
    "height_mm"         NUMERIC(10,2) NOT NULL CHECK ("height_mm" > 0),
    "sender_code"       INTEGER NOT NULL,
    "stamps_amount"     NUMERIC(10,2) NOT NULL CHECK ("stamps_amount" >= 0)
);

-- 2. Создание зависимой таблицы "Прием корреспонденции" (Acceptance)
CREATE TABLE "acceptance" (
    "post_office_code"    INTEGER NOT NULL,
    "tracking_number"     VARCHAR(50) NOT NULL,
    "acceptance_datetime" TIMESTAMP NOT NULL,
    "declared_value"      NUMERIC(10,2) NOT NULL DEFAULT 0 CHECK ("declared_value" >= 0),
    "total_shipping_cost" NUMERIC(10,2) NOT NULL CHECK ("total_shipping_cost" >= 0),
    "is_paid"             BOOLEAN NOT NULL DEFAULT FALSE,
    "shipping_datetime"   TIMESTAMP,
    
    -- Составной первичный ключ (одно отделение принимает конкретный трек-номер)
    PRIMARY KEY ("post_office_code", "tracking_number"),
    
    -- Внешний ключ с каскадным обновлением и удалением
    CONSTRAINT fk_acceptance_correspondence
        FOREIGN KEY ("tracking_number")
        REFERENCES "correspondence" ("tracking_number")
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ============================================================================
-- ЗАПОЛНЕНИЕ ТАБЛИЦ (по 10 записей в каждую)
-- ============================================================================

-- Заполняем "Корреспонденция"
INSERT INTO "correspondence" 
("tracking_number", "mail_type_code", "weight_g", "length_mm", "width_mm", "height_mm", "sender_code", "stamps_amount")
VALUES
('TRK100001', 1,   50.0, 200, 150,   5, 101, 100.00),
('TRK100002', 2,  500.0, 300, 200,  50, 102, 250.00),
('TRK100003', 3,  150.0, 250, 150,  10, 103, 150.00),
('TRK100004', 1,   80.0, 220, 110,   5, 104, 120.00),
('TRK100005', 4,  850.0, 400, 300,  80, 105, 400.00),
('TRK100006', 2,  350.0, 280, 180,  40, 106, 200.00),
('TRK100007', 3,  120.0, 240, 140,  15, 107, 130.00),
('TRK100008', 1,   20.0, 210, 100,   3, 108,  80.00),
('TRK100009', 5, 1200.0, 450, 350, 100, 109, 500.00),
('TRK100010', 4,  700.0, 380, 280,  70, 110, 350.00);

-- Заполняем "Прием корреспонденции"
INSERT INTO "acceptance" 
("post_office_code", "tracking_number", "acceptance_datetime", "declared_value", "total_shipping_cost", "is_paid", "shipping_datetime")
VALUES
(1, 'TRK100001', '2023-11-01 10:00:00',  1000.00, 150.00, TRUE,  '2023-11-01 12:00:00'),
(1, 'TRK100002', '2023-11-01 11:15:00',     0.00, 300.00, TRUE,  '2023-11-01 15:30:00'),
(2, 'TRK100003', '2023-11-02 09:00:00',   500.00, 200.00, FALSE, NULL),
(2, 'TRK100004', '2023-11-02 09:45:00',     0.00, 140.00, TRUE,  '2023-11-02 14:00:00'),
(3, 'TRK100005', '2023-11-03 14:30:00',  5000.00, 500.00, TRUE,  '2023-11-03 18:00:00'),
(1, 'TRK100006', '2023-11-04 10:10:00',     0.00, 220.00, TRUE,  '2023-11-04 13:00:00'),
(4, 'TRK100007', '2023-11-05 15:00:00',   200.00, 160.00, FALSE, NULL),
(1, 'TRK100008', '2023-11-05 16:20:00',     0.00, 100.00, TRUE,  '2023-11-05 17:00:00'),
(2, 'TRK100009', '2023-11-06 11:00:00', 10000.00, 600.00, TRUE,  '2023-11-06 16:00:00'),
(3, 'TRK100010', '2023-11-07 09:30:00',  3000.00, 400.00, TRUE,  '2023-11-07 12:00:00');