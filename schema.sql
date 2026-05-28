```sql
CREATE TABLE batches (
    batch_id INT PRIMARY KEY,
    batch_code VARCHAR(20) UNIQUE NOT NULL,
    program VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    batch_status VARCHAR(20) NOT NULL
);

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    roll_number VARCHAR(30) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    batch_id INT NOT NULL,
    admission_date DATE NOT NULL,
    enrollment_status VARCHAR(20) NOT NULL,
    graduation_year INT,
    FOREIGN KEY (batch_id) REFERENCES batches(batch_id)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_title VARCHAR(100) NOT NULL,
    course_status VARCHAR(20) NOT NULL,
    credit_hours INT CHECK (credit_hours > 0)
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrolled_on DATE NOT NULL,
    enrollment_status VARCHAR(20) NOT NULL,
    final_grade VARCHAR(5),
    UNIQUE(student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE problems (
    problem_id INT PRIMARY KEY,
    course_id INT NOT NULL,
    problem_code VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(200) NOT NULL,
    difficulty VARCHAR(10) CHECK (difficulty IN ('Easy','Medium','Hard')),
    max_score INT CHECK (max_score >= 0),
    created_at TIMESTAMP NOT NULL,
    is_active BOOLEAN NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE test_cases (
    test_case_id INT PRIMARY KEY,
    problem_id INT NOT NULL,
    case_no INT NOT NULL,
    points INT CHECK (points >= 0),
    is_hidden BOOLEAN NOT NULL,
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id)
);

CREATE TABLE contests (
    contest_id INT PRIMARY KEY,
    course_id INT NOT NULL,
    contest_title VARCHAR(200) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    contest_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE contest_problems (
    contest_id INT NOT NULL,
    problem_id INT NOT NULL,
    problem_order INT NOT NULL,
    PRIMARY KEY (contest_id, problem_id),
    FOREIGN KEY (contest_id) REFERENCES contests(contest_id),
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id)
);

CREATE TABLE submissions (
    submission_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    problem_id INT NOT NULL,
    contest_id INT,
    language VARCHAR(30) NOT NULL,
    submitted_at TIMESTAMP NOT NULL,
    status VARCHAR(30) NOT NULL,
    score DECIMAL(5,2),
    runtime_ms INT CHECK (runtime_ms >= 0),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id),
    FOREIGN KEY (contest_id) REFERENCES contests(contest_id)
);

CREATE TABLE test_results (
    result_id INT PRIMARY KEY,
    submission_id INT NOT NULL,
    test_case_id INT NOT NULL,
    result_status VARCHAR(20) NOT NULL,
    runtime_ms INT CHECK (runtime_ms >= 0),
    memory_kb INT CHECK (memory_kb >= 0),
    awarded_points INT CHECK (awarded_points >= 0),
    FOREIGN KEY (submission_id) REFERENCES submissions(submission_id),
    FOREIGN KEY (test_case_id) REFERENCES test_cases(test_case_id)
);
```
