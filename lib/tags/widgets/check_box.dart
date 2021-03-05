import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

class CheckBoxTag extends StatefulWidget {
  final String uuid;
  final Function selectedCallback;
  final bool value;

  CheckBoxTag({@required this.selectedCallback, this.value, this.uuid});

  @override
  _CheckBoxTagState createState() => _CheckBoxTagState();
}

class _CheckBoxTagState extends State<CheckBoxTag> {
  var _selected = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.value != null ? _selected = widget.value : _selected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: WrapperWidget.of(context).rect.top,
      left: WrapperWidget.of(context).rect.left,
      height: WrapperWidget.of(context).height,
      width: WrapperWidget.of(context).width,
      child: InkWell(
        onTap: () {
          setState(() {
            _selected == false ? _selected = true : _selected = false;
          });

          widget.selectedCallback(_selected, WrapperWidget.of(context).uuid);
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                border: Border.all(
                  color: Colors.black,
                  width: 0.3,
                )),
            height: double.infinity,
            width: double.infinity,
            child: AnimatedOpacity(
                opacity: _selected ? 1.0 : 0.0,
                duration: Duration(milliseconds: 200),
                child: Image.asset("assets/images/checkbox.png")
            )),
      ),
    );
  }
}
