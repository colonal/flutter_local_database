abstract class Post {
  final int postId;
  final int userId;
  final String title;
  final String body;

  const Post(
      {required this.postId,
      required this.userId,
      required this.title,
      required this.body});
}
