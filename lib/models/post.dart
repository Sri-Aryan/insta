import 'package:insta/models/user.dart';

class Post {
  final String id;
  final User user;
  final List<String> imageUrls;
  final int likes;
  final String caption;
  final bool isLiked;
  final bool isSaved;

  const Post({
    required this.id,
    required this.user,
    required this.imageUrls,
    required this.likes,
    required this.caption,
    this.isLiked = false,
    this.isSaved = false,
  });

  Post copyWith({
    String? id,
    User? user,
    List<String>? imageUrls,
    int? likes,
    String? caption,
    bool? isLiked,
    bool? isSaved,
  }) {
    return Post(
      id: id ?? this.id,
      user: user ?? this.user,
      imageUrls: imageUrls ?? this.imageUrls,
      likes: likes ?? this.likes,
      caption: caption ?? this.caption,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}