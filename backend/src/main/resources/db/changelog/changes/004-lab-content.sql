--liquibase formatted sql

--changeset backend:012-labs
CREATE TABLE labs (
    lab_id      SERIAL PRIMARY KEY,
    class_id    INTEGER NOT NULL REFERENCES classes(class_id) ON DELETE CASCADE,
    lab_number  SMALLINT NOT NULL,
    title       VARCHAR(150) NOT NULL,
    due_at      TIMESTAMP,
    UNIQUE (class_id, lab_number)
);
--rollback DROP TABLE labs;

--changeset backend:013-questions
CREATE TABLE questions (
    question_id      SERIAL PRIMARY KEY,
    lab_id           INTEGER NOT NULL REFERENCES labs(lab_id) ON DELETE CASCADE,
    question_number  SMALLINT NOT NULL,
    description      TEXT,
    weight           NUMERIC(6,2) NOT NULL CHECK (weight >= 0),
    UNIQUE (lab_id, question_number)
);
--rollback DROP TABLE questions;

--changeset backend:014-question-parts
CREATE TABLE question_parts (
    part_id      SERIAL PRIMARY KEY,
    question_id  INTEGER NOT NULL REFERENCES questions(question_id) ON DELETE CASCADE,
    part_number  SMALLINT NOT NULL,
    description  VARCHAR(255),
    weight       NUMERIC(6,2) NOT NULL CHECK (weight >= 0),
    UNIQUE (question_id, part_number)
);
--rollback DROP TABLE question_parts;

--changeset backend:015-solution-files
CREATE TABLE solution_files (
    file_id      SERIAL PRIMARY KEY,
    question_id  INTEGER NOT NULL REFERENCES questions(question_id) ON DELETE CASCADE,
    file_type    file_type NOT NULL,
    file_name    VARCHAR(150) NOT NULL,
    url          TEXT NOT NULL
);
--rollback DROP TABLE solution_files;

--changeset backend:016-testcases
CREATE TABLE testcases (
    test_id          SERIAL PRIMARY KEY,
    question_id      INTEGER NOT NULL REFERENCES questions(question_id) ON DELETE CASCADE,
    part_id          INTEGER REFERENCES question_parts(part_id) ON DELETE SET NULL,
    input            TEXT NOT NULL,
    expected_output  TEXT NOT NULL,
    is_hidden        BOOLEAN NOT NULL DEFAULT false
);
--rollback DROP TABLE testcases;