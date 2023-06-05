-- Active: 1685972715522@@127.0.0.1@3306

CREATE TABLE
    users(
        id TEXT PRIMARY KEY UNIQUE NOT NULL,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        role TEXT NOT NULL,
        created_at TEXT DEFAULT (DATETIME()) NOT NULL
    );

CREATE TABLE
    posts(
        id TEXT PRIMARY KEY UNIQUE NOT NULL,
        creator_id TEXT NOT NULL,
        content TEXT NOT NULL,
        likes INTEGER NOT NULL,
        dislikes INTEGER NOT NULL,
        created_at TEXT DEFAULT (DATETIME()) NOT NULL,
        updated_at TEXT DEFAULT (DATETIME()) NOT NULL,
        FOREIGN KEY (creator_id) REFERENCES users (id)
    );

CREATE TABLE
    likes_dislikes(
        user_id TEXT NOT NULL,
        post_id TEXT NOT NULL,
        like INTEGER NOT NULL,
        created_at TEXT DEFAULT (DATETIME()) NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id),
        FOREIGN KEY (post_id) REFERENCES posts (id)
    );

SELECT *
FROM posts.likes
    INNER JOIN likes_dislikes.like on posts.id = likes_dislikes.post_id; 

INSERT INTO
    posts (
        id,
        creator_id,
        content,
        likes,
        dislikes
    )
VALUES ("02", "uo5", "dcex", 500, 50);

SELECT * FROM users;

SELECT * FROM posts;

SELECT * FROM likes_dislikes;



const result: PostsModel[] = [];
for (let post of allPosts) {
  const [posts]: PostsModel[] = await db("posts")
    .select(
      "posts.id",
      "posts.content",
      "posts.likes",
      "posts.dislikes",
      "posts.created_at AS createdAt",
      "posts.updated_at AS updatedAt"
    )
    .where("posts.id", "=", ${post.id});

  const [creator]: Creator[] = await db("users")
    .select("users.id", "users.name")
    .where("users.id", "=", ${post.creator_id});

  const newPost: PostsModel = {
    ...posts,
    creator
  };

  result.push(newPost);
}

res.status(200).send(result);
