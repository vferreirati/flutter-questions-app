import 'package:exata_questoes_app/widgets/text.dart';
import 'package:flutter/material.dart';

class SingleSelectDropDown extends StatefulWidget {
  final void Function(String) onSelect;
  final List<String> itemsTitle;
  final String title;
  final String errorMessage;
  final String subtitle;

  SingleSelectDropDown(
      {@required this.onSelect,
      @required this.itemsTitle,
      @required this.title,
      this.errorMessage,
      this.subtitle});

  factory SingleSelectDropDown.loading(
      {@required String subtitle, @required String title}) {
    return SingleSelectDropDown(
      onSelect: null,
      itemsTitle: null,
      title: title,
      errorMessage: null,
      subtitle: subtitle,
    );
  }

  factory SingleSelectDropDown.error(
      {@required String title, @required String error}) {
    return SingleSelectDropDown(
      onSelect: null,
      itemsTitle: null,
      title: title,
      errorMessage: error,
      subtitle: null,
    );
  }

  @override
  _SingleSelectDropDownState createState() => _SingleSelectDropDownState();
}

class _SingleSelectDropDownState extends State<SingleSelectDropDown> {
  List<String> get itemsTitle => widget.itemsTitle;
  Function get onSelect => widget.onSelect;
  String get title => widget.title;
  String get errorMessage => widget.errorMessage;
  String get subtitle => widget.subtitle;
  bool get isErrorMode => errorMessage != null;
  bool get isLoadingMode => subtitle != null;

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
    } 
    if (subtitle != null) {
      return Text(subtitle);
    }

    return null;
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

  void _toggleIsExpanded() {
    if (!isErrorMode && !isLoadingMode) {
      setState(() {
        isExpanded = !isExpanded;
      });
    }
  }
}
