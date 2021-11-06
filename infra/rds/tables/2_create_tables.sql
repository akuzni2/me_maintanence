CREATE TABLE users (
    username varchar(255),
    password varchar(255),
    phone_number varchar(255),
    fhir_server_address varchar(255),
    patient_id int,
    PRIMARY KEY (username)
);