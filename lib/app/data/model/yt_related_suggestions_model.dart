class YouTubeSearchResponse {
  final String? kind;
  final String? nextPageToken;
  final PageInfo? pageInfo;
  final List<VideoItem>? items;

  YouTubeSearchResponse({
    this.kind,
    this.nextPageToken,
    this.pageInfo,
    this.items,
  });

  factory YouTubeSearchResponse.fromJson(Map<String, dynamic> json) {
    final pageInfoJson = json['pageInfo'] as Map<String, dynamic>;
    final itemsJson = json['items'] as List<dynamic>;
    final items = itemsJson.map((item) => VideoItem.fromJson(item)).toList();

    return YouTubeSearchResponse(
      kind: json['kind'] as String,
      nextPageToken: json['nextPageToken'] as String,
      pageInfo: PageInfo.fromJson(pageInfoJson),
      items: items,
    );
  }
}

class PageInfo {
  final int totalResults;
  final int resultsPerPage;

  PageInfo({
    required this.totalResults,
    required this.resultsPerPage,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
      totalResults: json['totalResults'] as int,
      resultsPerPage: json['resultsPerPage'] as int,
    );
  }
}

class VideoItem {
  final String kind;
  final VideoId id;
  final VideoSnippet snippet;

  VideoItem({
    required this.kind,
    required this.id,
    required this.snippet,
  });

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    final idJson = json['id'] as Map<String, dynamic>;
    final snippetJson = json['snippet'] as Map<String, dynamic>;

    return VideoItem(
      kind: json['kind'] as String,
      id: VideoId.fromJson(idJson),
      snippet: VideoSnippet.fromJson(snippetJson),
    );
  }
}

class VideoId {
  final String kind;
  final String videoId;

  VideoId({
    required this.kind,
    required this.videoId,
  });

  factory VideoId.fromJson(Map<String, dynamic> json) {
    return VideoId(
      kind: json['kind'] as String,
      videoId: json['videoId'] as String,
    );
  }
}

class VideoSnippet {
  final String publishedAt;
  final String channelId;
  final String title;
  final String description;
  final Thumbnail? thumbnails;
  final String? channelTitle;

  VideoSnippet({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.thumbnails,
    required this.channelTitle,
  });

  factory VideoSnippet.fromJson(Map<String, dynamic> json) {
    final thumbnailsJson = json['thumbnails'] as Map<String, dynamic>;

    return VideoSnippet(
      publishedAt: json['publishedAt'] as String,
      channelId: json['channelId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      thumbnails: Thumbnail.fromJson(thumbnailsJson),
      channelTitle: json['channelTitle'] as String,
    );
  }
}
class Thumbnail {
  Thumbnail({
    required this.defaultThumbnail,
    required this.mediumThumbnail,
    required this.highThumbnail,
    required this.standardThumbnail,
    required this.maxresThumbnail,
  });

  final ThumbnailData defaultThumbnail;
  final ThumbnailData mediumThumbnail;
  final ThumbnailData highThumbnail;
  final ThumbnailData standardThumbnail;
  final ThumbnailData maxresThumbnail;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        defaultThumbnail:
            ThumbnailData.fromJson(json['default'] ?? <String, dynamic>{}),
        mediumThumbnail:
            ThumbnailData.fromJson(json['medium'] ?? <String, dynamic>{}),
        highThumbnail:
            ThumbnailData.fromJson(json['high'] ?? <String, dynamic>{}),
        standardThumbnail:
            ThumbnailData.fromJson(json['standard'] ?? <String, dynamic>{}),
        maxresThumbnail:
            ThumbnailData.fromJson(json['maxres'] ?? <String, dynamic>{}),
      );

  Map<String, dynamic> toJson() => {
        'default': defaultThumbnail.toJson(),
        'medium': mediumThumbnail.toJson(),
        'high': highThumbnail.toJson(),
        'standard': standardThumbnail.toJson(),
        'maxres': maxresThumbnail.toJson(),
      };
}

class ThumbnailData {
  ThumbnailData({
    required this.url,
    required this.width,
    required this.height,
  });

  final String url;
  final int width;
  final int height;

  factory ThumbnailData.fromJson(Map<String, dynamic> json) => ThumbnailData(
        url: json['url'] ?? '',
        width: json['width'] ?? 0,
        height: json['height'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'width': width,
        'height': height,
      };
}
