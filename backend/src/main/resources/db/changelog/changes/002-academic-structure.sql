--liquibase formatted sql

--changeset backend:002-academic-years
CREATE TABLE academic_years (
    year_id     SERIAL PRIMARY KEY,
    year_label  VARCHAR(20) NOT NULL UNIQUE,
    start_date  DATE,
    end_date    DATE
);
--rollback DROP TABLE academic_years;

--changeset backend:003-terms
CREATE TABLE terms (
    term_id      SERIAL PRIMARY KEY,
    year_id      INTEGER NOT NULL REFERENCES academic_years(year_id) ON DELETE CASCADE,
    term_number  SMALLINT NOT NULL CHECK (term_number BETWEEN 1 AND 4),
    start_date   DATE,
    end_date     DATE,
    UNIQUE (year_id, term_number)
);
--rollback DROP TABLE terms;

--changeset backend:004-courses
CREATE TABLE courses (
    course_id    SERIAL PRIMARY KEY,
    course_code  VARCHAR(10) NOT NULL UNIQUE,
    course_name  VARCHAR(100) NOT NULL
);
--rollback DROP TABLE courses;

--changeset backend:005-classes
CREATE TABLE classes (
    class_id   SERIAL PRIMARY KEY,
    term_id    INTEGER NOT NULL REFERENCES terms(term_id) ON DELETE CASCADE,
    course_id  INTEGER NOT NULL REFERENCES courses(course_id) ON DELETE RESTRICT,
    UNIQUE (term_id, course_id)
);
--rollback DROP TABLE classes;

--changeset backend:006-class-groups
-- NOTE: fixed from the source doc, which had UNIQUE on class_id alone
-- (that would allow only one group per class). Composite unique below
-- allows multiple groups (V1, V2, E1, E2...) per class, one row per name.
CREATE TABLE class_groups (
    group_id    SERIAL PRIMARY KEY,
    class_id    INTEGER NOT NULL REFERENCES classes(class_id) ON DELETE CASCADE,
    group_name  VARCHAR(10) NOT NULL,
    UNIQUE (class_id, group_name)
);
--rollback DROP TABLE class_groups;