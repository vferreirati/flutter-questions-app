import 'package:exata_questoes_app/widgets/text.dart';
import 'package:flutter/material.dart';

class SingleSelectDropDown extends StatefulWidget {
  final void Function(String) onSelect;
  final List<String> itemsTitle;
  final String title;

  SingleSelectDropDown(
      {@required this.onSelect,
      @required this.itemsTitle,
      @required this.title});

  @override
  _SingleSelectDropDownState createState() => _SingleSelectDropDownState();
}

class _SingleSelectDropDownState extends State<SingleSelectDropDown> {
  List<String> get itemsTitle => widget.itemsTitle;
  Function get onSelect => widget.onSelect;
  String get title => widget.title;

  bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    return isExpanded ? _expandedDropDown() : _collapsedDropDown();
  }

  Widget _collapsedDropDown() {
    return ListTile(
      title: tileText(title: title),
      onTap: _toggleIsExpanded,
      trailing: Icon(Icons.keyboard_arrow_down),
    );
  }

  Widget _expandedDropDown() {
    var widgets = List<Widget>.from([_collapsedDropDown()]);

    itemsTitle.forEach((title) {
      var newTile = ListTile(
        title: tileSubItemText(title: title),
        onTap: () => onSelect(title),
      );

      widgets.add(newTile);
    });

    return Column(
      children: widgets,
    );
  }

  void _toggleIsExpanded() => setState(() => this.isExpanded = !this.isExpanded);
}