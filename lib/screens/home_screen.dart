import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta/widgets/story_stray.dart';
import '../providers/feed_provider.dart';
import '../widgets/post_card.dart';
import '../widgets/shimmer.dart';

class HomeFeedScreen extends ConsumerStatefulWidget {
  const HomeFeedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends ConsumerState<HomeFeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 1200) {
      ref.read(feedProvider.notifier).fetchMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(feedProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        //elevation: 0,
        title: Image.asset("assets/images/logo.png",height: 120,width: 120,),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border, color: Colors.black), onPressed: () {}),
          IconButton(icon: const Icon(Icons.send, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: feedState.isLoading
          ? Column(
            children: [
              //StoryTray(),
              InstagramShimmer(),
            ],
          )
          : RefreshIndicator(
        onRefresh: () async => ref.refresh(feedProvider),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
             SliverToBoxAdapter(child: StoryTray()),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  if (index == feedState.posts.length) {
                    return feedState.isFetchingMore
                        ? const Padding(padding: EdgeInsets.all(16.0), child: Center(child: CircularProgressIndicator()))
                        : const SizedBox.shrink();
                  }
                  final post = feedState.posts[index];
                  return PostCard(post: post);
                },
                childCount: feedState.posts.length + 1,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Image.asset("assets/images/tabbar.png"),
    );
  }
}