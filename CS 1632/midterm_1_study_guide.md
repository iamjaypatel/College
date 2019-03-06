# CS 1632 Midterm 1 Exam Study Guide - Spring 2019

The midterm is on the last day of classes before Spring Break (6 MAR for students in M/W classes; 7 MAR for students in the T/H class).  You will have the entire class period to complete it.


The midterm will cover everything we have covered up to the last class in February (either 27 FEB or 28 FEB).  It will NOT cover the automated systems testing lecture on 4 MAR or 5 MAR.  I recommend you review the slides and the textbook (see syllabus.md for reminders of which chapters were required reading).

Here are the key topics to study in preparation for the test.

## TESTING THEORY AND TERMINOLOGY
* Equivalence class partitioning
    - We can partition the testinf parameters into "eqvuivalence classes"
    - Equivalence class: a natural grouping of values with similar behavior or belonging to the same category.
* Boundary and interior values
* Base, Edge, and Corner cases
    - Base: An element in an equivalence class that is not around a boundry or an expected use case.
    - Edge: An element in an equivalence class that is next to a boundry OR an unexpected use case.
    - Corner: A case which can only occur outside of normal operating parameters. or a combination of multiple edge cases.
* Static vs Dynamic testing
  * Know the differences and examples of each
    - Static: Code is not executed
      - The code is reviewed by a person or external program, without being executed
        - Examples:
          - Code walkthroughs and reviews
          - Requirement analysis
          - Source code analysis
    - Dynamic testing: code is executed(at least some of it).
        - The tests that user does.
* Black/White/Grey box testing
  * Know the differences and examples of each
    - Black-box testing: testing with no knowledge of the interior structure or code of the application. Tests are often performed form the user's prespective, looking at the system as a whole.
    - White-box testing: Testing with explicit knowledge of the interior structure and codebase, and directly testing that code. Tests are often ar a lower level.
    - Gray-box testing: Testing with knoeledge of the interior structure and codebase of the system under test, but not directly testing the code. Tests are similar to black-box tests, but are informed by the tester's knowledge of the codebase.

## REQUIREMENTS ANALYSIS
* What makes a good or bad requirement?
  - Requirements: the specifications of the software. They say WHAT to do, not HOW to do it.
  - Good:
* Testability - requirements must be:
  * Complete, consistent, unambiguous, quantitative, feasible
    - Complete: Requirements should cover all aspects of a system. Anything not covered in requirements is liable to be interpreted differently.
    - Consistent: Requirements must be internally and externally consistent. They must not contradict each other.
    - Unambiguous:
      - BAD: When the database system stores a String and an invalid Date, it should be set to the default value.
      - GOOD: When the database system stores a String and an invalid Date, the Date should be set to the default value.
    - Quantitative:
      - BAD: The system shall be responsive to the user
      - GOOD: When running locally, user shall receive results in less than 1 second for 99% of expected queries.
    - Feasible:
      - BAD: The system shall complete processing of a 100 TB data set within 4,137 years.
      - GOOD: The system shall complete processing of a 1 MB data set within 4 hours.
* Functional vs Non-Functional Requirements  (Quality Attributes)
  * Be able to define and write your own
    - Functional Req: Specify the functional behavior of the system.
      - The system shall do X [under conditions Y].
      - Ex: The system shall return the string 'NONE' if no elements match the query.
    - Quality Attributes: Specify the overall qualities of the system, not a specific behavior.
      - The system shall be X [under conditions Y].
      - Ex: The system shall be protected against unauthorized access.
* Traceability Matrices
  * Be able to define and write your own
    - Lists all requirements and which test cases are associated with that test case.

## TEST PLANS
* Given a list of requirements, be able to write a test plan
* Terminology: test cases, test plans, test suites, test runs
  - Test Case: is the fundamental "unit" of a test plan.
  - Test Plan: is a sequence of test cases.
  - Test Suite: a group of test plan.
  - Test Run: An actual run-through of a test plan or test suite.
* Verification vs validation

## DEFECT REPORTING
* Be prepared to report a defect based on a test case
* Remember the defect template:
  * SUMMARY, DESCRIPTION, REPRODUCTION STEPS, EXPECTED BEHAVIOR, OBSERVED BEHAVIOR
  * Optionally: SEVERITY/IMPACT, NOTES
  * Levels of severity: BLOCKER, CRITICAL, MAJOR, NORMAL, MINOR, TRIVIAL
* Coding mistakes vs defects

## Smoke, Exploratory, and Path-based testing
* Define all of these concepts
  - Exploratory: Learning how the system works.
  - Smoke: Do some minimal testing to ensure that the system is, in fact, testable or ready to be released.
  - Path-based Testing: What are all the possible paths through a program/method/etc? Then test all of the paths. Similar to equivalence class partitioning.
* I will not ask you to calculate cyclomatic complexity for a given method but I expect you to understand the concept and explain why a method with a higher or lower complexity might be easier/harder to test and why
  - Lower cyclomatic complexity means lower risk, easier to understand.
  - Higher complexity means more chances of defects.

## AUTOMATED TESTING
* Pros and cons of automated testing
  - Pros:
    - No chance for human error
    - Fast test execution
    - Repeatable
  - Cons:
    - Requires extra time up-front
    - May not catch user-facing bugs.
    - It only tests what it is looking for.
* Unit tests vs system tests

## UNIT TESTING
* Unit tests
  * Pay special attention to assertions
  * Understand how to write a Minitest unit test (basic syntax)
* Given some Ruby code, be able to perform an equivalence class partitioning and write tests for it

## BREAKING SOFTWARE
* Be prepared to think of happy path vs edge case testing
* What are various ways that software can break?

## STATIC ANALYSIS
* Understand static vs dynamic testing
  - Static: code is not executed by the test.
    - Code coverage, code review, etc.
  - Dynamic: Code is executed by the test.
* Understand limitations of static testing
* Know different kinds of static analysis, and tools and methods used (e.g. linters, bug finders, code coverage, code metrics, code reviews)
* You do NOT need to know specific Rubocop/Reek errors, but should understand what Rubocop and Reek do and what they might catch or not
* Understand code coverage and be able to calculate
* Understand difference between statement and method coverage

## TDD
* Basic concepts of test-first development
  - Writing tests BEFORE writing code.
  - Writing ONLY code that is tested.
  - Writing ONLY tests that test the code.
  - A very short turnaround cycle.
  - Refactoring early and often.
* The red-green-refactor loop
  - Red: Write a test for a new functionality.
    - This should immediately fail!
  - Green: Write only enough code to make the test pass.
  - Refractor: Review code and make it better.
* Benefits and drawbacks of TDD
  - Benefits:
    - Automatically creates Tests.
    - Makes writing tests easy because it's done often.
    - Tests are relevant.
    - Developer is focused on end result, not code.
  - Drawbacks:
    - Extra up-front time.
    - May not appropriate for prototyping.
    - Could fall into trap of over testing.
    - Tests become part of the overhead of the project.

## WRITING TESTABLE CODE
* What do we mean by "testable code"?
  - Easy to write and perform tests, automated and manual, at various levels of abstraction, and track down errors when tests fail.
* Basic strategies for testable code
  - Segment code - make it modular.
  - Give yourself something to test.
  - Make it repeatable.
  - DRY(Don't repeat yourself).
  - Write code with seams.
* Code segmentation
  - Methods should be SMALL and SPECIFIC- "Do one thing and do it well"
* Pure vs impure methods - be prepared to define and/or determine if a method is pure or not
  - Pure: Output only depends on input.
  - impure: results depend on things other than arguments.
* The DRY Principle - how could you DRY up some code?
  - Make a generic method, and don't copy and paste code.
* Understand seams - be able to re-write a method to have a seam.
* Dependency injection - what is it?  Be able to re-write a method to use dependency injection.
  - Passing in any objects that a method relies on.
