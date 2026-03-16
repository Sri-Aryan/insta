
import '../models/post.dart';
import '../models/user.dart';

class PostRepository {
  Future<List<Post>> fetchPosts({required int page, int limit = 10}) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    return List.generate(limit, (index) {
      final id = (page * limit) + index;
      return Post(
        id: id.toString(),
        user: User(
          username: 'user_mock_$id',
          profileImageUrl: 'https://picsum.photos/seed/user$id/150/150',
        ),
        imageUrls: [
          'https://picsum.photos/seed/img${id}_1/1080/1080',
          'https://picsum.photos/seed/img${id}_2/1080/1080',
        ],
        likes: 120 + id,
        caption: 'Building pixel-perfect UI in Flutter! #challenge #flutter $id',
        isLiked: false,
        isSaved: false,
      );
    });
  }
}