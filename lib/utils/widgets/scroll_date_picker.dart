import 'package:flutter/material.dart';

class ScrollDatePicker extends StatefulWidget {
  ScrollDatePicker({
    Key key,
    this.yearController,
    this.dayController,
    this.monthController,
    this.height = 300.0,
    this.minimumYear = 2000,
    this.maximumYear = 2100,
    this.initialDateTime,
    this.selectedTextStyle = const TextStyle(
        fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w600),
    this.mainTextStyle = const TextStyle(fontSize: 14.0, color: Colors.grey),
    this.onChanged,
    this.itemExtent = 37.0,
    this.diameterRatio = 3.0,
    this.perspective = 0.01,
    this.selectedBoxDecoration = const BoxDecoration(color: Colors.black12),
    this.isLoop = true,
  })  : assert(itemExtent > 0),
        super(key: key);

  /// This widget's year selection and animation state.
  final FixedExtentScrollController yearController;

  /// This widget's month selection and animation state.
  final FixedExtentScrollController monthController;

  /// This widget's day selection and animation state.
  final FixedExtentScrollController dayController;

  /// Minimum year that the picker can be scrolled
  final int minimumYear;

  /// Maximum year that the picker can be scrolled
  final int maximumYear;

  /// The initial date and/or time of the picker.
  final DateTime initialDateTime;

  /// An opaque object that determines the size, position, and rendering of selected text.
  final TextStyle selectedTextStyle;

  /// An opaque object that determines the size, position, and rendering of text.
  final TextStyle mainTextStyle;

  /// On optional listener that's called when the centered item changes.
  final ValueChanged<DateTime> onChanged;

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

  /// The loop iterates on an explicit list of values
  final bool isLoop;

  /// Set calendar language

  @override
  _ScrollDatePickerState createState() => _ScrollDatePickerState();
}

class _ScrollDatePickerState extends State<ScrollDatePicker> {
  FixedExtentScrollController _yearController;
  FixedExtentScrollController _monthController;
  FixedExtentScrollController _dayController;

  List<String> _month = [];
  List<int> _day = [];
  List<int> _year = [];

  int _selectedYear = 0;
  // String _selectedMonth;
  int _selectedDay = 0;

  int _monthIndex;
  int _dayIndex;
  int _yearIndex;

  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();

    _year = [for (int i = widget.minimumYear; i <= widget.maximumYear; i++) i];

    _month = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'June',
      'July',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    _selectedYear = widget.initialDateTime.year;
    _monthIndex = widget.initialDateTime.month - 1;
    _selectedDay = widget.initialDateTime.day;

    _day = [for (int i = 1; i <= _getMonthlyDate(_monthIndex); i++) i];

    if (widget.yearController == null) {
      _yearIndex = _year.indexOf(_selectedYear);
    } else {
      _yearIndex = widget.yearController.initialItem;
      _selectedYear = _year[_yearIndex];
    }

    if (widget.monthController == null) {
    } else {
      _monthIndex = widget.monthController.initialItem;
    }

    if (widget.dayController == null) {
      _dayIndex = _day.indexOf(_selectedDay);
    } else {
      _dayIndex = widget.dayController.initialItem;
      _selectedDay = _day[_dayIndex];
    }

    _yearController = widget.yearController ??
        FixedExtentScrollController(initialItem: _yearIndex);
    _monthController = widget.monthController ??
        FixedExtentScrollController(initialItem: _monthIndex);
    _dayController = widget.dayController ??
        FixedExtentScrollController(initialItem: _dayIndex);
  }

  int _getMonthlyDate(int month) {
    int day = 0;

    switch (month) {
      case 1:
        day = 31;
        break;
      case 2:
        day = (_selectedYear % 4 == 0 && _selectedYear % 100 != 0) ||
                _selectedYear % 400 == 0
            ? 29
            : 28;
        break;
      case 3:
        day = 31;
        break;
      case 4:
        day = 30;
        break;
      case 5:
        day = 31;
        break;
      case 6:
        day = 30;
        break;
      case 7:
        day = 31;
        break;
      case 8:
        day = 31;
        break;
      case 9:
        day = 30;
        break;
      case 10:
        day = 31;
        break;
      case 11:
        day = 30;
        break;
      case 12:
        day = 31;
        break;

      default:
        day = 30;
        break;
    }

    return day;
  }

  void _updateDay() {
    int selectedDayIndex = _day.indexOf(_selectedDay);
    if (selectedDayIndex != -1) {
      _dayController.jumpTo(0.1);
      _dayController.jumpTo(selectedDayIndex * widget.itemExtent);
    } else {
      _dayController.jumpTo(0.1);
      _dayController.jumpTo(0);
    }
  }

  String _dateFormatter(int value) {
    return value.toString().length > 1 ? value.toString() : "0$value";
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification) {
          DateTime date = DateTime.parse(
              "$_selectedYear-${_dateFormatter(_monthIndex + 1)}-${_dateFormatter(_selectedDay)}");
          if (date != _selectedDate) {
            setState(() {
              _selectedDate = date;
            });
            widget.onChanged(DateTime.parse(
                "$_selectedYear-${_dateFormatter(_monthIndex + 1)}-${_dateFormatter(_selectedDay)}"));
          }
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
                child: Row(
                  children: [
                    for (var i = 0; i < 3; i++)
                      Container(
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
                  ],
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // const SizedBox(width: 5.0),
        _listWheelScrollView(
            width: 90.0,
            controller: _dayController,
            itemIndex: _dayIndex,
            item: _day,
            selectedItemChanged: (value) {
              setState(() {
                _dayIndex = value;
                _selectedDay = _day[value];
              });
            }),
        // const SizedBox(width: 16.0),
        _listWheelScrollView(
            width: 90.0,
            controller: _monthController,
            itemIndex: _monthIndex,
            item: _month,
            selectedItemChanged: (value) {
              setState(() {
                _monthIndex = value;
                // _selectedMonth = _month[value];
                _day = [
                  for (int i = 1; i <= _getMonthlyDate(_monthIndex + 1); i++) i
                ];
              });
              _updateDay();
            }),
        // const SizedBox(width: 10.0),
        _listWheelScrollView(
            width: 90.0,
            controller: _yearController,
            itemIndex: _yearIndex,
            item: _year,
            selectedItemChanged: (value) {
              setState(() {
                _yearIndex = value;
                _selectedYear = _year[value];
                _day = [
                  for (int i = 1; i <= _getMonthlyDate(_monthIndex + 1); i++) i
                ];
              });
              _updateDay();
            }),
        // const SizedBox(width: 16.0),
      ],
    );
  }

  Widget _listWheelScrollView(
      {double width,
      ValueChanged<int> selectedItemChanged,
      int itemIndex,
      List item,
      String dateFormat = "",
      FixedExtentScrollController controller}) {
    return widget.isLoop
        ? Container(
            width: width,
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
                  (index) => Container(
                    alignment: Alignment.center,
                    child: Text("${item[index]}$dateFormat",
                        style: itemIndex == index
                            ? widget.selectedTextStyle
                            : widget.mainTextStyle),
                  ),
                ),
              ),
            ),
          )
        : Container(
            width: width,
            child: ListWheelScrollView(
              itemExtent: widget.itemExtent,
              diameterRatio: widget.diameterRatio,
              controller: controller,
              physics: FixedExtentScrollPhysics(),
              perspective: widget.perspective,
              onSelectedItemChanged: selectedItemChanged,
              children: List<Widget>.generate(
                item.length,
                (index) => Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${item[index]}$dateFormat",
                    style: itemIndex == index
                        ? widget.selectedTextStyle
                        : widget.mainTextStyle,
                  ),
                ),
              ),
            ),
          );
  }
}
