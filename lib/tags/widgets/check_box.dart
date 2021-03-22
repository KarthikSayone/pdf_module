import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/resizable_widget.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';

import 'model/tag_data_model.dart';

class CheckBoxTag extends StatefulWidget {
  final String uuid;
  final Function selectedCallback;
  final bool value;
  final Function onCompleted;

  CheckBoxTag({@required this.selectedCallback, this.value, this.uuid, this.onCompleted});

  @override
  _CheckBoxTagState createState() => _CheckBoxTagState();
}

class _CheckBoxTagState extends State<CheckBoxTag> {
  var _selected = false;
  ResizableWidgetController widgetController;

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.value != null ? _selected = widget.value : _selected = false;
    });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if(WrapperWidget.of(context).data==null)
          WrapperWidget.of(context).data = TagDataModel();
        WrapperWidget.of(context).data.checkBox = _selected;
        widget.selectedCallback( WrapperWidget
            .of(context)
            .uuid, "CheckBox",WrapperWidget.of(context).data);
      });

  }

  @override
  Widget build(BuildContext context) {
    print("TagBuilder: CheckBox");
    return ResizebleWidget(
      width: WrapperWidget.of(context).width,
      height: WrapperWidget.of(context).height,
      top: WrapperWidget.of(context).rect.top,
      left: WrapperWidget.of(context).rect.left,
      widgetController: widgetController,
      onWidgetControllerInitialized: (ResizableWidgetController c){
        widgetController = c;
        c.resize(WrapperWidget.of(context).scaledWidth, WrapperWidget.of(context).scaledHeight);
      },
      isDraggable: false,
      child: InkWell(
        onTap: () {
          setState(() {
            _selected == false ? _selected = true : _selected = false;
          });
          if(WrapperWidget.of(context).data==null)
            WrapperWidget.of(context).data = TagDataModel();
          WrapperWidget.of(context).data.checkBox = _selected;
          widget.selectedCallback( WrapperWidget.of(context).uuid, "CheckBox", WrapperWidget.of(context).data);
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                border: Border.all(
                  color: Colors.black,
                  width: 0.3,
                )),
            width: WrapperWidget.of(context).width,
            height: WrapperWidget.of(context).height,
            child: AnimatedOpacity(
                opacity: _selected ? 1.0 : 0.0,
                duration: Duration(milliseconds: 200),
                child: Image.asset("assets/images/checkbox.png")
            )),
      ),
    );
  }
}
