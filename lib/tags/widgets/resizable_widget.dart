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
    if(widget.widgetController==null)
      _myController??=ResizableWidgetController();
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
    return /*Stack(
      children: <Widget>[*/
        Positioned(
          top: top,
          left: left,
          child: Container(
            // height: height,
            width: width,

            decoration: BoxDecoration(
              color: Colors.transparent,
              // border: Border.all(
              //   width: 2,
              //   color: Colors.white70,
              // ),
              // borderRadius: BorderRadius.circular(0.0),
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
        /*),*/
        // top left
        /*isDraggable
            ? Positioned(
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
        )
            : Container(),
        // top middle
        isDraggable
            ? Positioned(
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
        )
            : Container(),
        // top right
        isDraggable
            ? Positioned(
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
        )
            : Container(),
        // center right
        isDraggable
            ? Positioned(
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
        )
            : Container(),
        // bottom right
        isDraggable
            ? Positioned(
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
        )
            : Container(),
        // bottom center
        isDraggable
            ? Positioned(
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
        )
            : Container(),
        // bottom left
        isDraggable
            ? Positioned(
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
        )
            : Container(),
        //left center
        isDraggable
            ? Positioned(
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
        )
            : Container(),
        // center center
        isDraggable
            ? Positioned(
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
        )
            : Container(),*/
      // ],
    );
  }

  void resize(newWidth, newHeight) {

    setState(() {
      isCorner = true;
      height = newHeight > 0 ? newHeight : 0;
      width = newWidth > 0 ? newWidth : 0;
    });
  }
}

class ResizableWidgetController {
  ResizableWidgetController();

  _ResizebleWidgetState _state;

  void _setWidgetState(_ResizebleWidgetState state){
    _state = state;
  }

  void resize(dx, dy){
    _state.resize(dx, dy);
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
        child: Center(
          child: Container(
            width: ballDiameter / 2,
            height: ballDiameter / 2,
            decoration: BoxDecoration(
              color: Colors.blue[300],
              shape: this.widget.handlerWidget == HandlerWidget.VERTICAL
                  ? BoxShape.circle
                  : BoxShape.rectangle,
            ),
          ),
        ),
      ),
    );
  }
}
