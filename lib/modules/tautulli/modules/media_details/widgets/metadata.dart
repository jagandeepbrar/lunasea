import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliMediaDetailsMetadata extends StatefulWidget {
    final TautulliMediaType type;
    final int ratingKey;

    TautulliMediaDetailsMetadata({
        @required this.type,
        @required this.ratingKey,
        Key key,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliMediaDetailsMetadata> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    
    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        TautulliState _global = Provider.of<TautulliState>(context, listen: false);
        TautulliLocalState _local = Provider.of<TautulliLocalState>(context, listen: false);
        _local.setMetadata(
            widget.ratingKey,
            _global.api.libraries.getMetadata(ratingKey: widget.ratingKey),
        );
        await _local.metadata[widget.ratingKey];
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: Provider.of<TautulliLocalState>(context).metadata[widget.ratingKey],
            builder: (context, AsyncSnapshot<TautulliMetadata> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        Logger.error(
                            'TautulliMediaDetailsMetadata',
                            '_body',
                            'Unable to fetch Tautulli metadata: ${widget.ratingKey}',
                            snapshot.error,
                            null,
                            uploadToSentry: !(snapshot.error is DioError),
                        );
                    }
                    return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                }
                if(snapshot.hasData) return _metadata(snapshot.data);
                return LSLoader();
            },
        ),
    );

    Widget _metadata(TautulliMetadata metadata) => LSListView(
        children: [
            TautulliMediaDetailsMetadataHeaderTile(metadata: metadata),
            metadata.summary.trim().isEmpty ? Container() : TautulliMediaDetailsMetadataSummary(metadata: metadata),
            TautulliMediaDetailsSwitcherButton(metadata: metadata, ratingKey: widget.ratingKey, type: widget.type),
            TautulliMediaDetailsMetadataMetadata(metadata: metadata),
        ],
    );
}
