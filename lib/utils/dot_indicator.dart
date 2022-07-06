import 'package:flutter/material.dart';
import 'package:ownervet/utils/const_color.dart';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.currentPage,
    this.itemCount,
  }) : super(listenable: controller!);

  /// The PageController that this DotsIndicator is representing.
  final PageController? controller;

  /// The current Page managed by the PageController
  final int? currentPage;

  /// The number of items managed by the PageController
  final int? itemCount;

  // The base size of the dots
  static const double _kDotSize = 12.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    print("currentPage ${currentPage}");
    print("DotIndex ${index}");

    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: Container(
          width:currentPage==index?50: _kDotSize,
          height: _kDotSize,
          decoration: currentPage==index?BoxDecoration(
            borderRadius: BorderRadius.all( Radius.circular(15)),
            color: currentPage == index ?AppColors.selectedDotColor: Colors.grey,
            border: Border.all(color: Colors.white),
          ):BoxDecoration(
            color: currentPage == index ? Colors.green : Colors.grey,
            border: Border.all(color: Colors.white),

            borderRadius: BorderRadius.all(Radius.circular(_kDotSize / 2)),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount!, _buildDot),
    );
  }
}