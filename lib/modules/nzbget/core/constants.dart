import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class NZBGetConstants {
    NZBGetConstants._();

    static const _HELP_MESSAGE = '';
    static const MODULE_KEY = 'nzbget';

    static const LunaModuleMap MODULE_MAP = LunaModuleMap(
        name: 'NZBGet',
        description: 'Manage Usenet Downloads',
        settingsDescription: 'Configure NZBGet',
        helpMessage: _HELP_MESSAGE,
        icon: CustomIcons.nzbget,
        route: '/nzbget',
        color: Color(0xFF42D535),
        website: 'https://nzbget.net',
        github: 'https://github.com/nzbget/nzbget',
    );

    //ignore: non_constant_identifier_names
    static final ShortcutItem MODULE_QUICK_ACTION = ShortcutItem(
        type: MODULE_KEY,
        localizedTitle: MODULE_MAP.name,
    );
}
