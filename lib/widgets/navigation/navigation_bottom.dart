import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({required this.iconData, required this.text});
  IconData iconData;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  const FABBottomAppBar(
      {Key? key, required this.selectedIndex, required this.onItemTapped})
      : super(key: key);

  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: primaryDarkColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTabItem(
                FABBottomAppBarItem(
                    iconData: Icons.calendar_today, text: 'Calendar'),
                0,
                widget.onItemTapped),
            _buildTabItem(
                FABBottomAppBarItem(iconData: Icons.note_add, text: 'Notes'),
                1,
                widget.onItemTapped),
            _buildTabItem(
                FABBottomAppBarItem(
                    iconData: Icons.insights, text: 'Statistics'),
                2,
                widget.onItemTapped),
            _buildTabItem(
                FABBottomAppBarItem(iconData: Icons.settings, text: 'Settings'),
                3,
                widget.onItemTapped),
            FloatingActionButton(
              onPressed: () {
                navigatorKey.currentState!.pushNamed('/add-note', arguments: {
                  "id": DateUtils.dateOnly(DateTime.now()).toIso8601String()
                });
              },
              child: const Icon(Icons.note_add),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(
    FABBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  ) {
    Color color = widget.selectedIndex == index
        ? const Color(0xffE3E3A7)
        : const Color(0xffFFBB7C);
    return SizedBox(
      height: 70,
      width: 70,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => onPressed(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(item.iconData, color: color, size: 24),
              Text(
                item.text,
                style: TextStyle(color: color),
              )
            ],
          ),
        ),
      ),
    );
  }
}
