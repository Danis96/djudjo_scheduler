import 'package:flutter/material.dart';

class CustomBottomNavigationItem {
  CustomBottomNavigationItem({
    this.page,
    this.icon,
    this.title,
    this.unreadMessagesCount = 0,
  });

  final String? title;
  final Widget? page;
  final IconData? icon;
  final int unreadMessagesCount;
}

class CustomBottomNavigationPage extends StatefulWidget {
  const CustomBottomNavigationPage({
    this.selectedItemColor,
    this.unSelectedItemColor = const Color.fromRGBO(227, 233, 239, 1),
    this.items,
    this.widgetKey,
    this.showTitle = false,
    this.logEvent,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBarType = BottomNavigationBarType.fixed,
    this.showTitleFromSide = false,
    this.initialSelection = 0,
    this.showUnselectedLabel = true,
    this.innerPadding = 0.0,
    this.elevation = 8,
    this.onPop,
    this.barVisible = true,
  });

  final Color? selectedItemColor;
  final Color? unSelectedItemColor;
  final Color? backgroundColor;
  final List<CustomBottomNavigationItem>? items;
  final Key? widgetKey;
  final bool showTitle;
  final bool showTitleFromSide;
  final Function? logEvent;
  final BottomNavigationBarType bottomNavigationBarType;
  final int initialSelection;
  final bool showUnselectedLabel;

  ///pushes items to the inside
  final double innerPadding;
  final double elevation;

  ///flag is bottom navigation bar should be visible
  ///necessary for trip details custom flow implementation
  final bool barVisible;

  ///necessary for trip crash solution
  ///scaffold from TripDetails can't recognize
  ///WillPopScope because of BottomNavigationBar's one
  final Future<bool> Function()? onPop;

  @override
  _CustomBottomNavigationPage createState() => _CustomBottomNavigationPage();
}

class _CustomBottomNavigationPage extends State<CustomBottomNavigationPage> {
  late int _selectedIndex = widget.initialSelection;

  void _onItemTapped(int index) {
    if (widget.logEvent != null) {
      widget.logEvent!();
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  bool isIconNotEmpty(IconData? icon) => icon != null;

  List<BottomNavigationBarItem>? _getBottomNavigationBarItems() {
    final List<BottomNavigationBarItem>? _items = <BottomNavigationBarItem>[];
    for (int i = 0; i < widget.items!.length; i++) {
      final BottomNavigationBarItem _bottomItem = BottomNavigationBarItem(
          label: widget.showTitle ? widget.items![i].title : '',
          icon: isIconNotEmpty(widget.items![i].icon!)
              ? Icon(
                  widget.items![i].icon!,
                  color: _selectedIndex != i ? widget.unSelectedItemColor : widget.selectedItemColor,
                  size: 30,
                )
              : const SizedBox());
      _items!.add(_bottomItem);
    }
    return _items;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.onPop != null) {
          return widget.onPop!();
        }
        return Future<bool>.value(false);
      },
      child: Scaffold(
          body: widget.items![_selectedIndex].page,
          bottomNavigationBar: Container(
            color: widget.backgroundColor,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: widget.innerPadding),
              child: widget.barVisible
                  ? BottomNavigationBar(
                      backgroundColor: widget.backgroundColor,
                      items: _getBottomNavigationBarItems()!,
                      currentIndex: _selectedIndex,
                      showUnselectedLabels: widget.showUnselectedLabel,
                      elevation: widget.elevation,
                      type: widget.bottomNavigationBarType,
                      selectedItemColor: widget.selectedItemColor,
                      unselectedItemColor: widget.unSelectedItemColor,
                      onTap: _onItemTapped,
                    )
                  : const SizedBox(),
            ),
          )),
    );
  }
}
