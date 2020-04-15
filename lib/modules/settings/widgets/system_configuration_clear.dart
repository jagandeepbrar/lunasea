import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsSystemClearConfigurationTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Clean Slate'),
        subtitle: LSSubtitle(text: 'Clear your configuration'),
        trailing: LSIconButton(icon: Icons.delete_sweep),
        onTap: () => _clear(context),
    );

    Future<void> _clear(BuildContext context) async {
        List values = await LSDialogSystem.showClearConfigurationPrompt(context);
        if(values[0]) {
            Database.setDefaults();
            LSSnackBar(
                context: context,
                title: 'Configuration Cleared',
                message: 'Your configuration has been cleared',
                type: SNACKBAR_TYPE.success,
            );
        }
    }
}
