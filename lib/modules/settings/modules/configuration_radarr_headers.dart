import 'dart:convert';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationRadarrHeadersRouter extends LunaPageRouter {
    SettingsConfigurationRadarrHeadersRouter() : super('/settings/configuration/radarr/headers');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationRadarrHeadersRoute());
}

class _SettingsConfigurationRadarrHeadersRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationRadarrHeadersRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationRadarrHeadersRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(title: 'Custom Headers');

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, profile, _) => LSListView(
            children: _headers,
        ),
    );

    List<Widget> get _headers => [
        if((Database.currentProfileObject.radarrHeaders ?? {}).isEmpty) _noHeaders,
        ..._list,
        _addHeaderTile,
    ];

    Widget get _noHeaders => LunaMessage.inList(text: 'No Custom Headers Added');

    List<Widget> get _list {
        Map<String, dynamic> headers = (Database.currentProfileObject.radarrHeaders ?? {}).cast<String, dynamic>();
        List<LSCardTile> list = [];
        headers.forEach((key, value) => list.add(_headerTile(key.toString(),value.toString())));
        list.sort((a,b) => (a.title as LSTitle).text.toLowerCase().compareTo((b.title as LSTitle).text.toLowerCase()));
        return list;
    }

    Widget _headerTile(String key, String value) => LSCardTile(
        title: LSTitle(text: key),
        subtitle: LSSubtitle(text: value),
        trailing: LSIconButton(
            icon: Icons.delete,
            color: LunaColours.red,
            onPressed: () async {
                List results = await SettingsDialogs.deleteHeader(context);
                if(results[0]) {
                    Map<String, dynamic> _headers = (Database.currentProfileObject.radarrHeaders ?? {}).cast<String, dynamic>();
                    _headers.remove(key);
                    Database.currentProfileObject.radarrHeaders = _headers;
                    Database.currentProfileObject.save();
                    showLunaSuccessSnackBar(
                        context: context,
                        message: key,
                        title: 'Header Deleted',
                    );
                }
            },
        ),
    );

    Widget get _addHeaderTile => LSButton(
        text: 'Add Header',
        onTap: () async {
            List results = await SettingsDialogs.addHeader(context);
            if(results[0]) switch(results[1]) {
                case 1:
                    List results = await SettingsDialogs.addAuthenticationHeader(context);
                    if(results[0]) {
                        Map<String, dynamic> _headers = (Database.currentProfileObject.radarrHeaders ?? {}).cast<String, dynamic>();
                        String _auth = base64.encode(utf8.encode('${results[1]}:${results[2]}'));
                        _headers.addAll({'Authorization': 'Basic $_auth'});
                        Database.currentProfileObject.radarrHeaders = _headers;
                        Database.currentProfileObject.save();
                        Provider.of<RadarrState>(context, listen: false).reset();
                    }
                break;
                case 100:
                    List results = await SettingsDialogs.addCustomHeader(context);
                    if(results[0]) {
                        Map<String, dynamic> _headers = (Database.currentProfileObject.radarrHeaders ?? {}).cast<String, dynamic>();
                        _headers.addAll({results[1]: results[2]});
                        Database.currentProfileObject.radarrHeaders = _headers;
                        Database.currentProfileObject.save();
                        Provider.of<RadarrState>(context, listen: false).reset();
                    }
                break;
                default:
                    LunaLogger().warning(
                        '_SettingsConfigurationRadarrHeadersRoute',
                        '_addHeaderTile',
                        'Unknown case: ${results[1]}',
                    );
                break;
            }
        },
    );
}
