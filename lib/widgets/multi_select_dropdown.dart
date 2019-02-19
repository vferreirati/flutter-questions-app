import 'package:exata_questoes_app/widgets/text.dart';
import 'package:flutter/material.dart';

class MultiSelectDropDown extends StatefulWidget {
  final List<String> itemsTitle;
  final void Function(bool, String) onSelect;
  final String title;
  final String errorMessage;
  final String subtitle;

  MultiSelectDropDown(
      {@required this.itemsTitle,
      @required this.onSelect,
      @required this.title,
      this.errorMessage,
      this.subtitle});

  factory MultiSelectDropDown.loading(
      {@required String subtitle, @required String title}) {
    return MultiSelectDropDown(
      onSelect: null,
      itemsTitle: null,
      title: title,
      errorMessage: null,
      subtitle: subtitle,
    );
  }

  factory MultiSelectDropDown.error(
      {@required String title, @required String error}) {
    return MultiSelectDropDown(
      onSelect: null,
      itemsTitle: null,
      title: title,
      errorMessage: error,
      subtitle: null,
    );
  }

  @override
  _MultiSelectDropDownState createState() => _MultiSelectDropDownState();
}

class _MultiSelectDropDownState extends State<MultiSelectDropDown> {
  List<String> get itemsTitle => widget.itemsTitle;
  Function get onSelect => widget.onSelect;
  String get title => widget.title;
  String get errorMessage => widget.errorMessage;
  String get subtitle => widget.subtitle;
  bool get isErrorMode => errorMessage != null;
  bool get isLoadingMode => subtitle != null;
  bool get isDataMode => (!isErrorMode && !isLoadingMode);

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
    itemsTitle.forEach((title) {
      var newTile = CheckboxListTile(
        value: _checkMapState[title],
        title: tileSubItemText(title: title),
        onChanged: (value) => _onChecked(value, title),
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
      trailing: Icon(Icons.keyboard_arrow_down),
    );
  }

  Widget _buildSubtitle() {
    if (errorMessage != null) {
      return Text(
        errorMessage,
        style: TextStyle(color: Colors.red),
      );
    } else if (subtitle != null) {
      return Text(subtitle);
    }

    return null;
  }

  void _toggleIsExpanded() {
    if (!isErrorMode && !isLoadingMode) {
      setState(() {
        _isExpanded = !_isExpanded;
        if(_isExpanded && _checkMapState.isEmpty) {
          itemsTitle.forEach((title) => _checkMapState[title] = false);
        }
      });
    }
  }

  void _onChecked(bool newValue, String title) {
    onSelect(newValue, title);
    setState(() => _checkMapState[title] = newValue);
  }
}
