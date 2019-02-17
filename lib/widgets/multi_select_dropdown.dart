import 'package:exata_questoes_app/widgets/text.dart';
import 'package:flutter/material.dart';

class MultiSelectDropDown extends StatefulWidget {
  final List<String> itemsTitle;
  final void Function(bool, String) onSelect;
  final String title;

  MultiSelectDropDown(
      {@required this.itemsTitle,
      @required this.onSelect,
      @required this.title});

  @override
  _MultiSelectDropDownState createState() => _MultiSelectDropDownState();
}

class _MultiSelectDropDownState extends State<MultiSelectDropDown> {
  List<String> get itemsTitle => widget.itemsTitle;
  Function get onSelect => widget.onSelect;
  String get title => widget.title;

  bool _isExpanded;
  var _checkMapState = Map<String, bool>();

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
    itemsTitle.forEach((title) => _checkMapState[title] = false);
  }

  @override
  Widget build(BuildContext context) {
    return _isExpanded ? _expandedDropDown() : _collapsedDropDown();
  }

  Widget _expandedDropDown() {
    return Column(
      children: _buildChildren(),
    );
  }

  Widget _collapsedDropDown() {
    return ListTile(
      title: tileText(title: title),
      onTap: _toggleIsExpanded,
      trailing: Icon(Icons.keyboard_arrow_down),
    );
  }

  void _toggleIsExpanded() => setState(() => this._isExpanded = !this._isExpanded);

  List<Widget> _buildChildren() {
    var widgets = List<Widget>.from([_collapsedDropDown()]);

    itemsTitle.forEach((title) {
      var newTile = CheckboxListTile(
        value: _checkMapState[title],
        title: tileSubItemText(title: title),
        onChanged: (value) => _onChecked(value, title),
      );

      widgets.add(newTile);
    });

    return widgets;
  }

  void _onChecked(bool newValue, String title) {
    onSelect(newValue, title);
    setState(() => _checkMapState[title] = newValue);
  }
}
