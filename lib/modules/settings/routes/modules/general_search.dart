import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search/core/database.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSearch extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/search';

    @override
    State<SettingsModulesSearch> createState() => _State();
}

class _State extends State<SettingsModulesSearch> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: ValueListenableBuilder(
            valueListenable: Database.indexersBox.listenable(),
            builder: (context, box, widget) => _body,
        ),
    );

    Widget get _appBar => LSAppBar(title: 'Search');

    Widget get _body => LSListView(
        children: <Widget>[
            ..._indexers,
            ..._customization,
        ],
    );

    List<Widget> get _indexers => [
        LSHeader(
            text: 'Newznab Indexers',
            subtitle: 'LunaSea supports all standard newznab-based indexers, including NZBHydra2',
        ),
        if(Database.indexersBox.length == 0) LSGenericMessage(text: 'No Indexers Added'),
        ..._indexerList,
        LSDivider(),
        LSButton(
            text: 'Add New Indexer',
            onTap: () async => _enterAddIndexer(),
        ),
    ];

    List<Widget> get _customization => [
        LSHeader(
            text: 'Customization',
            subtitle: 'Customize search to fit your needs',
        ),
        ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [SearchDatabaseValue.HIDE_XXX.key]),
            builder: (context, box, widget) => LSCardTile(
                title: LSTitle(text: 'Hide Adult Categories'),
                subtitle: LSSubtitle(text: 'Hide categories that contain adult content'),
                trailing: Switch(
                    value: SearchDatabaseValue.HIDE_XXX.data,
                    onChanged: (value) => SearchDatabaseValue.HIDE_XXX.put(value),
                ),
            ),
        ),
    ];

    List get _indexerList {
        List list = List.generate(Database.indexersBox.length, (index) {
            IndexerHiveObject indexer = Database.indexersBox.getAt(index);
            return LSCardTile(
                title: LSTitle(text: indexer.displayName),
                subtitle: LSSubtitle(text: indexer.host),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async => _enterEditIndexer(indexer),
            );
        });
        list.sort((a,b) => (a.title as LSTitle).text.compareTo((b.title as LSTitle).text));
        return list;
    }

    Future<void> _enterAddIndexer() async {
        final dynamic result = await Navigator.of(context).pushNamed(SettingsModulesSearchAdd.ROUTE_NAME);
        if(result != null && result[0] == 'indexer_added')
            LSSnackBar(context: context, title: 'Indexer Added', message: result[1], type: SNACKBAR_TYPE.success);
    }

    Future<void> _enterEditIndexer(IndexerHiveObject indexer) async {
        final dynamic result = await Navigator.of(context).pushNamed(
            SettingsModulesSearchEdit.ROUTE_NAME,
            arguments: SettingsModulesSearchEditArguments(indexer: indexer),
        );
        if(result != null && result[0] == 'indexer_deleted')
            LSSnackBar(context: context, title: 'Indexer Deleted', message: result[1], type: SNACKBAR_TYPE.success);
    }
}
