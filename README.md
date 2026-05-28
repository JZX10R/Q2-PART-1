This repository contains the relational database design and normalization analysis for the CodeJudge dataset.

The assignment focuses on:

* understanding raw CSV data
* identifying entities and relationships
* applying relational database concepts
* defining keys and constraints
* normalization
* SQL schema design
* ERD creation

Repository Files

| File Name                 | Purpose                             |
| ------------------------- | ----------------------------------- |
| README.md                 | Project overview                    |
| schema.sql                | SQL DDL schema                      |
| schema_explanation.md     | Raw data and schema understanding   |
| keys_and_relationships.md | Keys, constraints and relationships |
| normalization_notes.md    | Normalization analysis              |
| erd.md                    | ERD / relationship diagram          |
| assumptions.md            | Design assumptions                  |


Database Design Summary

The raw CSV files appear to be operational exports from the CodeJudge platform. The data includes students, batches, courses, contests, coding problems, submissions, attendance, and evaluation-related information.

A normalized relational schema was designed to:

* reduce redundancy
* maintain data integrity
* support scalable querying
* enforce relational consistency

The final design approximately follows:

* First Normal Form (1NF)
* Second Normal Form (2NF)
* Third Normal Form (3NF)

Main Entities

* Students
* Batches
* Courses
* Enrollments
* Problems
* Test Cases
* Contests
* Contest Problems
* Submissions
* Test Results
* Sessions
* Attendance
* Regrade Requests
* Plagiarism Flags
* Operation Requests

Design Highlights

* Many-to-many relationships handled using mapping tables
* Composite keys used where logically required
* Foreign keys added for referential integrity
* CHECK constraints used for validation
* UNIQUE constraints added for candidate keys
* Raw import data separated into staging tables
