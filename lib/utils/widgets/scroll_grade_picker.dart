import 'package:colgate/models/drop_down/event_grade_model.dart';
import 'package:colgate/utils/config/app_config.dart';
import 'package:flutter/material.dart';

class ScrollGradePicker extends StatefulWidget {
  ScrollGradePicker({
    Key key,
    this.gradeController,
    this.height = 300.0,
    this.initialValue,
    this.selectedTextStyle,
    this.mainTextStyle,
    this.onChanged,
    this.itemExtent = 37.0,
    this.diameterRatio = 3.0,
    this.perspective = 0.01,
    this.eventGradeList,
    this.selectedBoxDecoration = const BoxDecoration(color: Colors.black12),
  })  : assert(itemExtent > 0),
        super(key: key);

  /// This widget's month selection and animation state.
  final FixedExtentScrollController gradeController;

  /// The initial date and/or time of the picker.
  final int initialValue;

  /// An opaque object that determines the size, position, and rendering of selected text.
  final TextStyle selectedTextStyle;

  /// An opaque object that determines the size, position, and rendering of text.
  final TextStyle mainTextStyle;

  /// On optional listener that's called when the centered item changes.
  final Function onChanged;

  /// If non-null, requires the child to have exactly this height.
  final double height;

  /// Size of each child in the main axis
  final double itemExtent;

  /// {@macro flutter.rendering.wheelList.diameterRatio}
  final double diameterRatio;

  /// {@macro flutter.rendering.wheelList.perspective}
  final double perspective;

  /// An immutable description of how to paint a box.
  final BoxDecoration selectedBoxDecoration;

  final List<EventGradeModel> eventGradeList;

  @override
  _ScrollGradePickerState createState() => _ScrollGradePickerState();
}

class _ScrollGradePickerState extends State<ScrollGradePicker> {
  FixedExtentScrollController _gradeController;

  int _gradeIndex;
  String selectedGrade;

  @override
  void initState() {
    super.initState();

    _gradeIndex = widget.initialValue;

    if (widget.gradeController == null) {
    } else {
      _gradeIndex = widget.gradeController.initialItem;
    }

    _gradeController = widget.gradeController ??
        FixedExtentScrollController(initialItem: _gradeIndex);
  }

  @override
  void dispose() {
    _gradeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification) {
          widget.onChanged(selectedGrade, _gradeIndex);
        }
        return false;
      },
      child: SizedBox(
        height: widget.height,
        child: Material(
          color: Colors.white,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: widget.itemExtent,
                  width: 80,
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.black, width: 3),
                      bottom: BorderSide(color: Colors.black, width: 3),
                    ),
                  ),
                ),
              ),
              _enUSDatePicker(),
            ],
          ),
        ),
      ),
    );
  }

  Row _enUSDatePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _listWheelScrollView(
            width: 90.0,
            controller: _gradeController,
            itemIndex: _gradeIndex,
            item: widget.eventGradeList,
            selectedItemChanged: (value) {
              setState(() {
                _gradeIndex = value;
                selectedGrade = widget.eventGradeList[value].name;
              });
            }),
      ],
    );
  }

  Widget _listWheelScrollView(
      {double width,
      ValueChanged<int> selectedItemChanged,
      int itemIndex,
      List<EventGradeModel> item,
      FixedExtentScrollController controller}) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        itemExtent: widget.itemExtent,
        diameterRatio: widget.diameterRatio,
        controller: controller,
        physics: FixedExtentScrollPhysics(),
        perspective: widget.perspective,
        onSelectedItemChanged: selectedItemChanged,
        childDelegate: ListWheelChildLoopingListDelegate(
          children: List<Widget>.generate(
            item.length,
            (index) => Align(
              alignment: Alignment.center,
              child: Text(
                "${item[index].name}",
                style: itemIndex == index
                    ? TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontFamily: AppConfig.appFontFamily2,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.2,
                      )
                    : TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                        fontFamily: AppConfig.appFontFamily2,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.2,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
