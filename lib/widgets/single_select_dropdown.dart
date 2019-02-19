import 'package:exata_questoes_app/widgets/text.dart';
import 'package:flutter/material.dart';

class SingleSelectDropDown<T> extends StatefulWidget {
  final void Function(T) onSelect;
  final String Function(T) nameBuilder;
  final List<T> items;
  final String title;
  final String errorMessage;
  final bool isLoading;

  SingleSelectDropDown(
      {@required this.onSelect,
      @required this.items,
      @required this.title,
      @required this.nameBuilder,
      this.errorMessage,
      this.isLoading = false});

  factory SingleSelectDropDown.loading({@required String title}) {
    return SingleSelectDropDown(
      onSelect: null,
      items: null,
      title: title,
      nameBuilder: null,
      errorMessage: null,
      isLoading: true,
    );
  }

  factory SingleSelectDropDown.error(
      {@required String title, @required String error}) {
    return SingleSelectDropDown(
      onSelect: null,
      items: null,
      nameBuilder: null,
      title: title,
      errorMessage: error,
      isLoading: false,
    );
  }

  @override
  _SingleSelectDropDownState createState() => _SingleSelectDropDownState<T>();
}

class _SingleSelectDropDownState<T> extends State<SingleSelectDropDown> {
  String Function(T) get nameBuilder => widget.nameBuilder;
  void Function(T) get onSelect => widget.onSelect;
  List<T> get items => widget.items;
  String get title => widget.title;
  String get errorMessage => widget.errorMessage;
  bool get isLoading => widget.isLoading;
  bool get isErrorMode => errorMessage != null;

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
        trailing: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
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

  Widget _expandedDropDown() {
    var widgets = List<Widget>.from([_collapsedDropDown()]);

    items.forEach((item) {
      var title = nameBuilder(item);
      var newTile = ListTile(
        title: tileSubItemText(title: title),
        onTap: () => onSelect(item),
      );

      widgets.add(newTile);
    });

    return Column(
      children: widgets,
    );
  }

  void _toggleIsExpanded() {
    if (!isErrorMode && !isLoading) {
      setState(() {
        isExpanded = !isExpanded;
      });
    }
  }
}
