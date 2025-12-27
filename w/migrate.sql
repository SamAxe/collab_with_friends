DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS containers;

CREATE TABLE containers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    author_id INTEGER
);

DROP TABLE IF EXISTS items;

CREATE TABLE items (
  id INTEGER PRIMARY KEY,
  container_id INTEGER NOT NULL,
  parent_id INTEGER,         -- NULL for top-level posts
  next_id INTEGER,           -- NULL for the last item
  content TEXT NOT NULL,
  author_id INTEGER NOT NULL,
  created_at INTEGER NOT NULL,
  FOREIGN KEY(container_id) REFERENCES containers(id),
  FOREIGN KEY(parent_id) REFERENCES items(id),
  FOREIGN KEY(next_id) REFERENCES items(id),
  FOREIGN KEY(author_id) REFERENCES users(id)
);


DROP TABLE IF EXISTS dream_session;

CREATE TABLE dream_session (
  id TEXT PRIMARY KEY,
  label TEXT NOT NULL,
  expires_at REAL NOT NULL,
  payload TEXT NOT NULL
);
