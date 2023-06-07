class RankTracks {
  bool? status;
  String? type;
  String? id;
  String? title;
  String? description;
  String? date;
  List<Tracks>? tracks;

  RankTracks(
      {this.status,
      this.type,
      this.id,
      this.title,
      this.description,
      this.date,
      this.tracks});

  RankTracks.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    if (json['tracks'] != null) {
      tracks = <Tracks>[];
      json['tracks'].forEach((v) {
        tracks!.add(new Tracks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;
    if (this.tracks != null) {
      data['tracks'] = this.tracks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tracks {
  String? type;
  String? id;
  String? name;
  String? shareUrl;
  List<Artists>? artists;
  Album? album;
  ChartData? chartData;

  Tracks(
      {this.type,
      this.id,
      this.name,
      this.shareUrl,
      this.artists,
      this.album,
      this.chartData});

  Tracks.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    name = json['name'];
    shareUrl = json['shareUrl'];
    if (json['artists'] != null) {
      artists = <Artists>[];
      json['artists'].forEach((v) {
        artists!.add(new Artists.fromJson(v));
      });
    }
    album = json['album'] != null ? new Album.fromJson(json['album']) : null;
    chartData = json['chartData'] != null
        ? new ChartData.fromJson(json['chartData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['name'] = this.name;
    data['shareUrl'] = this.shareUrl;
    if (this.artists != null) {
      data['artists'] = this.artists!.map((v) => v.toJson()).toList();
    }
    if (this.album != null) {
      data['album'] = this.album!.toJson();
    }
    if (this.chartData != null) {
      data['chartData'] = this.chartData!.toJson();
    }
    return data;
  }
}

class Artists {
  String? type;
  String? id;
  String? name;
  String? shareUrl;

  Artists({this.type, this.id, this.name, this.shareUrl});

  Artists.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    name = json['name'];
    shareUrl = json['shareUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['name'] = this.name;
    data['shareUrl'] = this.shareUrl;
    return data;
  }
}

class Album {
  String? type;
  String? label;
  String? date;
  List<Cover>? cover;

  Album({this.type, this.label, this.date, this.cover});

  Album.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    label = json['label'];
    date = json['date'];
    if (json['cover'] != null) {
      cover = <Cover>[];
      json['cover'].forEach((v) {
        cover!.add(new Cover.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['label'] = this.label;
    data['date'] = this.date;
    if (this.cover != null) {
      data['cover'] = this.cover!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cover {
  String? url;
  int? width;
  int? height;

  Cover({this.url, this.width, this.height});

  Cover.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class ChartData {
  int? currentRank;
  int? previousRank;
  int? peakRank;
  String? peakDate;
  int? entryRank;
  String? entryDate;
  int? appearancesOnChart;
  int? consecutiveAppearancesOnChart;

  ChartData(
      {this.currentRank,
      this.previousRank,
      this.peakRank,
      this.peakDate,
      this.entryRank,
      this.entryDate,
      this.appearancesOnChart,
      this.consecutiveAppearancesOnChart});

  ChartData.fromJson(Map<String, dynamic> json) {
    currentRank = json['currentRank'];
    previousRank = json['previousRank'];
    peakRank = json['peakRank'];
    peakDate = json['peakDate'];
    entryRank = json['entryRank'];
    entryDate = json['entryDate'];
    appearancesOnChart = json['appearancesOnChart'];
    consecutiveAppearancesOnChart = json['consecutiveAppearancesOnChart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentRank'] = this.currentRank;
    data['previousRank'] = this.previousRank;
    data['peakRank'] = this.peakRank;
    data['peakDate'] = this.peakDate;
    data['entryRank'] = this.entryRank;
    data['entryDate'] = this.entryDate;
    data['appearancesOnChart'] = this.appearancesOnChart;
    data['consecutiveAppearancesOnChart'] = this.consecutiveAppearancesOnChart;
    return data;
  }
}
