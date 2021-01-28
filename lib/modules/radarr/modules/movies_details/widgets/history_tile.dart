import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsHistoryTile extends StatefulWidget {
    final RadarrHistoryRecord history;

    RadarrMovieDetailsHistoryTile({
        Key key,
        @required this.history,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieDetailsHistoryTile> {
    final ExpandableController _expandableController = ExpandableController();

    @override
    Widget build(BuildContext context) => LSExpandable(
        controller: _expandableController,
        collapsed: _collapsed,
        expanded: _expanded,
    );
    
    Widget get _expanded => LSCard(
        child: InkWell(
            child: Row(
                children: [
                    Expanded(
                        child: Padding(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Padding(
                                        child: LSTitle(text: widget.history.sourceTitle, softWrap: true, maxLines: 12),
                                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                                    ),
                                    Padding(
                                        child: Wrap(
                                            direction: Axis.horizontal,
                                            runSpacing: 10.0,
                                            children: [
                                                LSTextHighlighted(
                                                    text: widget.history.eventType?.readable,
                                                    bgColor: widget.history.eventType?.lunaColour,
                                                ),
                                                ...widget.history.customFormats.map<LSTextHighlighted>((format) => LSTextHighlighted(
                                                    text: format.name,
                                                    bgColor: LunaColours.blueGrey,
                                                )),
                                            ],
                                        ),
                                        padding: EdgeInsets.only(top: 8.0, bottom: 2.0, left: 12.0, right: 12.0),
                                    ),
                                    Padding(
                                        child: Column(
                                            children: widget.history.eventType?.lunaTableContent(widget.history) ?? [],
                                        ),
                                        padding: EdgeInsets.only(top: 6.0, bottom: 0.0),
                                    ),
                                ],
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                        ),
                    )
                ],
            ),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            onTap: () => _expandableController.toggle(),
        ),
    );
    
    Widget get _collapsed => LSCardTile(
        title: LSTitle(text: widget.history.sourceTitle),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                    color: Colors.white70,
                ),
                children: [
                    TextSpan(text: widget.history?.date?.lunaDateReadable ?? Constants.TEXT_EMDASH),
                    TextSpan(text: '\n'),
                    TextSpan(
                        text: widget.history?.eventType?.readable ?? Constants.TEXT_EMDASH,
                        style: TextStyle(
                            color: widget.history?.eventType?.lunaColour ?? LunaColours.blueGrey,
                            fontWeight: FontWeight.w600,
                        ),
                    ),
                ],
            ),
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 2,
        ),
        padContent: true,
        onTap: () => _expandableController.toggle(),
    );
}
