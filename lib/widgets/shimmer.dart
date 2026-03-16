import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class InstagramShimmer extends StatelessWidget {
  const InstagramShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  children: [
                    const CircleAvatar(radius: 16, backgroundColor: Colors.white),
                    const SizedBox(width: 10),
                    Container(height: 12, width: 120, color: Colors.white),
                  ],
                ),
              ),

              AspectRatio(
                aspectRatio: 1,
                child: Container(color: Colors.white),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  children: [
                    Container(height: 24, width: 24, color: Colors.white),
                    const SizedBox(width: 16),
                    Container(height: 24, width: 24, color: Colors.white),
                    const SizedBox(width: 16),
                    Container(height: 24, width: 24, color: Colors.white),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 12, width: 80, color: Colors.white),
                    const SizedBox(height: 8),
                    Container(height: 12, width: double.infinity, color: Colors.white),
                    const SizedBox(height: 4),
                    Container(height: 12, width: 200, color: Colors.white),
                    const SizedBox(height: 24),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}