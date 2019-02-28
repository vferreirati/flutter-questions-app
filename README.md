
# Quizr
Quizr is my open source prototype of my soon to be released Quiz App.
It has the main feature of allowing the user to study by answering questions from Brazil's most important exams like ENEM, USP, UFRJ and more.
Being a prototype, Quizr only works with mock data. 

## Core Features
- Training mode: Take your time to answer the questions, see the correct answer after you take a guess.
- Simulation mode: You have to complete the exam before certain time or you will get a bad score!
- Question filtering: Don't want to study math? Only want the most recent questions? Choose the options that fits you!

## Implementation Details
A few libraries were used on this prototype and a few weren't.
Here's why some of these libraries were used:

- Dio: It's used instead of Http because i want to be able to check my authentication status before making requests to my backend. This way i can refresh tokens and deal with problems more easily.
- Connectivity: Used to check connectivity status before making requests.
- RxDart: Rx is love, Rx is life. Also is the BLoC pattern.
- Kiwi: Dependency Injection is also love and life.


