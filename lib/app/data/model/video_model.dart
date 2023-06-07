class VideoItem {
  final String title;
  final String image;
  final String trailerUrl;
  final String artist;
  final String videoId;

  VideoItem({
    required this.title,
    required this.image,
    required this.trailerUrl,
    required this.artist,
    required this.videoId,
  });

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(
      title: json['title'],
      image: json['image'],
      trailerUrl: json['trailer_url'],
      artist: json['artist'],
      videoId: json['videoId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'trailer_url': trailerUrl,
      'artist': artist,
      'videoId': videoId,
    };
  }
}

class VideoList {
  final List<VideoItem> items;

  VideoList({
    required this.items,
  });

  factory VideoList.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'] as List<dynamic>;
    final items = itemsJson.map((itemJson) => VideoItem.fromJson(itemJson)).toList();

    return VideoList(items: items);
  }

  Map<String, dynamic> toJson() {
    final itemsJson = items.map((item) => item.toJson()).toList();

    return {
      'items': itemsJson,
    };
  }
}
