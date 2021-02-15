import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesEditQualityProfileTile extends StatelessWidget {
    final List<RadarrQualityProfile> profiles;

    RadarrMoviesEditQualityProfileTile({
        Key key,
        @required this.profiles,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Quality Profile'),
            subtitle: LunaText.subtitle(text: context.watch<RadarrMoviesEditState>().qualityProfile?.name ?? Constants.TEXT_EMDASH),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                Tuple2<bool, RadarrQualityProfile> values = await RadarrDialogs().editQualityProfile(context, profiles);
                if(values.item1) context.read<RadarrMoviesEditState>().qualityProfile = values.item2;
            },
        );
    }
}
