import 'package:flutter/material.dart';

class BackgroundPage extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final Function()? drawerCallBack;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool topSafeArea;
  final bool bottomSafeArea;
  final PreferredSizeWidget? appBar;

  const BackgroundPage({
    required this.child,
    this.backgroundColor,
    this.drawerCallBack,
    this.scaffoldKey,
    this.appBar,
    Key? key,
    this.topSafeArea = true,
    this.bottomSafeArea = true,
  }) : super(key: key);

  @override
  State<BackgroundPage> createState() => _BackgroundPageState();
}

class _BackgroundPageState extends State<BackgroundPage> {
  // final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      key: widget.scaffoldKey,
      backgroundColor: widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: widget.bottomSafeArea,
        top: widget.topSafeArea,
        child: widget.child,
      ),
    );
  }
}
