const String dbName = "posts.db";

const String sqlCreateTable =
    "CREATE TABLE post(id INTEGER PRIMARY KEY, postId INTEGER, userId INTEGER, title TEXT, body TEXT);";

const String sqlInsert =
    "INSERT INTO post(postId, userId, title,body) VALUES(?, ?, ?, ?)";

const String sqlGetData = "SELECT * FROM post";

const String sqlDeleteData = "DELETE FROM post WHERE postId = ?";

const String sqlUpdateData =
    "UPDATE post SET title = ?, body = ? WHERE postId = ?";

const String sqlDeleteAllData = "DELETE FROM post";
