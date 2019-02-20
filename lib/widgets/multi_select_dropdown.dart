import 'package:exata_questoes_app/widgets/text.dart';
import 'package:flutter/material.dart';

class MultiSelectDropDown<T> extends StatefulWidget {
  final List<T> items;
  final void Function(bool, T) onSelect;
  final String Function(T) onBuildName;
  final String title;
  final String errorMessage;
  final bool isLoading;

  MultiSelectDropDown(
      {@required this.items,
      @required this.onSelect,
      @required this.title,
      @required this.onBuildName,
      this.errorMessage,
      this.isLoading = false});

  factory MultiSelectDropDown.loading({@required String title}) {
    return MultiSelectDropDown(
      onSelect: null,
      items: null,
      onBuildName: null,
      title: title,
      errorMessage: null,
      isLoading: true,
    );
  }

  factory MultiSelectDropDown.error(
      {@required String title, @required String error}) {
    return MultiSelectDropDown(
      onBuildName: null,
      onSelect: null,
      items: null,
      title: title,
      errorMessage: error,
      isLoading: false,
    );
  }

  @override
  _MultiSelectDropDownState<T> createState() => _MultiSelectDropDownState<T>();
}

class _MultiSelectDropDownState<T> extends State<MultiSelectDropDown<T>> {
  List<T> get items => widget.items;
  void Function(bool, T) get onSelect => widget.onSelect;
  String Function(T) get onBuildName => widget.onBuildName;
  String get title => widget.title;
  bool get isLoading => widget.isLoading;
  String get errorMessage => widget.errorMessage;
  bool get isErrorMode => errorMessage != null;
  bool get isDataMode => (!isErrorMode && !isLoading);

  bool _isExpanded;
  var _checkMapState = Map<String, bool>();

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    return _isExpanded ? _expandedDropDown() : _collapsedDropDown();
  }

  Widget _expandedDropDown() {
    var widgets = List<Widget>.from([_collapsedDropDown()]);
    items.forEach((item) {
      var title = onBuildName(item);
      var newTile = CheckboxListTile(
        value: _checkMapState[title],
        title: tileSubItemText(title: title),
        onChanged: (value) => _onChecked(value, item),
      );

      widgets.add(newTile);
    });

    return Column(
      children: widgets,
    );
  }

  Widget _collapsedDropDown() {
    return ListTile(
        title: tileText(title: title),
        subtitle: _buildSubtitle(),
        onTap: _toggleIsExpanded,
        trailing: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : Icon(Icons.keyboard_arrow_down));
  }

  Widget _buildSubtitle() {
    if (errorMessage != null) {
      return Text(
        errorMessage,
        style: TextStyle(color: Colors.red),
      );
    }

    return null;
  }

  void _toggleIsExpanded() {
    if (isDataMode) {
      setState(() {
        _isExpanded = !_isExpanded;
        if (_isExpanded && _checkMapState.isEmpty) {
          items.forEach((item) => _checkMapState[onBuildName(item)] = false);
        }
      });
    }
  }

  void _onChecked(bool newValue, T item) {
    onSelect(newValue, item);
    setState(() => _checkMapState[onBuildName(item)] = newValue);
  }
}
