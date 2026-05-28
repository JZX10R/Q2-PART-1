# Keys and Relationships

# Primary Keys

| Table              | Primary Key   | Reason                                 |
| ------------------ | ------------- | -------------------------------------- |
| students           | student_id    | uniquely identifies each student       |
| batches            | batch_id      | uniquely identifies each batch         |
| courses            | course_id     | uniquely identifies each course        |
| enrollments        | enrollment_id | uniquely identifies enrollment records |
| problems           | problem_id    | uniquely identifies problems           |
| test_cases         | test_case_id  | uniquely identifies test cases         |
| contests           | contest_id    | uniquely identifies contests           |
| submissions        | submission_id | uniquely identifies submissions        |
| test_results       | result_id     | uniquely identifies execution results  |
| sessions           | session_id    | uniquely identifies sessions           |
| attendance         | attendance_id | uniquely identifies attendance records |
| plagiarism_flags   | flag_id       | uniquely identifies plagiarism reports |
| regrade_requests   | request_id    | uniquely identifies regrade requests   |
| operation_requests | operation_id  | uniquely identifies operation requests |

# Candidate Keys

Candidate keys are attributes capable of uniquely identifying rows.

Examples:

* students.email
* students.roll_number
* courses.course_code
* batches.batch_code
* problems.problem_code


# Alternate Keys

Alternate keys are candidate keys not selected as primary keys.

Examples:

* students.email
* students.roll_number
* batches.batch_code
* courses.course_code


# Composite Keys

| Table            | Composite Key                 | Reason                        |
| ---------------- | ----------------------------- | ----------------------------- |
| contest_problems | (contest_id, problem_id)      | prevents duplicate mappings   |
| enrollments      | (student_id, course_id)       | prevents duplicate enrollment |
| attendance       | (session_id, student_id)      | prevents duplicate attendance |
| test_results     | (submission_id, test_case_id) | prevents duplicate evaluation |


# Foreign Keys

| Child Table      | Foreign Key           | Parent Table |
| ---------------- | --------------------- | ------------ |
| students         | batch_id              | batches      |
| enrollments      | student_id            | students     |
| enrollments      | course_id             | courses      |
| problems         | course_id             | courses      |
| test_cases       | problem_id            | problems     |
| contests         | course_id             | courses      |
| contest_problems | contest_id            | contests     |
| contest_problems | problem_id            | problems     |
| submissions      | student_id            | students     |
| submissions      | problem_id            | problems     |
| submissions      | contest_id            | contests     |
| test_results     | submission_id         | submissions  |
| test_results     | test_case_id          | test_cases   |
| sessions         | course_id             | courses      |
| attendance       | session_id            | sessions     |
| attendance       | student_id            | students     |
| plagiarism_flags | submission_id         | submissions  |
| plagiarism_flags | matched_submission_id | submissions  |
| regrade_requests | submission_id         | submissions  |
| regrade_requests | student_id            | students     |


# NOT NULL Constraints

Columns that should not allow NULL values:

* student names
* roll numbers
* email addresses
* course titles
* contest titles
* submission timestamps
* attendance status
* result status

Reason:
Mandatory operational information should always exist to maintain database integrity.


# UNIQUE Constraints

| Column                | Reason                      |
| --------------------- | --------------------------- |
| students.email        | one email per student       |
| students.roll_number  | one roll number per student |
| batches.batch_code    | unique academic batch       |
| courses.course_code   | unique course code          |
| problems.problem_code | unique problem reference    |


# CHECK Constraints

| Constraint                                       | Purpose                       |
| ------------------------------------------------ | ----------------------------- |
| credit_hours > 0                                 | avoids invalid course credits |
| max_score >= 0                                   | prevents negative marks       |
| similarity_score BETWEEN 0 AND 100               | valid plagiarism percentage   |
| runtime_ms >= 0                                  | runtime cannot be negative    |
| memory_kb >= 0                                   | memory cannot be negative     |
| difficulty IN ('Easy','Medium','Hard')           | valid difficulty values       |
| attendance_status IN ('Present','Absent','Late') | valid attendance states       |


# Relationship Summary

## One-to-Many Relationships

* one batch → many students
* one course → many problems
* one course → many contests
* one course → many sessions
* one problem → many test cases
* one submission → many test results

## Many-to-Many Relationships

* students ↔ courses through enrollments
* contests ↔ problems through contest_problems
* students ↔ sessions through attendance
