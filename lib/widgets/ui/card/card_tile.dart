import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';

class LSCardTile extends StatelessWidget {
    final Widget title;
    final Widget subtitle;
    final Widget trailing;
    final Widget leading;
    final Function onTap;
    final Function onLongPress;
    final bool padContent;
    final Decoration decoration;

    LSCardTile({
        @required this.title,
        @required this.subtitle,
        this.trailing,
        this.leading,
        this.onTap,
        this.onLongPress,
        this.padContent = false,
        this.decoration,
    });

    @override
    Widget build(BuildContext context) {
        return Card(
            child: Container(
                child: ListTile(
                    title: title,
                    subtitle: subtitle,
                    trailing: trailing,
                    leading: leading,
                    onTap: onTap,
                    onLongPress: onLongPress,
                    contentPadding: padContent
                        ? EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0)
                        : null,
                ),
                decoration: decoration,
            ),
            margin: Constants.UI_CARD_MARGIN,
            elevation: Constants.UI_ELEVATION,
        );
    }
}
