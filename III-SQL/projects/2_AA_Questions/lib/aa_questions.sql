DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS questions;

DROP TABLE IF EXISTS question_follows;

DROP TABLE IF EXISTS replies;

DROP TABLE IF EXISTS question_likes;

PRAGMA foreign_keys = ON;

-- USERS
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Grzegorz', 'Zapala'),
  ('Kamil', 'Kisiel'),
  ('Bogdan', 'Zapala'),
  ('John', 'Kennedy'),
  ('Michal', 'Bogucki');


-- QUESTIONS
CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  questions (title, body, user_id)
VALUES
  (
    'Ile za semestr?',
    'Chciałbym się dowiedzieć ile kosztuje u was semestr nauki',
    (
      SELECT
        id
      FROM
        users
      WHERE
        fname = 'Grzegorz'
        AND lname = 'Zapala'
    )
  ),
  (
    'Kiedy można zrezygnować?',
    'Do upływu jakiego czasu można zrezygnować ze zwrotem środków?',
    (
      SELECT
        id
      FROM
        users
      WHERE
        fname = 'Kamil'
        AND lname = 'Kisiel'
    )
  ),
  (
    'Czemu u was tak drogo?',
    'Jak w tytule?',
    (
      SELECT
        id
      FROM
        users
      WHERE
        fname = 'Kamil'
        AND lname = 'Kisiel'
    )
  ),
  (
    'Czy mogę wziać urlop?',
    'Urlopik - content',
    (
      SELECT
        id
      FROM
        users
      WHERE
        fname = 'Kamil'
        AND lname = 'Kisiel'
    )
  );

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (1, 4),
  (2, 1),
  (3, 1),
  (4, 1),
  (5, 1);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  author_id INTEGER NOT NULL,
  body VARCHAR(255) NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
  replies (
    question_id,
    parent_reply_id,
    author_id,
    body
  )
VALUES
  (
    1,
    null,
    2,
    "Po co pytasz skoro i tak się nie zapiszesz"
  ),
  -- odpowiedź (komentarz) do pierwszej odpowiedzi
  (1, 1, 3, "Jesteś po prostu niegrzeczny"),
  (2, null, 1, "Musiałem coś powiedzieć");

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (1, 4),
  (2, 1),
  (3, 1);