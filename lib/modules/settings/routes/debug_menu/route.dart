import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsDebugMenuRouter extends SettingsPageRouter {
  SettingsDebugMenuRouter() : super('/settings/debugmenu');

  @override
  Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return LunaAppBar(
      title: 'Debug Menu',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaBlock(
          title: 'Clear Alerts Box',
          onTap: () async {
            await Database.alerts.clear();
            showLunaSuccessSnackBar(
              title: 'Cleared',
              message: 'Cleared Alerts Box',
            );
          },
        ),
        const LunaHeader(text: 'Toasts'),
        LunaBlock(
          title: 'Info',
          onTap: () async => showLunaInfoSnackBar(
            title: 'Info',
            message: _E1().nested?.nested.lunaSafeTest(),
          ),
        ),
        LunaBlock(
          title: 'Success',
          onTap: () async => showLunaSuccessSnackBar(
            title: 'Success',
            message: null,
          ),
        ),
        LunaBlock(
          title: 'Error',
          onTap: () async => showLunaErrorSnackBar(
            title: 'Error',
            message: null,
          ),
        ),
      ],
    );
  }
}

class _E1 {
  final _E2? nested;

  _E1({
    this.nested,
  });
}

class _E2 {
  final String? nested;

  _E2({
    this.nested,
  });
}
