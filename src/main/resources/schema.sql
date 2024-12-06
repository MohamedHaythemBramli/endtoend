-- General Rules
-- Use underscore_names instead of camelCase
-- Table names should be plural
-- Spell out id fields (item_id instead of id)
-- Don't use ambiguous column names
-- Name foreign key columns the same as the columns they refer to
-- Use caps for all SQL queries

CREATE SCHEMA IF NOT EXISTS customers;
SET search_path TO customers;

DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users
(
    user_id      BIGSERIAL PRIMARY KEY,
    first_name   VARCHAR(50) NOT NULL,
    last_name    VARCHAR(50) NOT NULL,
    email        VARCHAR(100) NOT NULL,
    password     VARCHAR(255) DEFAULT NULL,
    address      VARCHAR(255) DEFAULT NULL,
    phone        VARCHAR(30) DEFAULT NULL,
    title        VARCHAR(50) DEFAULT NULL,
    bio          VARCHAR(255) DEFAULT NULL,
    enabled      BOOLEAN DEFAULT FALSE,
    non_locked   BOOLEAN DEFAULT TRUE,
    using_mfa    BOOLEAN DEFAULT FALSE,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    image_url    VARCHAR(255) DEFAULT 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
    CONSTRAINT uq_users_email UNIQUE (email)
);

DROP TABLE IF EXISTS roles CASCADE;

CREATE TABLE roles
(
    role_id    BIGSERIAL PRIMARY KEY,
    name       VARCHAR(50) NOT NULL,
    permission VARCHAR(255) NOT NULL,
    CONSTRAINT uq_roles_name UNIQUE (name)
);

DROP TABLE IF EXISTS user_roles CASCADE;

CREATE TABLE user_roles
(
    user_role_id BIGSERIAL PRIMARY KEY,
    user_id      BIGINT NOT NULL,
    role_id      BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles (role_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT uq_user_roles_user_id UNIQUE (user_id)
);

DROP TABLE IF EXISTS events CASCADE;

CREATE TABLE events
(
    event_id    BIGSERIAL PRIMARY KEY,
    type        VARCHAR(50) NOT NULL CHECK (type IN ('LOGIN_ATTEMPT', 'LOGIN_ATTEMPT_FAILURE', 'LOGIN_ATTEMPT_SUCCESS', 'PROFILE_UPDATE', 'PROFILE_PICTURE_UPDATE', 'ROLE_UPDATE', 'ACCOUNT_SETTINGS_UPDATE', 'PASSWORD_UPDATE', 'MFA_UPDATE')),
    description VARCHAR(255) NOT NULL,
    CONSTRAINT uq_events_type UNIQUE (type)
);

DROP TABLE IF EXISTS user_events CASCADE;

CREATE TABLE user_events
(
    user_event_id BIGSERIAL PRIMARY KEY,
    user_id       BIGINT NOT NULL,
    event_id      BIGINT NOT NULL,
    device        VARCHAR(100) DEFAULT NULL,
    ip_address    VARCHAR(100) DEFAULT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (event_id) REFERENCES events (event_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

DROP TABLE IF EXISTS account_verifications CASCADE;

CREATE TABLE account_verifications
(
    verification_id BIGSERIAL PRIMARY KEY,
    user_id         BIGINT NOT NULL,
    url             VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uq_account_verifications_user_id UNIQUE (user_id),
    CONSTRAINT uq_account_verifications_url UNIQUE (url)
);

DROP TABLE IF EXISTS reset_password_verifications CASCADE;

CREATE TABLE reset_password_verifications
(
    reset_id        BIGSERIAL PRIMARY KEY,
    user_id         BIGINT NOT NULL,
    url             VARCHAR(255) NOT NULL,
    expiration_date TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uq_reset_password_verifications_user_id UNIQUE (user_id),
    CONSTRAINT uq_reset_password_verifications_url UNIQUE (url)
);

DROP TABLE IF EXISTS two_factor_verifications CASCADE;

CREATE TABLE two_factor_verifications
(
    two_factor_id   BIGSERIAL PRIMARY KEY,
    user_id         BIGINT NOT NULL,
    code            VARCHAR(10) NOT NULL,
    expiration_date TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uq_two_factor_verifications_user_id UNIQUE (user_id),
    CONSTRAINT uq_two_factor_verifications_code UNIQUE (code)
);
