import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/modules/lidarr.dart';
import './abstract.dart';

class CalendarLidarrData extends CalendarData {
    final Map<String, dynamic> api = Database.currentProfileObject.getLidarr();
    String albumTitle;
    int artistId;
    bool hasAllFiles;

    CalendarLidarrData({
        @required int id,
        @required String title,
        @required this.albumTitle,
        @required this.artistId,
        @required this.hasAllFiles,
    }) : super(id, title);

    String get bannerURI {
        return api['enabled']
            ? '${api['host']}/api/v1/MediaCover/Artist/$artistId/banner.jpg?apikey=${api['key']}'
            : '';
    }

    TextSpan get subtitle => TextSpan(
        style: TextStyle(
            color: Colors.white70,
            fontSize: 14.0,
        ),
        children: <TextSpan>[
            TextSpan(
                text: albumTitle,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                ),
            ),
            if(!hasAllFiles) TextSpan(
                text: '\nNot Downloaded',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                ),
            ),
            if(hasAllFiles) TextSpan(
                text: '\nDownloaded',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: LSColors.accent,
                ),
            )
        ],
    );

    Future<void> enterContent(BuildContext context) async => Navigator.of(context).pushNamed(
        LidarrDetailsArtist.ROUTE_NAME,
        arguments: LidarrDetailsArtistArguments(
            artistID: artistId,
            data: null,
        ),
    );

    IconButton get trailing => IconButton(
        icon: Elements.getIcon(Icons.arrow_forward_ios),
        onPressed: null,
    );
}