-- Удаляем старые таблицы, если они есть.
-- Сначала зависимую таблицу, затем главную.
DROP TABLE IF EXISTS mail_acceptance;
DROP TABLE IF EXISTS correspondence;


-- Главная таблица: «Корреспонденция»
CREATE TABLE correspondence (
    tracking_number          VARCHAR(30) NOT NULL,
    correspondence_type_code INTEGER NOT NULL,
    weight_g                 NUMERIC(10, 2) NOT NULL,
    length_cm                NUMERIC(8, 2) NOT NULL,
    width_cm                 NUMERIC(8, 2) NOT NULL,
    height_cm                NUMERIC(8, 2) NOT NULL,
    sender_code              INTEGER NOT NULL,
    stamp_amount             NUMERIC(12, 2) NOT NULL,

    CONSTRAINT pk_correspondence
        PRIMARY KEY (tracking_number),

    CONSTRAINT chk_correspondence_weight
        CHECK (weight_g > 0),

    CONSTRAINT chk_correspondence_length
        CHECK (length_cm > 0),

    CONSTRAINT chk_correspondence_width
        CHECK (width_cm > 0),

    CONSTRAINT chk_correspondence_height
        CHECK (height_cm > 0),

    CONSTRAINT chk_correspondence_stamp_amount
        CHECK (stamp_amount >= 0)
);


-- Таблица событий приёма корреспонденции
CREATE TABLE mail_acceptance (
    postal_office_code     VARCHAR(10) NOT NULL,
    tracking_number        VARCHAR(30) NOT NULL,
    accepted_at            TIMESTAMP NOT NULL,
    declared_value         NUMERIC(12, 2) NOT NULL,
    total_shipping_cost    NUMERIC(12, 2) NOT NULL,
    paid                   BOOLEAN NOT NULL,
    sent_at                TIMESTAMP,

    -- Составной первичный ключ: одно отправление
    -- может быть принято в разных отделениях и в разное время.
    CONSTRAINT pk_mail_acceptance
        PRIMARY KEY (tracking_number, postal_office_code, accepted_at),

    -- Связь с главной таблицей
    CONSTRAINT fk_mail_acceptance_correspondence
        FOREIGN KEY (tracking_number)
        REFERENCES correspondence (tracking_number)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT chk_mail_acceptance_declared_value
        CHECK (declared_value >= 0),

    CONSTRAINT chk_mail_acceptance_shipping_cost
        CHECK (total_shipping_cost >= 0),

    CONSTRAINT chk_mail_acceptance_sent_at
        CHECK (sent_at IS NULL OR sent_at >= accepted_at)
);

-- Проверяем связь и записи.
-- RR000000001RU должен отобразиться дважды — для двух отделений.
SELECT
    c.tracking_number,
    ma.postal_office_code,
    ma.accepted_at,
    ma.total_shipping_cost,
    ma.paid,
    ma.sent_at
FROM correspondence AS c
JOIN mail_acceptance AS ma
    ON ma.tracking_number = c.tracking_number
ORDER BY c.tracking_number, ma.accepted_at;


-- Проверяем количество записей в таблицах.
SELECT COUNT(*) AS correspondence_count
FROM correspondence;

SELECT COUNT(*) AS mail_acceptance_count
FROM mail_acceptance;