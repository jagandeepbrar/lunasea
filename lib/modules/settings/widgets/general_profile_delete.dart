import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsGeneralDeleteProfileTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Delete'),
        subtitle: LSSubtitle(text: 'Delete an existing profile'),
        trailing: LSIconButton(icon: Icons.delete),
        onTap: () => _deleteProfile(context),
    );

    Future<void> _deleteProfile(BuildContext context) async {
        List<dynamic> _values = await LSDialogSettings.deleteProfile(
            context,
            Database.profilesBox.keys.map((x) => x as String).toList()..sort((a,b) => a.toLowerCase().compareTo(b.toLowerCase())),
        );
        if(_values[0]) {
            if(_values[1] == Database.lunaSeaBox.get(LunaSeaDatabaseValue.ENABLED_PROFILE.key)) {
                LSSnackBar(context: context, title: 'Unable to Delete Profile', message: 'Cannot delete the enabled profile', type: SNACKBAR_TYPE.failure);
            } else {
                Database.profilesBox.delete(_values[1]);
                LSSnackBar(context: context, title: 'Deleted Profile', message: '"${_values[1]}" has been deleted', type: SNACKBAR_TYPE.success);
            }
        }
    }
}
