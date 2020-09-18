import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliMediaDetailsRoute extends StatefulWidget {
    static const String ROUTE_NAME = '/tautulli/media/details/:type/:ratingkey/:profile';
    final int ratingKey;
    final TautulliMediaType mediaType;

    TautulliMediaDetailsRoute({
        Key key,
        @required this.ratingKey,
        @required this.mediaType,
    }) : super(key: key);

    @override
    State<TautulliMediaDetailsRoute> createState() => _State();

    static String route({
        String profile,
        @required int ratingKey,
        @required TautulliMediaType mediaType,
    }) {
        if(profile == null) return '/tautulli/media/details/${mediaType.value}/$ratingKey/${LunaSeaDatabaseValue.ENABLED_PROFILE.data}';
        return '/tautulli/media/details/${mediaType.value}/$ratingKey/$profile';
    }

    static void defineRoute(Router router) => router.define(
        TautulliMediaDetailsRoute.ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => TautulliMediaDetailsRoute(
            ratingKey: int.tryParse(params['ratingkey'][0]),
            mediaType: TautulliMediaType.NULL.from(params['type'][0]),
        )),
        transitionType: LunaRouter.transitionType,
    );
}

class _State extends State<TautulliMediaDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS.data);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        bottomNavigationBar: _bottomNavigationBar,
        body: widget.mediaType != null && widget.mediaType != TautulliMediaType.NULL && widget.ratingKey != null
            ? _body
            : _contentNotFound,
    );

    Widget get _appBar => LSAppBar(title: 'Media Details');

    Widget get _bottomNavigationBar {
        if(
            widget.mediaType != null &&
            widget.mediaType != TautulliMediaType.NULL &&
            widget.mediaType != TautulliMediaType.COLLECTION &&
            widget.ratingKey != null
        ) return TautulliMediaDetailsNavigationBar(pageController: _pageController);
        return null;
    }


    Widget get _body => widget.mediaType != TautulliMediaType.COLLECTION
        ? PageView(
            controller: _pageController,
            children: _tabs,
        )
        : TautulliMediaDetailsMetadata(ratingKey: widget.ratingKey, type: widget.mediaType);

    List<Widget> get _tabs => [
        TautulliMediaDetailsMetadata(ratingKey: widget.ratingKey, type: widget.mediaType),
        TautulliMediaDetailsHistory(ratingKey: widget.ratingKey, type: widget.mediaType),
    ];

    Widget get _contentNotFound => LSGenericMessage(text: 'No Content Found');
}
