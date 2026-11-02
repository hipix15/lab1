CREATE TABLE priem_korrespondencii (
    cod_pochti INTEGER NOT NULL,
    trek_number VARCHAR(50) PRIMARY KEY,
    data_i_time TIMESTAMP,
    cennost NUMERIC(10,2),
    itog_stoimost NUMERIC(10,2),
    oplacheno BOOLEAN,
    data_i_time_otpravki TIMESTAMP
);

CREATE TABLE korrespondenciya (
    trek_number VARCHAR(50) PRIMARY KEY,
    cod_vida_korrespondencii INTEGER,
    ves NUMERIC(10,2),
    dlina NUMERIC(10,2),
    shirina NUMERIC(10,2),
    vysota NUMERIC(10,2),
    cod_otpravitelya INTEGER,
    summa_marok NUMERIC(10,2),

    FOREIGN KEY (trek_number)
        REFERENCES priem_korrespondencii (trek_number)
);

INSERT INTO priem_korrespondencii
(cod_pochti, trek_number, data_i_time, cennost,
itog_stoimost, oplacheno, data_i_time_otpravki)
VALUES
(101, 'TRK001', '2026-11-01 10:30:00', 500.00, 150.00, TRUE, '2026-11-02 12:00:00'),
(102, 'TRK002', '2026-11-01 11:00:00', 1000.00, 250.00, TRUE, '2026-11-02 13:00:00'),
(103, 'TRK003', '2026-11-01 12:15:00', 300.00, 100.00, FALSE, NULL),
(104, 'TRK004', '2026-11-01 13:20:00', 750.00, 200.00, TRUE, '2026-11-02 14:00:00'),
(105, 'TRK005', '2026-11-01 14:45:00', 200.00, 80.00, FALSE, NULL);


INSERT INTO korrespondenciya
(trek_number, cod_vida_korrespondencii, ves, dlina,
shirina, vysota, cod_otpravitelya, summa_marok)
VALUES
('TRK001', 1, 0.50, 20, 15, 10, 201, 50.00),
('TRK002', 2, 1.20, 30, 20, 15, 202, 75.00),
('TRK003', 1, 0.30, 15, 10, 5, 203, 30.00),
('TRK004', 3, 2.00, 40, 30, 20, 204, 100.00),
('TRK005', 2, 0.80, 25, 18, 12, 205, 60.00);