import 'package:flutter/material.dart';

class Signature extends StatefulWidget {
  final String uuid;
  final Image signature;
  final Function onTap;
  final Rect rect;
  final double width;
  final double height;

  Signature({@required this.uuid, this.signature, this.onTap, this.rect, this.width=100, this.height=60});

  @override
  _SignatureState createState() => _SignatureState();
}

class _SignatureState extends State<Signature> {
  var ind = 0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.rect.top,
      left: widget.rect.left,
      height: widget.height,
      width: widget.width,
      child: Container(
        width: widget.width,
        height: widget.height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: InkWell(
              onTap: () {
                widget.onTap();
                setState(() {
                  if (ind == 0) {
                    ind = 1;
                  } else {
                    ind = 0;
                  }
                });
              },
              child: IndexedStack(
                index: ind,
                children: [
                  Container(
                    height: widget.height,
                    width: widget.width,
                    child: Center(
                      child: Text(
                        "Sign Here",
                        style: TextStyle(
                          color: Colors.grey,
                          // fontSize: 12
                        ),
                      ),
                    ),
                    color: Color.fromRGBO(216, 243, 254, 1.0),
                  ),
                  Container(
                    color: Color.fromRGBO(220, 240, 255, 1.0),
                  ),
                ],
              ),
            )),
            Container(
              height: 8,
              width: widget.width,
              child: Text(
                "Userid to be shown here: ${widget.uuid}",
                style: TextStyle(fontSize: 4),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
