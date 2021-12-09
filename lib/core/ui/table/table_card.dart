import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaTableCard extends StatelessWidget {
  final String title;
  final List<LunaTableContent> content;
  final List<LunaButton> buttons;

  const LunaTableCard({
    Key key,
    this.content,
    this.buttons,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaCard(
      context: context,
      child: Padding(
        child: _body(),
        padding: LunaUI.MARGIN_DEFAULT,
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        if (title?.isNotEmpty ?? false) _title(),
        ..._content(),
        _buttons(),
      ],
    );
  }

  Widget _title() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: LunaUI.DEFAULT_MARGIN_SIZE),
          child: LunaText.title(text: title),
        ),
      ],
    );
  }

  List<Widget> _content() {
    return content
            ?.map<Widget>((content) => Padding(
                  child: content,
                  padding: const EdgeInsets.symmetric(
                      horizontal: LunaUI.DEFAULT_MARGIN_SIZE),
                ))
            ?.toList() ??
        [];
  }

  Widget _buttons() {
    if (buttons == null) return Container(height: 0.0);
    return Padding(
      child: Row(
        children:
            buttons.map<Widget>((button) => Expanded(child: button)).toList(),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: LunaUI.DEFAULT_MARGIN_SIZE / 2),
    );
  }
}
