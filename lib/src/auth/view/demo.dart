import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';

class Demo extends StatefulWidget {
  static String route = "/demo";

  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> with TickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            CustomPaint(
              painter: LiquidPainter(
                progress: _progressAnimation.value,
              ),
              child: Container(),
            ),
          ],
        );
      },
    );
  }


  // late final AnimationController parkController = AnimationController(
  //   duration: const Duration(seconds: 3),
  //   vsync: this,
  // );
  //
  // late final AnimationController logoController = AnimationController(
  //   duration: const Duration(seconds: 2),
  //   vsync: this,
  // );
  //
  // late final Animation<Offset> parkAnimation = Tween<Offset>(
  //   begin: const Offset(0, 0),
  //   end: const Offset(3, 0),
  // ).animate(CurvedAnimation(
  //   parent: parkController,
  //   curve: Curves.elasticIn,
  // ));
  // late final Animation<Offset> logoAnimation = Tween<Offset>(
  //   begin: Offset.zero,
  //   end: const Offset(0, -1),
  // ).animate(CurvedAnimation(
  //   parent: logoController,
  //   curve: Curves.easeOut,
  // ));
  //
  // @override
  // void initState() {
  //   super.initState();
  //   init();
  // }
  //
  // void init() {
  //   Future.delayed(const Duration(milliseconds: 900), () {
  //     setState(() {
  //       logoController.forward().whenComplete(() {
  //         parkController.repeat();
  //       });
  //     });
  //   });
  // }
  //
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: R.colors.white,
  //     body: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.max,
  //       children: [
  //         Stack(
  //           children: [
  //             Center(child: Image.asset(R.images.logo,scale: 3.5,)),
  //             Center(
  //               child: SlideTransition(
  //                 position: logoAnimation,
  //                 child: Container(height: 13.h, width: 41.w, color: R.colors.white),
  //               ),
  //             ),
  //
  //           ],
  //         ),
  //
  //         SlideTransition(
  //             position: parkAnimation,
  //             child: Image.asset(R.images.s,scale: 4,)),
  //       ],
  //     ),
  //   );
  // }
  // late AnimationController _controller;
  // late Animation<Color?> _animation;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   _controller = AnimationController(
  //     duration: const Duration(seconds: 2),
  //     vsync: this,
  //   );
  //
  //   _animation = ColorTween(
  //     begin: Colors.white,
  //     end: Colors.deepOrangeAccent,
  //   ).animate(_controller);
  //
  //   _controller.forward();
  // }
  //
  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return AnimatedBuilder(
  //     animation: _controller,
  //     builder: (context, child) {
  //       return Scaffold(
  //         backgroundColor: _animation.value,
  //         body: Center(
  //           child: FlutterLogo(size: 100.0),
  //         ),
  //       );
  //     },
  //   );
  // }
}

class LiquidPainter extends CustomPainter {
  final double progress;

  LiquidPainter({
    required this.progress,

  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;


    final path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(size.width*(50+progress), size.height * (1 - progress));
    path.quadraticBezierTo(size.width * (1 - progress * 20), size.height * (1 - progress * 5), 0, size.height * (1.5 - progress));
    path.lineTo(0.0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }


  @override
  bool shouldRepaint(LiquidPainter oldDelegate) => oldDelegate.progress != progress;
}