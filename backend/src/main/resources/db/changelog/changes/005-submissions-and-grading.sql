--liquibase formatted sql

--changeset backend:017-submissions
CREATE TABLE submissions (
    submission_id   SERIAL PRIMARY KEY,
    student_id      INTEGER NOT NULL REFERENCES students(user_id) ON DELETE CASCADE,
    question_id     INTEGER NOT NULL REFERENCES questions(question_id) ON DELETE CASCADE,
    attempt_number  SMALLINT NOT NULL DEFAULT 1,
    submitted_at    TIMESTAMP NOT NULL DEFAULT now(),
    status          submission_status NOT NULL DEFAULT 'pending',
    total_score     NUMERIC(6,2),
    max_score       NUMERIC(6,2),
    UNIQUE (student_id, question_id, attempt_number)
);
--rollback DROP TABLE submissions;

--changeset backend:018-submission-files
CREATE TABLE submission_files (
    submission_file_id  SERIAL PRIMARY KEY,
    submission_id       INTEGER NOT NULL REFERENCES submissions(submission_id) ON DELETE CASCADE,
    file_type           file_type NOT NULL,
    file_name           VARCHAR(150) NOT NULL,
    url                 TEXT NOT NULL,
    uploaded_at         TIMESTAMP NOT NULL DEFAULT now()
);
--rollback DROP TABLE submission_files;

--changeset backend:019-test-results
CREATE TABLE test_results (
    result_id       SERIAL PRIMARY KEY,
    submission_id   INTEGER NOT NULL REFERENCES submissions(submission_id) ON DELETE CASCADE,
    test_id         INTEGER NOT NULL REFERENCES testcases(test_id) ON DELETE CASCADE,
    passed          BOOLEAN NOT NULL,
    actual_output   TEXT,
    error_message   TEXT,
    execution_time  INTEGER,
    run_at          TIMESTAMP NOT NULL DEFAULT now(),
    UNIQUE (submission_id, test_id)
);
--rollback DROP TABLE test_results;

--changeset backend:020-class-feedbacks
CREATE TABLE class_feedbacks (
    feedback_id    SERIAL PRIMARY KEY,
    submission_id  INTEGER NOT NULL REFERENCES submissions(submission_id) ON DELETE CASCADE,
    file_type      file_type NOT NULL,
    class_name     VARCHAR(150) NOT NULL,
    issue_type     VARCHAR(50) NOT NULL,
    message        TEXT NOT NULL,
    created_at     TIMESTAMP NOT NULL DEFAULT now()
);
--rollback DROP TABLE class_feedbacks;

--changeset backend:021-part-grades
CREATE TABLE part_grades (
    submission_id  INTEGER NOT NULL REFERENCES submissions(submission_id) ON DELETE CASCADE,
    part_id        INTEGER NOT NULL REFERENCES question_parts(part_id) ON DELETE CASCADE,
    auto_score     NUMERIC(6,2),
    final_score    NUMERIC(6,2),
    source         grade_source NOT NULL DEFAULT 'auto',
    feedback       TEXT,
    graded_by      INTEGER REFERENCES teachers(user_id),
    graded_at      TIMESTAMP,
    PRIMARY KEY (submission_id, part_id)
);
--rollback DROP TABLE part_grades;