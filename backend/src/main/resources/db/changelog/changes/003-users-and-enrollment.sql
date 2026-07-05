--liquibase formatted sql

--changeset backend:007-users
CREATE TABLE users (
    user_id       SERIAL PRIMARY KEY,
    email         VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name     VARCHAR(100) NOT NULL,
    role          user_role NOT NULL
);
--rollback DROP TABLE users;

--changeset backend:008-teachers
CREATE TABLE teachers (
    user_id       INTEGER PRIMARY KEY REFERENCES users(user_id) ON DELETE CASCADE,
    teacher_code  VARCHAR(30) UNIQUE
);
--rollback DROP TABLE teachers;

--changeset backend:009-students
CREATE TABLE students (
    user_id         INTEGER PRIMARY KEY REFERENCES users(user_id) ON DELETE CASCADE,
    student_number  VARCHAR(30) NOT NULL UNIQUE
);
--rollback DROP TABLE students;

--changeset backend:010-assigned-teachers
CREATE TABLE assigned_teachers (
    class_id    INTEGER NOT NULL REFERENCES classes(class_id) ON DELETE CASCADE,
    teacher_id  INTEGER NOT NULL REFERENCES teachers(user_id) ON DELETE CASCADE,
    is_primary  BOOLEAN NOT NULL DEFAULT true,
    PRIMARY KEY (class_id, teacher_id)
);
--rollback DROP TABLE assigned_teachers;

--changeset backend:011-enrollments
CREATE TABLE enrollments (
    group_id     INTEGER NOT NULL REFERENCES class_groups(group_id) ON DELETE CASCADE,
    student_id   INTEGER NOT NULL REFERENCES students(user_id) ON DELETE CASCADE,
    enrolled_at  DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (group_id, student_id)
);
--rollback DROP TABLE enrollments;