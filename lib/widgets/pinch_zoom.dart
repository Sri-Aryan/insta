import 'package:flutter/material.dart';

class InstagramPinchZoom extends StatefulWidget {
  final Widget child;

  const InstagramPinchZoom({Key? key, required this.child}) : super(key: key);

  @override
  State<InstagramPinchZoom> createState() => _InstagramPinchZoomState();
}

class _InstagramPinchZoomState extends State<InstagramPinchZoom> with SingleTickerProviderStateMixin {
  late TransformationController _transformationController;
  late AnimationController _animationController;
  Animation<Matrix4>? _animation;
  OverlayEntry? _overlayEntry;

  bool _isZooming = false;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
      _transformationController.value = _animation!.value;
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _showOverlay(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offset.dx,
          top: offset.dy,
          width: size.width,
          height: size.height,
          child: IgnorePointer(
            child: InteractiveViewer(
              transformationController: _transformationController,
              panEnabled: false,
              clipBehavior: Clip.none,
              child: widget.child,
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _resetAnimation() {
    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward(from: 0).whenComplete(() {
      _removeOverlay();
      setState(() {
        _isZooming = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          return GestureDetector(
            onScaleStart: (details) {
              if (_isZooming) return;
              setState(() {
                _isZooming = true;
              });
              _showOverlay(context);
            },
            onScaleUpdate: (details) {
              if (!_isZooming) return;

              final renderBox = context.findRenderObject() as RenderBox;
              final offset = renderBox.localToGlobal(Offset.zero);
              final focalPoint = details.focalPoint - offset;

              final matrix = Matrix4.identity()
                ..translate(focalPoint.dx, focalPoint.dy)
                ..scale(details.scale)
                ..translate(-focalPoint.dx, -focalPoint.dy);

              _transformationController.value = matrix;
            },
            onScaleEnd: (details) {
              if (!_isZooming) return;
              _resetAnimation();
            },
            child: Opacity(
              opacity: _isZooming ? 0.0 : 1.0,
              child: widget.child,
            ),
          );
        }
    );
  }
}