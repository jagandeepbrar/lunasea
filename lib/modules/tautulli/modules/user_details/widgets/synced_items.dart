import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tautulli/tautulli.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliUserDetailsSyncedItems extends StatefulWidget {
    final TautulliTableUser user;

    TautulliUserDetailsSyncedItems({
        Key key,
        @required this.user,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliUserDetailsSyncedItems> with AutomaticKeepAliveClientMixin {
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
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        _state.setUserSyncedItems(
            widget.user.userId,
            _state.api.libraries.getSyncedItems(userId: widget.user.userId),
        );
        await _state.userSyncedItems[widget.user.userId];
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
            future: Provider.of<TautulliState>(context).userSyncedItems[widget.user.userId],
            builder: (context, AsyncSnapshot<List<TautulliSyncedItem>> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        Logger.error(
                            'TautulliUserDetailsSyncedItems',
                            '_body',
                            'Unable to fetch Tautulli user synced items: ${widget.user.userId}',
                            snapshot.error,
                            null,
                            uploadToSentry: !(snapshot.error is DioError),
                        );
                    }
                    return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                }
                if(snapshot.hasData) return _syncedItems(snapshot.data);
                return LSLoader();
            },
        ),
    );

    Widget _syncedItems(List<TautulliSyncedItem> items) => items.length == 0
        ? LSGenericMessage(
            text: 'No Synced Items',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () async => _refreshKey.currentState.show(),
        )
        : LSListViewBuilder(
            itemCount: items.length,
            itemBuilder: (context, index) => TautulliSyncedItemTile(
                syncedItem: items[index],
                showUsername: false,
            ),
        );
}
