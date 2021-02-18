import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSearchAddHeadersRoute extends StatefulWidget {
    final IndexerHiveObject indexer;

    SettingsConfigurationSearchAddHeadersRoute({
        Key key,
        @required this.indexer,
    }) : super(key: key);

    @override
    State<SettingsConfigurationSearchAddHeadersRoute> createState() => _State();
}

class _State extends State<SettingsConfigurationSearchAddHeadersRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(title: 'Custom Headers');

    Widget get _body => LunaListView(
        children: [
            if((widget.indexer.headers ?? {}).isEmpty) _noHeaders,
            ..._list,
            _addHeader,
        ],
    );

    Widget get _noHeaders => LunaMessage.inList(text: 'No Custom Headers Added');

    List<Widget> get _list {
        Map<String, dynamic> headers = (widget.indexer.headers ?? {}).cast<String, dynamic>();
        List<LSCardTile> list = [];
        headers.forEach((key, value) => list.add(_header(key.toString(), value.toString())));
        list.sort((a,b) => (a.title as LSTitle).text.toLowerCase().compareTo((b.title as LSTitle).text.toLowerCase()));
        return list;
    }

    Widget _header(String key, String value) => LSCardTile(
        title: LSTitle(text: key.toString()),
        subtitle: LSSubtitle(text: value.toString()),
        trailing: LSIconButton(
            icon: Icons.delete,
            color: LunaColours.red,
            onPressed: () async => _delete(key),
        ),
    );

    Widget get _addHeader => LSButton(
        text: 'Add Header',
        onTap: () {},
        // onTap: () async => _add(),
    );

    // Future<void> _add() async {
    //     List results = await SettingsDialogs.addHeader(context);
    //     if(results[0]) switch(results[1]) {
    //         case 1:
    //             _showAuthenticationPrompt(context);
    //             break;
    //         case 100:
    //             _showCustomPrompt(context);
    //             break;
    //         default:
    //             LunaLogger().warning(
    //                 'SettingsModulesLidarrHeadersAddHeaderTile',
    //                 '_add',
    //                 'Unknown case: ${results[1]}',
    //             );
    //             break;
    //     }
    // }

    // Future<void> _showAuthenticationPrompt(BuildContext context) async {
    //     List results = await SettingsDialogs.addAuthenticationHeader(context);
    //     if(results[0]) {
    //         Map<String, dynamic> _headers = (widget.indexer.headers ?? {}).cast<String, dynamic>();
    //         String _auth = base64.encode(utf8.encode('${results[1]}:${results[2]}'));
    //         _headers.addAll({'Authorization': 'Basic $_auth'});
    //         widget.indexer.headers = _headers;
    //         showLunaSuccessSnackBar(
    //             context: context,
    //             message: 'Authorization',
    //             title: 'Header Added',
    //         );
    //         setState(() {});
    //     }
    // }

    // Future<void> _showCustomPrompt(BuildContext context) async {
    //     List results = await SettingsDialogs.addCustomHeader(context);
    //     if(results[0]) {
    //         Map<String, dynamic> _headers = (widget.indexer.headers ?? {}).cast<String, dynamic>();
    //         _headers.addAll({results[1]: results[2]});
    //         widget.indexer.headers = _headers;
    //         showLunaSuccessSnackBar(
    //             context: context,
    //             message: results[1],
    //             title: 'Header Added',
    //         );
    //         setState(() {});
    //     }
    // }

    Future<void> _delete(String key) async {
        List results = await SettingsDialogs.deleteHeader(context);
        if(results[0]) {
            Map<String, dynamic> _headers = (widget.indexer.headers ?? {}).cast<String, dynamic>();
            _headers.remove(key);
            widget.indexer.headers = _headers;
            showLunaSuccessSnackBar(
                context: context,
                message: key,
                title: 'Header Deleted',
            );
            setState(() {});
        }
    }
}
