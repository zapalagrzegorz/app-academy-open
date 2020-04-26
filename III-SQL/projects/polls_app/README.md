# Polls

In the spirit of enfranchisement, we're going to build a polling app today!
Learning Goals

    - Be able to write migrations with indices and constraints
    - Know how to fix the effects of incorrect migrations
    - Be able to write associations
    - Know how to seed a project's database
    Be able to write custom validations in the model
    Be able to solve the N+1 query problem

Make sure to refer to the ActiveRecord documentation and this ActiveRecord query guide for help with writing your queries.

Generate a new rails project called PollsApp. Refer to yesterday's instructions if you need a reminder. Remember that the --database flag allows us to specify PostgreSQL as our database and the -G flag prevents rails from initializing our project as a git repository (this is useful today since we'll be pushing this project inside our repository for today's work and we want to avoid creating nested repos).

rails new polls_app -G --database=postgresql.

## Schema

You need to implement the following schema. Try drawing it out first to visualize how the models interact with each other. Ask a TA if you have any questions at this point. Then go ahead and create your migration. Don't forget to add appropriate indices and constraints!

    User
        Record a username; make sure it is unique.
    Poll
        A Poll belongs to an author (User)
        Record a title.
    Question
        A Poll has many Questions. Record the text.
    AnswerChoice
        A Question has many AnswerChoices. These are the options that a User can choose from when responding to the question. Record the text.
    Response
        A User answers to a Questions by choosing an AnswerChoice.
        What pair of foreign keys will you need?

## Associations

Now go ahead and create your models. Write the following associations:

    User
        authored_polls
        responses
    Poll
        author
        questions
    Question
        answer_choices
        poll
    AnswerChoice
        question
        responses
    Response
        answer_choice
        respondent

## Seed The Database

At this point, it might be nice to have some data to play around with so you can test easily. Go ahead and open up db/seeds.rb and use normal Rails commands to create some seed data. Then run bundle exec rails db:seed.

If your column names are different, you may have to tweak the seed file first (this would be a good excuse to utilize that ⌘D shortcut).
Model Level Validations

Add presence and uniqueness validations wherever required.

N.B. Remember, Rails 5 automatically validates the presence of belongs_to associations.
User Can't Create Multiple Responses To The Same Question

We will write a custom validation method, not_duplicate_response, to check that the respondent has not previously answered this question. This is a deceptively hard thing to do and will require several steps:
Step 1: Response#sibling_responses

We'll write a method Response#sibling_responses. This should return all the other Response objects for the same Question. To do this, first add the following associations:
Response#question

This is a has_one through: association. has_one through: works exactly like has_many through: (it has through and source options). The only difference is it returns a single object (or nil) instead of an Array (or empty array).
Question#responses

This is a has_many through: association. You've got this :-)
Singling Yourself Out

Having written these associations, we should be able to write Response#sibling_responses by (1) calling #question and then (2) calling #responses on the question.

But wait... won't the current response be included in response.question.responses? I'm not my own sibling, and neither should a response be its own sibling.

The answer is yes and no. Since #responses is issuing a query, if the original response has not been saved to the DB, #sibling_responses will not contain it. However, once it's persisted to the DB, the query will return it. Test this out by building a new (unsaved) record and calling sibling_responses and then saving it and calling sibling_responses again.

This be not good. How can we fix this?

Remember how associations are actually lazy-loading chain-able query objects? Let's chain a where clause on here to filter out responses with the same id as self.id.

NB: Don't forget that you need to use where.not here because of SQL ternary logic.
Step 2: not_duplicate_response

Next use Response#sibling_responses to write Response#respondent_already_answered?. This is a predicate method that checks to see if any sibling exists? with the same respondent_id.

Now you can (finally) implement your validation. Use #respondent_already_answered? to write a custom validation method that will ensure that the respondent has not already answered it.
Author Can't Respond To Own Poll

Enforce that the creator of the poll must not answer their own questions: don't let the creator rig the results!

The simplest way is to use associations to traverse from a Response object back to the AnswerChoice, to the Question, and finally the Poll. You can then verify whether the poll's author is the same as the respondent_id. This may involve multiple queries, but we will later improve this. Don't spend too much time trying to refactor the method right now. Many students have gone down this deep, dark rabbit hole and you'll have time to explore it later.

NB If you are having trouble with this portion, read the following. Don't read it until you've attempted it yourself!!

If you are creating a through association that uses another through association, there is a Rails bug that makes this return nil if the record is unsaved. Even Rails has its own list of bugs! To fix this, explicitly use response.question.poll. You might ask, why has Rails not fixed this yet? It is extremely rare to make such tenuous associations in real app development, so it hasn't been a priority. You'll come to see that there are bugs and issues in all code, even in your operating system and the implementations of Ruby! There is a limited amount of developers and time.
Poll results

Write a method Question#results that returns a hash of choices and counts like so:

q = Question.first
q.title
# => "Who is your favorite cat?"
q.results
# => { "Earl" => 3, "Breakfast" => 3, "Maru" => 300 }

First, do this with an N+1 query. Get all the answer_choices for the question, then call responses.count for each.

Second, use includes to pre-fetch all the responses at the same time you fetch the answer_choices. Test this to see that it makes two queries, and not N+1. (Due to ActiveRecord weirdness, use responses.length instead of responses.count).

This way is not ideal; it causes all responses to be transfered to the client even though we only want to count the number of them. This is wasteful. Improve your solution. First, write out the SQL that would return answer choice rows, augmented with a column that counts the number of responses to that answer choice. Hints:

    Use SELECT answer_choices.*, COUNT(...)
    You'll need to combine data from both the answer_choices and responses tables.
    You'll want to keep only those answer_choices for the relevant question.
    If you want to count rows for each answer choices, you'll want a GROUP BY somehow.
    Be careful not to filter out answer_choices merely because there are no responses choosing it. These should have a count of zero.
    COUNT(*) counts the number of rows in a group; COUNT(col_name) counts the number of rows where col_name IS NOT NULL.

Show your TA your SQL code. Having done this, write the query in ActiveRecord. Hints:

    You'll want your self.answer_choices association
    You'll want to use select, left_outer_joins, and group.