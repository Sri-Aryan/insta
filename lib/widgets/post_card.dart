import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/post.dart';
import '../providers/feed_provider.dart';

class PostCard extends ConsumerStatefulWidget {
  final Post post;
  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  ConsumerState<PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  final PageController _pageController = PageController();

  void _showUnimplementedSnackbar(String action) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action functionality coming soon!'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(widget.post.user.profileImageUrl),
                radius: 16,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(widget.post.user.username, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => _showUnimplementedSnackbar('Options'),
              )
            ],
          ),
        ),

        GestureDetector(
          onDoubleTap: () => ref.read(feedProvider.notifier).toggleLike(widget.post.id),
          child: AspectRatio(
            aspectRatio: 1,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.post.imageUrls.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: widget.post.imageUrls[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error, color: Colors.grey)),
                );
              },
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => ref.read(feedProvider.notifier).toggleLike(widget.post.id),
                child: Icon(
                  widget.post.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: widget.post.isLiked ? Colors.red : Colors.black,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () => _showUnimplementedSnackbar('Comments'),
                child: const Icon(Icons.chat_bubble_outline, size: 26),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () => _showUnimplementedSnackbar('Comments'),
                child: const Icon(Icons.refresh, size: 26),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () => _showUnimplementedSnackbar('Share'),
                child: const Icon(Icons.send_outlined, size: 26),
              ),

              const Spacer(),

              if (widget.post.imageUrls.length > 1)
                SmoothPageIndicator(
                  controller: _pageController,
                  count: widget.post.imageUrls.length,
                  effect: const ScrollingDotsEffect(
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                    dotHeight: 6,
                    dotWidth: 6,
                  ),
                ),

              const Spacer(),

              GestureDetector(
                onTap: () => ref.read(feedProvider.notifier).toggleSave(widget.post.id),
                child: Icon(
                  widget.post.isSaved ? Icons.bookmark : Icons.bookmark_border,
                  size: 28,
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.post.likes} likes', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: '${widget.post.user.username} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: widget.post.caption),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        )
      ],
    );
  }
}