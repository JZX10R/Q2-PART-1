# Normalization Notes

## Redundancy Analysis

### 1. Batch Information Repetition

If batch details such as program name or batch code were stored directly inside the students table, the same data would repeat for every student belonging to that batch.

### Solution

A separate `batches` table is created and students reference it using `batch_id`.


### 2. Contest Problems Repetition

If problems were stored directly as multiple columns inside contests, the schema would become repetitive and inflexible.

### Solution

A separate mapping table `contest_problems` is used to represent the many-to-many relationship.


### 3. Attendance Data Repetition

If attendance data were stored directly inside sessions, student information would repeat multiple times for each session.

### Solution

A separate `attendance` table is created.


## Table Separation Improvements

### 1. Test Cases Separated from Problems

One coding problem can contain multiple test cases. Storing them separately prevents repeated problem information.

### 2. Test Results Separated from Submissions

Each submission may generate multiple execution results. Separating them improves scalability and normalization.


# Functional Dependencies

## Students Table

student_id → roll_number, full_name, email, batch_id

Meaning:
The student_id uniquely determines all student-related attributes.


## Courses Table

course_id → course_code, course_title, credit_hours


## Enrollments Table

enrollment_id → student_id, course_id, final_grade


# Partial Dependency Example

In `contest_problems`, the attribute `problem_order` depends on the full composite key `(contest_id, problem_id)`.

# First Normal Form (1NF)

The schema satisfies 1NF because:

* all attributes are atomic
* repeating groups are removed
* every row is uniquely identifiable


# Second Normal Form (2NF)

The schema satisfies 2NF because:

* non-key attributes fully depend on primary keys
* partial dependencies are removed

# Third Normal Form (3NF)

The schema approximately satisfies 3NF because:

* transitive dependencies are minimized
* descriptive attributes are separated into dedicated tables


# Trade-Offs

Some denormalization is intentionally allowed for performance optimization.

Examples:

* submission status stored directly in submissions
* runtime stored in both submissions and test_results

These improve reporting efficiency while keeping redundancy manageable.
