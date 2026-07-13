--liquibase formatted sql

--changeset backend:001-enums
--splitStatements:false
--stripComments:false
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'user_role') THEN
    CREATE TYPE user_role AS ENUM ('teacher', 'student');
  END IF;
END$$;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'file_type') THEN
    CREATE TYPE file_type AS ENUM ('mmd', 'java');
  END IF;
END$$;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'submission_status') THEN
    CREATE TYPE submission_status AS ENUM ('pending', 'running', 'graded', 'error');
  END IF;
END$$;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'grade_source') THEN
    CREATE TYPE grade_source AS ENUM ('auto', 'teacher_override');
  END IF;
END$$;
--rollback DROP TYPE grade_source; DROP TYPE submission_status; DROP TYPE file_type; DROP TYPE user_role;