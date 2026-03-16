import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StoryTray extends StatelessWidget {
  const StoryTray({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemBuilder: (context, index) {
          final isCurrentUser = index == 0;
          final username = isCurrentUser ? 'Your Story' : (index == 1 ? 'wizflow_app' : 'user_$index');

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: isCurrentUser ? null : const LinearGradient(
                          colors: [Colors.yellow, Colors.orange, Colors.red, Colors.purple],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                        border: isCurrentUser
                            ? Border.all(color: Colors.grey.shade300, width: 1)
                            : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.5),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                'https://picsum.photos/seed/story$index/150/150',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (isCurrentUser)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.add, size: 18, color: Colors.white),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  username,
                  style: const TextStyle(fontSize: 11, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}