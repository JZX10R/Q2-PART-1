BATCHES
   |
   | 1-to-many
   v
STUDENTS
   |
   | many-to-many
   v
ENROLLMENTS >------ COURSES
                        |
                        +------ PROBLEMS
                        |            |
                        |            +------ TEST_CASES
                        |
                        +------ CONTESTS
                        |            |
                        |            +------ CONTEST_PROBLEMS >------ PROBLEMS
                        |
                        +------ SESSIONS
                                     |
                                     +------ ATTENDANCE >------ STUDENTS

STUDENTS
   |
   +------ SUBMISSIONS >------ PROBLEMS
                    |
                    +------ TEST_RESULTS >------ TEST_CASES
                    |
                    +------ PLAGIARISM_FLAGS
                    |
                    +------ REGRADE_REQUESTS
