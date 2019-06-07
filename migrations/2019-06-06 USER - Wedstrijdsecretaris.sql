-- +migrate Up
CREATE LOGIN Wedstrijdsecretaris   
    WITH PASSWORD = 'i2fi8Y8rkG4T2y7zT69oVqE97qY';  

-- +migrate Up  
CREATE USER Wedstrijdsecretaris FOR LOGIN Wedstrijdsecretaris;  

-- +migrate Up
GRANT EXECUTE TO Wedstrijdsecretaris;

-- +migrate Down
DROP USER Wedstrijdsecretaris;

-- +migrate Down
DROP LOGIN Wedstrijdsecretaris;
