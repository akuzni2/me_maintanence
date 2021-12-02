CREATE TABLE users (
    username varchar(255),
    password varchar(255),
    phone_number varchar(255),
    fhir_server_address varchar(255),
    patient_id int,
    PRIMARY KEY (username)
);

CREATE TABLE recommended_preventative_services (
    id int,
    search_term varchar(255),
    title varchar(255),
    description text,
    gender varchar(255),
    age_range_min int,
    age_range_max int,
    smoking_history boolean,
    recurring boolean,
    annual_interval float(2)
);

CREATE TABLE reminders (
    id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    preventative_care_id int,
    username varchar(64),
    next_reminder_date_epoch bigint,
);

