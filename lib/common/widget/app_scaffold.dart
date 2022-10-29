import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget title;
  final List<Widget> slivers;
  final bool centerTitle;
  final ScrollController? controller;
  const AppScaffold({
    Key? key,
    required this.title,
    required this.slivers,
    this.centerTitle = true,
    this.controller,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        centerTitle: centerTitle,
      ),
      body: SafeArea(
        child: CustomScrollView(
          controller: controller,
          slivers: slivers,
        ),
      ),
    );
  }
}