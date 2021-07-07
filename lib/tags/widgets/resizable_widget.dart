import 'package:flutter/material.dart';

class ResizebleWidget extends StatefulWidget {
  final double height;
  final double width;
  final bool isDraggable;
  double top;
  double left;
  final ResizableWidgetController widgetController;
  final OnResizableWidgetControllerInitialized onWidgetControllerInitialized;

  ResizebleWidget({this.child,
    this.width,
    this.height,
    this.top,
    this.left,
    this.widgetController,
    this.onWidgetControllerInitialized,
    this.isDraggable = false});

  final Widget child;

  @override
  _ResizebleWidgetState createState() => _ResizebleWidgetState();
}

const ballDiameter = 20.0;

typedef OnResizableWidgetControllerInitialized = void Function(ResizableWidgetController);

class _ResizebleWidgetState extends State<ResizebleWidget> {
  double height;
  double width;
  ResizableWidgetController _myController;

  bool isCorner = true;
  bool isDraggable;

  double top;
  double left;

  ResizableWidgetController get _controller =>
widget.widgetController?? _myController;

  @override
  void initState() {
    super.initState();
    if(widget.widgetController==null) {
      _myController??=ResizableWidgetController();
    }
    setState(() {
      height = widget.height;
      width = widget.width;
      top = widget.top;
      left = widget.left;
      isDraggable = widget.isDraggable;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller._setWidgetState(this);
      widget.onWidgetControllerInitialized?.call(_controller);

    });
  }

  @override
  Widget build(BuildContext context) {
    return
        Positioned(
          top: top,
          left: left,
          child: Container(
            // height: height,
            width: width,

            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: isCorner
                ? FittedBox(
              child: widget.child,
            )
                : Center(
              child: widget.child,
            ),
          ),
    );
  }

  void resize(double newWidth, double newHeight) {
    setState(() {
      isCorner = true;
      height = newHeight > 0 != null ? newHeight : 0;
      width = newWidth > 0 != null ? newWidth : 0;
    });
  }
}

class ResizableWidgetController {
  ResizableWidgetController();

  _ResizebleWidgetState _state;

  void _setWidgetState(_ResizebleWidgetState state){
    _state = state;
  }

  void resize(double dx, double dy){
    _state.resize(dx, dy);
  }
}

class ManipulatingBall extends StatefulWidget {
  const ManipulatingBall({this.onDrag, this.handlerWidget});

  final Function onDrag;
  final HandlerWidget handlerWidget;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

enum HandlerWidget { HORIZONTAL, VERTICAL }

class _ManipulatingBallState extends State<ManipulatingBall> {
  double initX;
  double initY;

  void _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx as double;
      initY = details.globalPosition.dy as double;
    });
  }

  void _handleUpdate(details) {
    final dx = details.globalPosition.dx - initX;
    final dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx as double;
    initY = details.globalPosition.dy as double;
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
        child: Center(
          child: Container(
            width: ballDiameter / 2,
            height: ballDiameter / 2,
            decoration: BoxDecoration(
              color: Colors.blue[300],
              shape: widget.handlerWidget == HandlerWidget.VERTICAL
                  ? BoxShape.circle
                  : BoxShape.rectangle,
            ),
          ),
        ),
      ),
    );
  }
}
