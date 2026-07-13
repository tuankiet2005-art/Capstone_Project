--liquibase formatted sql

--changeset backend:001-enums
CREATE TYPE IF NOT EXISTS user_role AS ENUM ('teacher', 'student');
CREATE TYPE IF NOT EXISTS file_type AS ENUM ('mmd', 'java');
CREATE TYPE IF NOT EXISTS submission_status AS ENUM ('pending', 'running', 'graded', 'error');
CREATE TYPE IF NOT EXISTS grade_source AS ENUM ('auto', 'teacher_override');
--rollback DROP TYPE grade_source; DROP TYPE submission_status; DROP TYPE file_type; DROP TYPE user_role;