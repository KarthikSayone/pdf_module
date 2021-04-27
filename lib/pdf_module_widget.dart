import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf_module/tags/widgets/editable_placeholder.dart';
import 'package:pdf_module/tags/widgets/model/tag_data_model.dart';
import 'package:pdf_module/tags/widgets/wrapper_widget.dart';
import 'package:vector_math/vector_math_64.dart' as math64;
import 'pdf_module.dart';
import 'tags/tag_model.dart';
import 'tags/tag_handler.dart';

/// Function definition to generate the actual widget that contains rendered PDF page image.
/// [size] should be the page widget size but it can be null if you don't want to calculate it.
/// Unlike the function name, it may generate widget other than [Texture].
/// If [returnNullForError] is true, the function returns null if rendering failure; otherwise,
/// the function generates a placeholder [Container] for the unavailable page image.
/// Anyway, please note that the size is in screen coordinates; not the actual pixel size of
/// the image. In other words, the function correctly deals with the screen pixel density automatically.
/// [backgroundFill] specifies whether to fill background before rendering actual page content or not.
/// The page content may not have background fill and if the flag is false, it may be rendered with transparent background.
/// [renderingPixelRatio] specifies pixel density for rendering page image. If it is null, the value is obtained by calling `MediaQuery.of(context).devicePixelRatio`.
/// Although, the view uses Flutter's [Texture] to render the PDF content by default, you can disable it by setting [dontUseTexture] to true.
/// Please note that on iOS Simulator, it always use non-[Texture] rendering pass.
typedef PdfPageTextureBuilder = Widget Function(
    {Size size,
    bool returnNullForError,
    PdfPagePlaceholderBuilder placeholderBuilder,
    bool backgroundFill,
    double renderingPixelRatio,
    bool dontUseTexture,
    bool allowAntialiasingIOS});

/// Creates page placeholder that is shown on page loading or even page load failure.
typedef PdfPagePlaceholderBuilder = Widget Function(
    Size size, PdfPageStatus status);

/// Page loading status.
enum PdfPageStatus {
  /// The page is currently being loaded.
  loading,

  /// The page load failed.
  loadFailed,
}

typedef LayoutPagesFunc = List<Rect> Function(
    Size contentViewSize, List<Size> pageSizes);
typedef BuildPageContentFunc = Widget Function(
    BuildContext context, int pageNumber, Rect pageRect);
typedef RetrieveDataFunc<T> = void Function(T data, String uuid);
typedef TagCompletedFunc = void Function(
    String uuid, String type, TagDataModel data);

/// Controller for [PdfViewer].
/// It is derived from [TransformationController] and basically compatible to [ValueNotifier<Matrix4>].
/// So you can pass it to [ValueListenableBuilder<Matrix4>] or such to receive any view status changes.
class PdfViewerController extends TransformationController {
  PdfViewerController();

  /// Associated [_PdfViewerState].
  /// FIXME: I don't think this is a good structure for our purpose...
  _PdfViewerState _state;

  /// Associate a [_PdfViewerState] to the controller.
  void _setViewerState(_PdfViewerState state) {
    _state = state;
    this.notifyListeners();
  }

  /// Whether the controller is ready or not.
  bool get isReady => _state != null;

  /// Get total page count in the PDF document.
  int get pageCount => _state?._pages?.length;

  /// Get page location.
  Rect getPageRect(int pageNumber) => _state == null
      ? null
      : _state._pages
          .firstWhere((p) => p.pageNumber == pageNumber, orElse: null)
          ?.rect;

  /// Calculate the matrix that corresponding to the page position.
  /// [defValue] is the default value for invalid page number case.
  /// Sometimes it's difficult to know whether the page number is valid for
  /// the document before actually opening the document, especially
  /// when you're handling a thing like a web URL with `#page=NNN` fragment
  /// and such a default value is very useful in such case.
  Matrix4 calculatePageFitMatrix(
      {@required int pageNumber, double padding, Matrix4 defValue}) {
    if (pageNumber == null || pageNumber < 1 || pageNumber > pageCount) {
      return defValue ?? Matrix4.identity();
    }
    final rect = getPageRect(pageNumber)?.inflate(padding ?? _state._padding);
    if (rect == null) return null;
    final scale = _state._lastViewSize.width / rect.width;
    final left = max(0.0,
        min(rect.left, _state._docSize.width - _state._lastViewSize.width));
    final top = max(0.0,
        min(rect.top, _state._docSize.height - _state._lastViewSize.height));
    return Matrix4.compose(math64.Vector3(-left, -top, 0),
        math64.Quaternion.identity(), math64.Vector3(scale, scale, 1));
  }

  /// Go to the destination specified by the matrix.
  /// To go to a specific page, use [goToPage] method or use [calculatePageFitMatrix] method to calculate the page location matrix.
  Future<void> goTo(
          {Matrix4 destination,
          Duration duration = const Duration(milliseconds: 200)}) =>
      _state._goTo(destination: destination, duration: duration);

  Future<void> goToPage(
          {@required int pageNumber,
          double padding,
          Duration duration = const Duration(milliseconds: 500)}) =>
      goTo(
          destination:
              calculatePageFitMatrix(pageNumber: pageNumber, padding: padding),
          duration: duration);

  Future<void> nextTag() {
    if (_state.currentTag < _state.widget.tagList.length) {
      goTo(
          destination: calculateTagFitMatrix(tagNumber: _state.currentTag + 1),
          duration: Duration(milliseconds: 500));
      _state.currentTag++;
    }
  }

  Matrix4 calculateTagFitMatrix(
      {@required int tagNumber, double padding, Matrix4 defValue}) {
    if (tagNumber == null ||
        tagNumber < 0 ||
        tagNumber > _state.widget.tagList.length) {
      return defValue ?? Matrix4.identity();
    }
    final pageRect = getPageRect(_state.widget.tagList
        .elementAt(tagNumber).pageNumber);
    final rect = _state.widget.tagList
        .elementAt(tagNumber)
        .rect
        ?.inflate(padding ?? _state._padding);
    if (rect == null) return null;
    final scale = _state._lastViewSize.width / rect.width;
    final left = max(0.0, rect.left + _state._padding);
    final top = max(0.0, pageRect.top + rect.top + _state._padding);
    return Matrix4.compose(math64.Vector3(-left * scale, -top * scale, 0),
        math64.Quaternion.identity(), math64.Vector3(scale, scale, 1));
  }

  //ToDo
  addTags(TagModel value) {
    _state.addTags(value);
  }

  addDataToTags(String uuid, String type, dynamic data) {
    _state.addDataToTags(uuid, type, data);
  }

  showTags(bool show) {
    _state.showTags(show);
  }

  Future<void> previousTag() {
    if (_state.currentTag > 0) {
      goTo(
          destination: calculateTagFitMatrix(tagNumber: _state.currentTag - 1),
          duration: Duration(milliseconds: 500));
      _state.currentTag--;
    }
  }

  /// Current view rectangle.
  Rect get viewRect => _state == null
      ? null
      : Rect.fromLTWH(-value.row0[3], -value.row1[3],
          _state._lastViewSize.width, _state._lastViewSize.height);

  /// Current view zoom ratio.
  double get zoomRatio => _state == null ? null : value.row0[0];

  /// Get list of the page numbers of the pages visible inside the viewport.
  /// The map keys are the page numbers. And each page number is associated to the page area (width x height) exposed to the viewport;
  Map<int, double> get visiblePages => _state?._visiblePages;

  /// Get the current page number by obtaining the page that has the largest area from [visiblePages].
  /// If no pages are visible, it returns 1.
  int get currentPageNumber {
    if (visiblePages == null) return null;
    MapEntry<int, double> max;
    for (final v in visiblePages.entries) {
      if (max == null || max.value < v.value) {
        max = v;
      }
    }
    return max?.key;
  }
}

typedef OnPdfViewerControllerInitialized = void Function(PdfViewerController);

/// A PDF viewer implementation with user interactive zooming support.
class PdfViewer extends StatefulWidget {
  // only one of [filePath], [assetName], [data], or [doc] have to be specified.
  final String filePath;
  final String assetName;
  final Uint8List data;
  final PdfDocument doc;

  /// Page number to show on the first time.
  final int pageNumber;

  /// Padding for the every page.
  final double padding;

  /// Custom page layout logic if you need it.
  final LayoutPagesFunc layoutPages;

  /// Custom page placeholder that is shown until the page is fully loaded.
  final BuildPageContentFunc buildPagePlaceholder;

  /// Custom overlay that is shown on page.
  /// For example, drawings, annotations on pages.
  final BuildPageContentFunc buildPageOverlay;

  final RetrieveDataFunc retrieveData;

  final TagCompletedFunc onTagCompleted;

  List<TagModel> tagList;

  /// Custom page decoration such as drop-shadow.
  final BoxDecoration pageDecoration;

  /// See [InteractiveViewer] for more info.
  final bool alignPanAxis;

  /// See [InteractiveViewer] for more info.
  final EdgeInsets boundaryMargin;

  /// See [InteractiveViewer] for more info.
  final bool panEnabled;

  /// See [InteractiveViewer] for more info.
  final bool scaleEnabled;

  /// See [InteractiveViewer] for more info.
  final double maxScale;

  /// See [InteractiveViewer] for more info.
  final double minScale;

  /// Whether to allow use of antialiasing on iOS Quartz PDF rendering.
  final bool allowAntialiasingIOS;

  /// See [InteractiveViewer] for more info.
  final GestureScaleEndCallback onInteractionEnd;

  /// See [InteractiveViewer] for more info.
  final GestureScaleStartCallback onInteractionStart;

  /// See [InteractiveViewer] for more info.
  final GestureScaleUpdateCallback onInteractionUpdate;

  /// Controller for the viewer. If none is specified, the viewer initializes one internally.
  final PdfViewerController viewerController;

  final GestureLongPressEndCallback onLongPressDone;

  /// Callback that is called on viewer initialization to notify the actual [PdfViewerController] used by the viewer regardless of specifying [viewerController].
  final OnPdfViewerControllerInitialized onViewerControllerInitialized;

  final Function onError;

  // final GestureLongPressStartCallback? onLongPressCallback;

  PdfViewer(
      {Key key,
      this.filePath,
      this.assetName,
      this.data,
      this.doc,
      this.pageNumber,
      this.padding,
      this.layoutPages,
      this.buildPagePlaceholder,
      this.buildPageOverlay,
      this.tagList,
      this.pageDecoration,
      this.alignPanAxis = false,
      this.allowAntialiasingIOS = true,
      this.boundaryMargin = EdgeInsets.zero,
      this.maxScale = 20,
      this.minScale = 0.1,
      this.onInteractionEnd,
      this.onInteractionStart,
      this.onInteractionUpdate,
      this.panEnabled = true,
      this.scaleEnabled = true,
      this.viewerController,
      this.onLongPressDone,
      this.onViewerControllerInitialized,
      this.retrieveData,
      this.onTagCompleted,
      this.onError})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer>
    with SingleTickerProviderStateMixin {
  PdfDocument _doc;
  List<_PdfPageState> _pages;
  PdfViewerController _myController;
  Size _lastViewSize;
  Timer _realSizeUpdateTimer;
  Size _docSize;
  Map<int, double> _visiblePages = Map<int, double>();
  List<BuildPageContentFunc> listWidgetBuilder = List<BuildPageContentFunc>();
  List<WrapperWidget> listWidget = List<WrapperWidget>();
  int currentTag = -1;
  AnimationController _animController;
  Animation<Matrix4> _animGoTo;

  bool _firstControllerAttach = true;
  bool _forceUpdatePagePreviews = true;
  bool _showTags = false;

  Size viewSize;

  PdfViewerController get _controller =>
      widget.viewerController ?? _myController;

  @override
  void initState() {
    super.initState();
    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    init();
  }

  addTags(TagModel value) {
    if (widget.tagList == null) {
      widget.tagList = new List<TagModel>();
    }
    widget.tagList.add(value);
    setState(() {});
  }

  addDataToTags(String uuid, String type, dynamic data) {
    /*listWidget.forEach((element) { if(element.uuid ==uuid){
    element.data = data;
    }
    });*/
    print('Data: $data');
    widget.tagList.forEach((element) {
      if (element.uuid == uuid) {
        if (element.data == null) element.data = TagDataModel();
        switch (type) {
          case "SignerName":
            {
              element.data.signerName = data;
            }
            break;
          case "SignHere":
            {
              element.data.signature = data;
            }
            break;
          case "SignerTitle":
            {
              element.data.signerTitle = data;
            }
            break;
          case "Initials":
            {
              element.data.initials = data;
              element.data.signature = data;
            }
            break;
          case "Attachment":
            {
              List<String> data1 = data as List;
              element.data.attachmentFileName = data1[0];
              element.data.attachmentData = data1[1];
              // getFiles(uuid, type);
            }
            break;
          case "SignedAttachment":
            {
              // getFiles(uuid, type);
            }
            break;
          case "Image":
            {
              element.data.image = data;
            }
            break;
          case "UserUUID":
            {
              element.data.userUUID = data;
            }
            break;
          case "Reason":
            {
              element.data.reasonList = data;
            }
            break;
        }
      }
    });
    setState(() {});
  }

  showTags(bool show) {
    _showTags = show;
    setState(() {});
  }

  @override
  void didUpdateWidget(PdfViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_widgetDocsEqual(oldWidget)) {
      init();
    } else if (oldWidget.pageNumber != widget.pageNumber) {
      widget.onViewerControllerInitialized?.call(_controller);
      final m =
          _controller.calculatePageFitMatrix(pageNumber: widget.pageNumber);
      if (m != null) {
        _controller.value = m;
      }
    } else if ((oldWidget.tagList == null && widget.tagList != null) ||
        (widget.tagList != null &&
            oldWidget.tagList.length != widget.tagList.length)) {
      //todo update tag state
      print('UpdateWidget');
      _updateTagWidget(viewSize);
    }
  }

  bool _widgetDocsEqual(PdfViewer oldWidget) {
    if (oldWidget.filePath != null && oldWidget.filePath == widget.filePath)
      return true;
    if (oldWidget.assetName != null && oldWidget.assetName == widget.assetName)
      return true;
    if (oldWidget.data != null && oldWidget.data == widget.data) return true;
    if (oldWidget.doc != null && oldWidget.doc == widget.doc) return true;
    return false;
  }

  void init() {
    _controller?.removeListener(_determinePagesToShow);
    _controller?._setViewerState(null);
    if (widget.viewerController == null) {
      _myController ??= PdfViewerController();
    }
    load();
  }

  @override
  void dispose() {
    _cancelLastRealSizeUpdate();
    _releasePages();
    _controller?.removeListener(_determinePagesToShow);
    _controller?._setViewerState(null);
    _myController?.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> load() async {
    _releasePages();
    try{
    if (widget.filePath != null) {
      _doc = await PdfDocument.openFile(widget.filePath);
    } else if (widget.assetName != null) {
      _doc = await PdfDocument.openAsset(widget.assetName);
    } else if (widget.data != null) {
      _doc = await PdfDocument.openData(widget.data);
    } else {
      _doc = widget.doc;
    }}
    catch(e){
      widget.onError();
    }

    if (_doc != null) {
      final pages = List<_PdfPageState>();
      final firstPage = await _doc.getPage(1);
      final pageSize1 = Size(firstPage.width, firstPage.height);
      for (int i = 0; i < _doc.pageCount; i++) {
        pages.add(_PdfPageState._(pageNumber: i + 1, pageSize: pageSize1));
      }
      _firstControllerAttach = true;
      _pages = pages;
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _releasePages() {
    if (_pages == null) return;
    for (final p in _pages) {
      p.dispose();
    }
    _pages = null;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        viewSize = Size(constraints.maxWidth, constraints.maxHeight);
        _relayout(viewSize);
        final docSize = _docSize ?? Size(10, 10); // dummy size
        return InteractiveViewer(
            transformationController: widget.viewerController ?? _controller,
            constrained: false,
            alignPanAxis: widget.alignPanAxis,
            boundaryMargin: widget.boundaryMargin,
            minScale: widget.minScale,
            maxScale: widget.maxScale,
            onInteractionEnd: widget.onInteractionEnd,
            onInteractionStart: widget.onInteractionStart,
            onInteractionUpdate: widget.onInteractionUpdate,
            panEnabled: widget.panEnabled,
            scaleEnabled: widget.scaleEnabled,
            child: Stack(
              children: <Widget>[
                SizedBox(width: docSize.width, height: docSize.height),
                ...iterateLaidOutPages(viewSize)
              ],
            ));
      },
    );
  }

  double get _padding => widget.padding ?? 8.0;

  void _relayout(Size viewSize) {
    if (_pages == null) {
      return;
    }
    if (widget.layoutPages == null) {
      _relayoutDefault(viewSize);
    } else {
      final contentSize =
          Size(viewSize.width - _padding * 2, viewSize.height - _padding * 2);
      final rects = widget.layoutPages(
          contentSize, _pages.map((p) => p.pageSize).toList());
      var allRect = Rect.fromLTWH(0, 0, viewSize.width, viewSize.height);
      for (int i = 0; i < _pages.length; i++) {
        final rect = rects[i].translate(_padding, _padding);
        _pages[i].rect = rect;
        allRect = allRect.expandToInclude(rect.inflate(_padding));
      }
      _docSize = allRect.size;
    }
    _lastViewSize = viewSize;

    if (_firstControllerAttach) {
      _firstControllerAttach = false;

      Future.delayed(Duration.zero, () {
        // NOTE: controller should be associated after first layout calculation finished.
        _controller.addListener(_determinePagesToShow);
        _controller._setViewerState(this);
        widget.onViewerControllerInitialized?.call(_controller);

        if (mounted) {
          if (widget.pageNumber != null) {
            _controller.value = _controller.calculatePageFitMatrix(
                pageNumber: widget.pageNumber);
          }
          _forceUpdatePagePreviews = true;
          _determinePagesToShow();
        }
      });
      return;
    }

    _determinePagesToShow();
  }

  /// Default page layout logic that layouts pages vertically.
  void _relayoutDefault(Size viewSize) {
    final maxWidth = _pages.fold<double>(
        0.0, (maxWidth, page) => max(maxWidth, page.pageSize.width));
    final ratio = (viewSize.width - _padding * 2) / maxWidth;
    var top = _padding;
    for (int i = 0; i < _pages.length; i++) {
      final page = _pages[i];
      final w = page.pageSize.width * ratio;
      final h = page.pageSize.height * ratio;
      page.rect = Rect.fromLTWH(_padding, top, w, h);
      top += h + _padding;
    }
    _docSize = Size(viewSize.width, top);
  }

  Rect getPos(double _padding, double x, double y, double width, double height,
      int pageNumber, Size viewSize) {
    var page = _pages[pageNumber - 1];
    final maxWidth = _pages.fold<double>(
        0.0, (maxWidth, page) => max(maxWidth, page.pageSize.width));
    final ratio = (viewSize.width - _padding * 2) / maxWidth;
    double l = (x) * ratio;
    double t = (y) * ratio;
    double w = (width) * ratio;
    double h = (height) * ratio;
    print("l: $l");
    print("t: $t");
    print("w: $w");
    print("h: $h");
    var rect = Rect.fromLTWH(l, t, w, h);
    return rect;
  }

  void _updateTagWidget(Size viewSize) {
    //ToDo Add logic to add corresponding widgets
    listWidgetBuilder.clear();
    listWidget.clear();
    if (widget.tagList != null && widget.tagList.length > 0) {
      for (int i = 0; i < widget.tagList.length; i++) {
        final tag = widget.tagList[i];
        listWidgetBuilder.add((context, pageNumber, pageRect) {
          var rect = getPos(_padding, tag.tagCoordinateX, tag.tagCoordinateY,
              tag.width, tag.height, pageNumber, viewSize);
          print("Hello $i");
          widget.tagList[i].rect = rect;
          /*var rect =
              Rect.fromLTWH(tag.tagCoordinateX, tag.tagCoordinateY, 100, 100);*/
          if (pageNumber == tag.pageNumber)
            return TagHandler().createTag(
                tag.uuid,
                tag.tagId,
                tag.key,
                tag.pageNumber,
                rect,
                tag.width,
                tag.height,
                rect.width,
                rect.height,
                tag.data, (uuid, type) {
              //onTap Function Callback
              widget.retrieveData(type, uuid);
            }, (uuid, type, T) {
              // onCompleted Function Callback
              if (T != null) {
                print('T: $T');
              }
              print("$uuid");
              WidgetsBinding.instance.addPostFrameCallback((_) {
                widget.onTagCompleted(uuid, type, T);
              });
            });
          else
            return null;
        });
      }
    }
  }

  Iterable<Widget> iterateLaidOutPages(Size viewSize) sync* {
    if (!_firstControllerAttach && _pages != null) {
      final m = _controller.value;
      final r = m.row0[0];
      final exposed =
          Rect.fromLTWH(-m.row0[3], -m.row1[3], viewSize.width, viewSize.height)
              .inflate(_padding);

      _updateTagWidget(viewSize);

      for (final page in _pages) {
        if (page.rect == null) continue;

        final pageRectZoomed = Rect.fromLTRB(page.rect.left * r,
            page.rect.top * r, page.rect.right * r, page.rect.bottom * r);
        final part = pageRectZoomed.intersect(exposed);
        page.isVisibleInsideView = !part.isEmpty;

        if (!page.isVisibleInsideView) continue;

        if (listWidgetBuilder != null || listWidgetBuilder.length > 0) {
          for (final tag in listWidgetBuilder)
            if (tag(context, page.pageNumber, page.rect) != null) {
              listWidget.add(tag(context, page.pageNumber, page.rect));
            }
        }
        yield Positioned(
          left: page.rect.left,
          top: page.rect.top,
          width: page.rect.width,
          height: page.rect.height,
          child: Container(
            width: page.rect.width,
            height: page.rect.height,
            child: GestureDetector(
              onLongPressEnd: widget.onLongPressDone,
              child: Stack(children: [
                ValueListenableBuilder<int>(
                    valueListenable: page._previewNotifier,
                    builder: (context, value, child) => page.preview != null
                        ? Texture(textureId: page.preview.texId)
                        : widget.buildPagePlaceholder != null
                            ? widget.buildPagePlaceholder(
                                context, page.pageNumber, page.rect)
                            : Container()),
                ValueListenableBuilder<int>(
                    valueListenable: page._realSizeNotifier,
                    builder: (context, value, child) =>
                        page.realSizeOverlayRect != null &&
                                page.realSize != null
                            ? Positioned(
                                left: page.realSizeOverlayRect.left,
                                top: page.realSizeOverlayRect.top,
                                width: page.realSizeOverlayRect.width,
                                height: page.realSizeOverlayRect.height,
                                child: Texture(textureId: page.realSize.texId))
                            : Container()),
                /*if (listWidgetBuilder != null &&
                    listWidgetBuilder.length > 0 &&
                    _showTags)
                  for (final tag in listWidgetBuilder)
                    if (tag(context, page.pageNumber, page.rect) != null)
                      tag(context, page.pageNumber, page.rect),*/

                if (listWidget != null && listWidget.length > 0 && _showTags)
                  for (final tag in listWidget)
                    if (tag.pageNumber == page.pageNumber) tag,
              ]),
            ),
            decoration: widget.pageDecoration ??
                BoxDecoration(
                    color: Color.fromARGB(255, 250, 250, 250),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black45,
                          blurRadius: 4,
                          offset: Offset(2, 2))
                    ]),
          ),
        );
      }
    }
  }

  /// Not to purge loaded page previews if they're "near" from the current exposed view
  static final _extraBufferAroundView = 400.0;

  void _determinePagesToShow() {
    if (_lastViewSize == null) return;
    final m = _controller.value;
    final r = m.row0[0];
    final exposed = Rect.fromLTWH(
        -m.row0[3], -m.row1[3], _lastViewSize.width, _lastViewSize.height);
    var pagesToUpdate = 0;
    var changeCount = 0;
    _visiblePages.clear();
    for (final page in _pages) {
      if (page.rect == null) {
        page.isVisibleInsideView = false;
        continue;
      }
      final pageRectZoomed = Rect.fromLTRB(page.rect.left * r,
          page.rect.top * r, page.rect.right * r, page.rect.bottom * r);
      final part = pageRectZoomed.intersect(exposed);
      final isVisible = !part.isEmpty;
      if (isVisible) {
        _visiblePages[page.pageNumber] = part.width * part.height;
      }
      if (page.isVisibleInsideView != isVisible) {
        page.isVisibleInsideView = isVisible;
        changeCount++;
        if (isVisible) {
          pagesToUpdate++; // the page gets inside the view
        }
      }
    }

    _cancelLastRealSizeUpdate();

    if (changeCount > 0) {
      _needRelayout();
    }
    if (pagesToUpdate > 0 || _forceUpdatePagePreviews) {
      _needPagePreviewGenerateion();
    } else {
      _needRealSizeOverlayUpdate();
    }
  }

  void _needRelayout() {
    Future.delayed(Duration.zero, () => setState(() {}));
  }

  void _needPagePreviewGenerateion() {
    Future.delayed(Duration.zero, () => _updatePageState());
  }

  Future<void> _updatePageState() async {
    _forceUpdatePagePreviews = false;
    for (final page in _pages) {
      if (page.rect == null) continue;
      final m = _controller.value;
      final r = m.row0[0];
      final exposed = Rect.fromLTWH(
              -m.row0[3], -m.row1[3], _lastViewSize.width, _lastViewSize.height)
          .inflate(_extraBufferAroundView);

      final pageRectZoomed = Rect.fromLTRB(page.rect.left * r,
          page.rect.top * r, page.rect.right * r, page.rect.bottom * r);
      final part = pageRectZoomed.intersect(exposed);
      if (part.isEmpty) continue;

      if (page.status == _PdfPageLoadingStatus.notInited) {
        page.status = _PdfPageLoadingStatus.initializing;
        page.pdfPage = await _doc.getPage(page.pageNumber);
        final prevPageSize = page.pageSize;
        page.pageSize = Size(page.pdfPage.width, page.pdfPage.height);
        page.status = _PdfPageLoadingStatus.inited;
        if (prevPageSize != page.pageSize && mounted) {
          _relayout(_lastViewSize);
          return;
        }
      }
      if (page.status == _PdfPageLoadingStatus.inited) {
        page.status = _PdfPageLoadingStatus.pageLoading;
        page.preview = await PdfPageImageTexture.create(
            pdfDocument: page.pdfPage.document, pageNumber: page.pageNumber);
        final w = page.pdfPage.width; // * 2;
        final h = page.pdfPage.height; // * 2;
        await page.preview.updateRect(
            width: w.toInt(),
            height: h.toInt(),
            texWidth: w.toInt(),
            texHeight: h.toInt(),
            fullWidth: w,
            fullHeight: h,
            allowAntialiasingIOS: widget.allowAntialiasingIOS);
        page.status = _PdfPageLoadingStatus.pageLoaded;
        page.updatePreview();
      }
    }

    _needRealSizeOverlayUpdate();
  }

  void _cancelLastRealSizeUpdate() {
    if (_realSizeUpdateTimer != null) {
      _realSizeUpdateTimer.cancel();
      _realSizeUpdateTimer = null;
    }
  }

  final _realSizeOverlayUpdateBufferDuration = Duration(milliseconds: 100);

  void _needRealSizeOverlayUpdate() {
    _cancelLastRealSizeUpdate();
    _realSizeUpdateTimer = Timer(
        _realSizeOverlayUpdateBufferDuration, () => _updateRealSizeOverlay());
  }

  Future<void> _updateRealSizeOverlay() async {
    final dpr = MediaQuery.of(context).devicePixelRatio;
    final m = _controller.value;
    final r = m.row0[0];
    final exposed = Rect.fromLTWH(
        -m.row0[3], -m.row1[3], _lastViewSize.width, _lastViewSize.height);
    for (final page in _pages) {
      if (page.rect == null || page.status != _PdfPageLoadingStatus.pageLoaded)
        continue;
      final pageRectZoomed = Rect.fromLTRB(page.rect.left * r,
          page.rect.top * r, page.rect.right * r, page.rect.bottom * r);
      final part = pageRectZoomed.intersect(exposed);
      if (part.isEmpty) continue;
      final fw = pageRectZoomed.width * dpr;
      final fh = pageRectZoomed.height * dpr;
      if (page.preview?.hasUpdatedTexture == true &&
          fw <= page.preview.texWidth &&
          fh <= page.preview.texHeight) {
        // no real-size overlay needed; use preview
        page.realSizeOverlayRect = null;
      } else {
        // render real-size overlay
        final offset = part.topLeft - pageRectZoomed.topLeft;
        page.realSizeOverlayRect = Rect.fromLTWH(
            offset.dx / r, offset.dy / r, part.width / r, part.height / r);
        page.realSize ??= await PdfPageImageTexture.create(
            pdfDocument: page.pdfPage.document, pageNumber: page.pageNumber);
        final w = (part.width * dpr).toInt();
        final h = (part.height * dpr).toInt();
        await page.realSize.updateRect(
            width: w,
            height: h,
            srcX: (offset.dx * dpr).toInt(),
            srcY: (offset.dy * dpr).toInt(),
            texWidth: w,
            texHeight: h,
            fullWidth: fw,
            fullHeight: fh,
            allowAntialiasingIOS: widget.allowAntialiasingIOS);
        page._updateRealSizeOverlay();
      }
    }
  }

  /// Go to the specified location by the matrix.
  Future<void> _goTo(
      {Matrix4 destination,
      Duration duration = const Duration(milliseconds: 200)}) async {
    try {
      if (destination == null) return; // do nothing
      _animGoTo?.removeListener(_updateControllerMatrix);
      _animController.reset();
      _animGoTo = Matrix4Tween(begin: _controller.value, end: destination)
          .animate(_animController);
      _animGoTo.addListener(_updateControllerMatrix);
      await _animController
          .animateTo(1.0, duration: duration, curve: Curves.easeInOut)
          .orCancel;
    } on TickerCanceled {
      // expected
    }
  }

  /*Future<void> _goToNextTag() {
    if(widget.tagList.elementAt(currentTag).pageNumber!=widget.tagList.elementAt(currentTag+1).pageNumber){
      _goTo()
    }
    currentTag++;

  }*/

  void _updateControllerMatrix() {
    _controller.value = _animGoTo.value;
  }
}

enum _PdfPageLoadingStatus {
  notInited,
  initializing,
  inited,
  pageLoading,
  pageLoaded
}

/// Internal page control structure.
class _PdfPageState {
  /// Page number (started at 1).
  final int pageNumber;

  /// Where the page is layed out if available. It can be null to not show in the view.
  Rect rect;

  /// [PdfPage] corresponding to the page if available.
  PdfPage pdfPage;

  /// Size at 72-dpi. During the initialization, the size may be just a copy of the size of the first page.
  Size pageSize;

  /// Preview image of the page rendered at low resolution.
  PdfPageImageTexture preview;

  /// Relative position of the realSize overlay. null to not show realSize overlay.
  Rect realSizeOverlayRect;

  /// realSize overlay.
  PdfPageImageTexture realSize;

  /// Whether the page is visible within the view or not.
  bool isVisibleInsideView = false;

  _PdfPageLoadingStatus status = _PdfPageLoadingStatus.notInited;

  final _previewNotifier = ValueNotifier<int>(0);
  final _realSizeNotifier = ValueNotifier<int>(0);

  _PdfPageState._({@required this.pageNumber, @required this.pageSize});

  /*Widget previewTexture() => _textureFor(preview, _previewNotifier);*/

  void updatePreview() {
    _previewNotifier.value++;
  }

  /*Widget realSizeTexture() => _textureFor(realSize, _realSizeNotifier);*/

  void _updateRealSizeOverlay() {
    _realSizeNotifier.value++;
  }

  /*/// Returns [Texture] widget wrapped by [ValueListenableBuilder], which does auto-refresh on texture content changes.
  Widget _textureFor(PdfPageImageTexture t, ValueNotifier<int> n) {
    return ValueListenableBuilder<int>(
      valueListenable: n,
      builder: (context, value, child) =>
          t != null ? Texture(textureId: t.texId) : Container(),
    );
  }*/

  /// Release allocated textures.
  /// It's always safe to call the method. If all the textures were already released, the method does nothing.
  /// Returns true if textures are really released; otherwise if the method does nothing and returns false.
  bool releaseTextures() {
    if (preview == null) return false;
    preview.dispose();
    realSize?.dispose();
    preview = null;
    realSize = null;
    status = _PdfPageLoadingStatus.inited;
    return true;
  }

  void dispose() {
    releaseTextures();
    _previewNotifier.dispose();
    _realSizeNotifier.dispose();
  }
}
