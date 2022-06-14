import 'package:flutter/material.dart';
import 'package:period_track/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      color: primaryDark,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTabItem(
                FABBottomAppBarItem(
                    iconData: Icons.calendar_today, text: AppLocalizations.of(context)!.calendar),
                0,
                widget.onItemTapped),
            _buildTabItem(
                FABBottomAppBarItem(iconData: Icons.note_add, text: AppLocalizations.of(context)!.notes),
                1,
                widget.onItemTapped),
            _buildTabItem(
                FABBottomAppBarItem(
                    iconData: Icons.insights, text: AppLocalizations.of(context)!.statistics),
                2,
                widget.onItemTapped),
            _buildTabItem(
                FABBottomAppBarItem(iconData: Icons.settings, text: AppLocalizations.of(context)!.settings),
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
        ? secondaryLight
        : secondary;
    return SizedBox(
      height: 80,
      width: 80,
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
