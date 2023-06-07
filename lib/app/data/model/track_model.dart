class TrackDetails {
  final String? externalId;
  final String? previewUrl;
  final String? name;
  final List<String>? artistNames;
  final String? albumName;
  final String? imageUrl;
  final String? isrc;
  final double? duration;
  final String? url;

  TrackDetails({
    this.externalId,
    this.previewUrl,
    this.name,
    this.artistNames,
    this.albumName,
    this.imageUrl,
    this.isrc,
    this.duration,
    this.url,
  });

  factory TrackDetails.fromJson(Map<String, dynamic> json) {
    return TrackDetails(
      externalId: json['externalId'],
      previewUrl: json['previewUrl'],
      name: json['name'],
      artistNames: json['artistNames'] is List
          ? (json['artistNames'] as List).cast<String>()
          : null,
      albumName: json['albumName'],
      imageUrl: json['imageUrl'],
      isrc: json['isrc'],
      duration: json['duration']?.toDouble(),
      url: json['url'],
    );
  }
}
