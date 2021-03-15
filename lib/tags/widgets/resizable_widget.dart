import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class ResizableWidget extends StatefulWidget {
  ResizableWidget({this.child});

  final Widget child;
  @override
  _ResizableWidgetState createState() => _ResizableWidgetState();
}

const ballDiameter = 10.0;

class _ResizableWidgetState extends State<ResizableWidget> {
  double height;
  double width;
  bool isCorner = false;

  double top = 0;
  double left = 0;

  @override
  Widget build(BuildContext context) {
    height = WrapperWidget.of(context).height;
    width = WrapperWidget.of(context).width;
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: Container(
            height: height,
            width: width,

            decoration: BoxDecoration(
              color: Colors.blueGrey,
              border: Border.all(
                width: 2,
                color: Colors.white70,
              ),
              borderRadius: BorderRadius.circular(0.0),
            ),

            // need tp check if draggable is done from corner or sides
            child: isCorner
                ? FittedBox(
              child: widget.child,
            )
                : Center(
              child: widget.child,
            ),
          ),
        ),
        // top left
        Positioned(
          top: top - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;
              var newHeight = height - 2 * mid;
              var newWidth = width - 2 * mid;

              setState(() {
                isCorner = true;
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top + mid;
                left = left + mid;
              });
            },
            handlerWidget: HandlerWidget.VERTICAL,
          ),
        ),
        // top middle
        Positioned(
          top: top - ballDiameter / 2,
          left: left + width / 2 - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var newHeight = height - dy;

              setState(() {
                isCorner = false;

                height = newHeight > 0 ? newHeight : 0;
                top = top + dy;
              });
            },
            handlerWidget: HandlerWidget.HORIZONTAL,
          ),
        ),
        // top right
        Positioned(
          top: top - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = (dx + (dy * -1)) / 2;

              var newHeight = height + 2 * mid;
              var newWidth = width + 2 * mid;

              setState(() {
                isCorner = true;
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top - mid;
                left = left - mid;
              });
            },
            handlerWidget: HandlerWidget.VERTICAL,
          ),
        ),
        // center right
        Positioned(
          top: top + height / 2 - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var newWidth = width + dx;

              setState(() {
                isCorner = false;

                width = newWidth > 0 ? newWidth : 0;
              });
            },
            handlerWidget: HandlerWidget.HORIZONTAL,
          ),
        ),
        // bottom right
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;

              var newHeight = height + 2 * mid;
              var newWidth = width + 2 * mid;

              setState(() {
                isCorner = true;

                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top - mid;
                left = left - mid;
              });
            },
            handlerWidget: HandlerWidget.VERTICAL,
          ),
        ),
        // bottom center
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left + width / 2 - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var newHeight = height + dy;

              setState(() {
                isCorner = false;

                height = newHeight > 0 ? newHeight : 0;
              });
            },
            handlerWidget: HandlerWidget.HORIZONTAL,
          ),
        ),
        // bottom left
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var mid = ((dx * -1) + dy) / 2;

              var newHeight = height + 2 * mid;
              var newWidth = width + 2 * mid;

              setState(() {
                isCorner = true;

                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top - mid;
                left = left - mid;
              });
            },
            handlerWidget: HandlerWidget.VERTICAL,
          ),
        ),
        //left center
        Positioned(
          top: top + height / 2 - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var newWidth = width - dx;

              setState(() {
                isCorner = false;

                width = newWidth > 0 ? newWidth : 0;
                left = left + dx;
              });
            },
            handlerWidget: HandlerWidget.HORIZONTAL,
          ),
        ),
        // center center
        Positioned(
          top: top + height / 2 - ballDiameter / 2,
          left: left + width / 2 - ballDiameter / 2,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              setState(() {
                isCorner = false;

                top = top + dy;
                left = left + dx;
              });
            },
            handlerWidget: HandlerWidget.VERTICAL,
          ),
        ),
      ],
    );
  }
}

class ManipulatingBall extends StatefulWidget {
  ManipulatingBall({Key key, this.onDrag, this.handlerWidget});

  final Function onDrag;
  final HandlerWidget handlerWidget;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

enum HandlerWidget { HORIZONTAL, VERTICAL }

class _ManipulatingBallState extends State<ManipulatingBall> {
  double initX;
  double initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(
        width: ballDiameter,
        height: ballDiameter,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: this.widget.handlerWidget == HandlerWidget.VERTICAL
              ? BoxShape.circle
              : BoxShape.rectangle,
        ),
      ),
    );
  }
}