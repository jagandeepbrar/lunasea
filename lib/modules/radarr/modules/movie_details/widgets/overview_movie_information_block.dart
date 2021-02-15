import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsOverviewInformationBlock extends StatelessWidget {
    final RadarrMovie movie;
    final RadarrQualityProfile qualityProfile;
    final List<RadarrTag> tags;

    RadarrMovieDetailsOverviewInformationBlock({
        Key key,
        @required this.movie,
        @required this.qualityProfile,
        @required this.tags,
    }): super(key: key);

    @override
    Widget build(BuildContext context) => LunaTableCard(
        content: [
            LunaTableContent(title: 'path', body: movie?.path),
            LunaTableContent(title: 'quality', body: qualityProfile?.name),
            LunaTableContent(title: 'availability', body: movie?.lunaMinimumAvailability),
            LunaTableContent(title: 'status', body: movie?.status?.readable ?? Constants.TEXT_EMDASH),
            LunaTableContent(title: 'tags', body: movie?.lunaTags(tags) ?? Constants.TEXT_EMDASH),
            LunaTableContent(title: '', body: ''),
            LunaTableContent(title: 'in cinemas', body: movie?.lunaInCinemasOn),
            LunaTableContent(title: 'digital', body: movie?.lunaDigitalReleaseDate),
            LunaTableContent(title: 'physical', body: movie?.lunaPhysicalReleaseDate),
            LunaTableContent(title: 'added on', body: movie?.lunaDateAdded),
            LunaTableContent(title: '', body: ''),
            LunaTableContent(title: 'year', body: movie?.lunaYear),
            LunaTableContent(title: 'studio', body: movie?.lunaStudio),
            LunaTableContent(title: 'runtime', body: movie?.lunaRuntime),
            LunaTableContent(title: 'rating', body: movie?.certification ?? Constants.TEXT_EMDASH),
            LunaTableContent(title: 'genres', body: movie?.lunaGenres),
            LunaTableContent(title: 'alternate titles', body: movie?.lunaAlternateTitles),
        ],
    );
}
