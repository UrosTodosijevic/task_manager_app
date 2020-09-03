import 'package:flutter/material.dart';

const double _ITEM_HEIGHT = 70.0;

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() =>  _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Item> _items=[];

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    // TODO - this is shortcut to specify items.
    // In a real app, you would get them
    // from your data repository or similar.
    _items.add( Item("Apples", false));
    _items.add( Item("Oranges", false));
    _items.add( Item("Rosemary", false));
    _items.add( Item("Carrots", false));
    _items.add( Item("Potatoes", false));
    _items.add( Item("Mushrooms", false));
    _items.add( Item("Thyme", false));
    _items.add( Item("Tomatoes", false));
    _items.add( Item("Peppers", false));
    _items.add( Item("Salt", false));
    _items.add( Item("Ground ginger", false));
    _items.add( Item("Cucumber", false));
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonsWidget =  Container(
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           FlatButton(
            textColor: Colors.blueGrey,
            color: Colors.white,
            child:  Text('SELECT ORANGES'),
            onPressed: _scrollToOranges,
          ),
           FlatButton(
            textColor: Colors.blueGrey,
            color: Colors.white,
            child:  Text('SELECT TOMATOES'),
            onPressed: _scrollToTomatoes,
          ),
        ],
      ),
    );

    Widget itemsWidget =  ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        controller: _scrollController,
        children: _items.map((Item item) {
          return _singleItemDisplay(item);
        }).toList());

    // Scroll to first selected item
    for (int i = 0; i < _items.length; i++) {
      if (_items.elementAt(i).selected) {
        _scrollController.animateTo(i * _ITEM_HEIGHT,
            duration:  Duration(seconds: 2), curve: Curves.ease);
        break;
      }
    }

    return  Scaffold(
      appBar:  AppBar(
        title:  Text("List of items"),
      ),
      body:  Padding(
        padding:  EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
        child:  Column(
          children: <Widget>[
            buttonsWidget,
             Expanded(
              child: itemsWidget,
            ),
          ],
        ),
      ),
    );
  }

  Widget _singleItemDisplay(Item item) {
    return  Container(
      height: _ITEM_HEIGHT,
      child:  Container(
        padding: const EdgeInsets.all(2.0),
        color:  Color(0x33000000),
        child:  Text(item.displayName),
      ),
    );
  }

  void _scrollToOranges() {
    setState(() {
      for (var item in _items) {
        if (item.displayName == "Oranges") {
          item.selected = true;
        } else {
          item.selected = false;
        }
      }
    });
  }

  void _scrollToTomatoes() {
    setState(() {
      for (var item in _items) {
        if (item.displayName == "Tomatoes") {
          item.selected = true;
        } else {
          item.selected = false;
        }
      }
    });
  }
}

class Item {
  final String displayName;
  bool selected;

  Item(this.displayName, this.selected);
}
