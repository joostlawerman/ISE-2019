-- +migrate Up
CREATE LOGIN MisjaNabben   
    WITH PASSWORD = 'i2fi8Y8rkG4T2y7zT69oVqE97qY';  

-- +migrate Up  
CREATE USER MisjaNabben FOR LOGIN MisjaNabben;  

-- +migrate Up
GRANT EXECUTE, SELECT, INSERT, UPDATE, DELETE TO MisjaNabben;

-- +migrate Down
DROP USER MisjaNabben;

-- +migrate Down
DROP LOGIN MisjaNabben;
