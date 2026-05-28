# Schema Understanding Document

## Dataset Overview

The CodeJudge dataset represents an online coding assessment and learning platform used to manage students, coding contests, practice problems, submissions, attendance, and evaluations.

The CSV files appear to be raw operational exports from the system. Some tables contain repeated or partially dependent information, therefore normalization is required before designing the final relational schema.


# students.csv

## Purpose

Stores information about students registered on the platform.

## Important Columns

| Column            | Meaning                            |
| ----------------- | ---------------------------------- |
| student_id        | Unique identifier for each student |
| roll_number       | Institute roll number              |
| full_name         | Name of student                    |
| email             | Student email address              |
| batch_id          | Batch assigned to student          |
| admission_date    | Student joining date               |
| enrollment_status | Current academic status            |
| graduation_year   | Expected graduation year           |

## Possible Identifiers

* student_id
* roll_number
* email

## Relationships

* linked with batches
* linked with enrollments
* linked with submissions
* linked with attendance

## Normalization Observation

Batch information should not be stored repeatedly inside student records.

# batches.csv

## Purpose

Stores academic batch or cohort information.

## Important Columns

| Column       | Meaning                 |
| ------------ | ----------------------- |
| batch_id     | Unique batch identifier |
| batch_code   | Batch code              |
| program      | Academic program        |
| start_date   | Batch start date        |
| end_date     | Batch completion date   |
| batch_status | Current status          |

## Relationships

* one batch contains many students

# courses.csv

## Purpose

Stores available courses in the platform.

## Important Columns

| Column        | Meaning                  |
| ------------- | ------------------------ |
| course_id     | Unique course identifier |
| course_code   | Official course code     |
| course_title  | Course name              |
| credit_hours  | Course credits           |
| course_status | Active/inactive course   |

## Relationships

* linked with enrollments
* linked with problems
* linked with contests
* linked with sessions


# enrollments.csv

## Purpose

Stores course registration information of students.

## Important Columns

| Column            | Meaning                  |
| ----------------- | ------------------------ |
| enrollment_id     | Enrollment identifier    |
| student_id        | Student enrolled         |
| course_id         | Selected course          |
| enrolled_on       | Enrollment date          |
| enrollment_status | Active/completed/dropped |
| final_grade       | Final grade              |

## Relationship Type

This table resolves the many-to-many relationship between students and courses.

# problems.csv

## Purpose

Stores coding problems used in practice or contests.

## Important Columns

| Column       | Meaning             |
| ------------ | ------------------- |
| problem_id   | Problem identifier  |
| course_id    | Related course      |
| problem_code | Short problem code  |
| title        | Problem title       |
| difficulty   | Difficulty level    |
| max_score    | Maximum marks       |
| created_at   | Creation timestamp  |
| is_active    | Availability status |

## Relationships

* one course can contain many problems
* one problem can contain many test cases

# test_cases.csv

## Purpose

Stores evaluation test cases for coding problems.

## Important Columns

| Column       | Meaning                 |
| ------------ | ----------------------- |
| test_case_id | Test case identifier    |
| problem_id   | Related problem         |
| case_no      | Sequence number         |
| points       | Marks assigned          |
| is_hidden    | Hidden/public test case |

## Relationships

* many test cases belong to one problem

# contests.csv

## Purpose

Stores coding contest information.

## Important Columns

| Column         | Meaning            |
| -------------- | ------------------ |
| contest_id     | Contest identifier |
| course_id      | Associated course  |
| contest_title  | Contest title      |
| start_time     | Contest start time |
| end_time       | Contest end time   |
| contest_status | Contest status     |

## Relationships

* one course can contain many contests

# contest_problems.csv

## Purpose

Mapping table connecting contests and problems.

## Why Needed

A contest can contain many problems and a problem can appear in many contests.

This creates a many-to-many relationship.

## Composite Key

(contest_id, problem_id)

# submissions.csv

## Purpose

Stores coding submissions made by students.

## Important Columns

| Column        | Meaning               |
| ------------- | --------------------- |
| submission_id | Submission identifier |
| student_id    | Student who submitted |
| problem_id    | Submitted problem     |
| contest_id    | Contest reference     |
| language      | Programming language  |
| submitted_at  | Submission time       |
| status        | Verdict               |
| score         | Obtained marks        |
| runtime_ms    | Execution runtime     |

## Relationships

* linked with students
* linked with problems
* linked with contests
* linked with test results

# test_results.csv

## Purpose

Stores execution results of submissions on each test case.

## Important Columns

| Column         | Meaning            |
| -------------- | ------------------ |
| result_id      | Result identifier  |
| submission_id  | Related submission |
| test_case_id   | Related test case  |
| result_status  | Pass/fail result   |
| runtime_ms     | Runtime            |
| memory_kb      | Memory usage       |
| awarded_points | Obtained marks     |

# sessions.csv

## Purpose

Stores course session or class information.

## Important Columns

| Column        | Meaning            |
| ------------- | ------------------ |
| session_id    | Session identifier |
| course_id     | Associated course  |
| session_title | Session topic      |
| session_date  | Session date       |
| session_type  | Lecture/lab/etc.   |

# attendance.csv

## Purpose

Stores attendance of students in sessions.

## Why Separate Table

One student can attend many sessions and one session contains many students.

This forms a many-to-many relationship.

# plagiarism_flags.csv

## Purpose

Stores plagiarism detection records between submissions.

## Important Columns

| Column                | Meaning               |
| --------------------- | --------------------- |
| flag_id               | Plagiarism record ID  |
| submission_id         | Flagged submission    |
| matched_submission_id | Similar submission    |
| similarity_score      | Similarity percentage |
| flag_status           | Current flag status   |


# regrade_requests.csv

## Purpose

Stores requests for re-evaluation of submissions.

## Important Columns

| Column         | Meaning                   |
| -------------- | ------------------------- |
| request_id     | Request identifier        |
| submission_id  | Related submission        |
| student_id     | Requesting student        |
| reason         | Reason for regrade        |
| request_status | Pending/approved/rejected |


# operation_requests.csv

## Purpose

Stores administrative operation logs and approval requests.

## Examples

* delete requests
* update requests
* bulk import requests


raw_student_import.csv
Purpose

Acts as a staging/raw import table before validation and normalization.

This table may contain:

* duplicate records
* invalid batch codes
* inconsistent formatting

Such raw data should be cleaned before insertion into normalized tables.
