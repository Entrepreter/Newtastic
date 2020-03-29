import 'package:flutter/material.dart';

class FloatingAppBar extends StatefulWidget {
  final int currentIndex;

  FloatingAppBar(this.currentIndex);

  @override
  _FloatingAppBarState createState() => _FloatingAppBarState();
}

class _FloatingAppBarState extends State<FloatingAppBar> {
  bool isClearVisible = false;
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
//              margin: EdgeInsets.symmetric(vertical:),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.grey.shade300),
              padding: EdgeInsets.only(left: 9),
              child: TextField(
                controller: _editingController,
                style: TextStyle(fontSize: 17),
                onChanged: (query) {
                  if (query.length > 0) {
                    setState(() {
                      isClearVisible = true;
                    });
                  } else {
                    setState(() {
                      isClearVisible = false;
                    });
                  }
                },
                decoration: InputDecoration.collapsed(
                  hintText: widget.currentIndex == 0
                      ? "Search in hot"
                      : "Search in new",
                ),
              ),
            ),
          ),
          isClearVisible
              ? Container(
                  padding: EdgeInsets.only(left: 8),
                  child: InkWell(
                    onTap: () {
                      _editingController.text = "";
                    },
                    child: Text(
                      "Clear",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
