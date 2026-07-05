--liquibase formatted sql

--changeset backend:001-enums
CREATE TYPE user_role AS ENUM ('teacher', 'student');
CREATE TYPE file_type AS ENUM ('mmd', 'java');
CREATE TYPE submission_status AS ENUM ('pending', 'running', 'graded', 'error');
CREATE TYPE grade_source AS ENUM ('auto', 'teacher_override');
--rollback DROP TYPE grade_source; DROP TYPE submission_status; DROP TYPE file_type; DROP TYPE user_role;