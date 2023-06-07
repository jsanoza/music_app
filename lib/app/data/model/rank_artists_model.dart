class RankArtists {
  bool? status;
  String? type;
  String? id;
  String? title;
  String? description;
  String? date;
  List<Artists>? artists;

  RankArtists(
      {this.status,
      this.type,
      this.id,
      this.title,
      this.description,
      this.date,
      this.artists});

  RankArtists.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    if (json['artists'] != null) {
      artists = <Artists>[];
      json['artists'].forEach((v) {
        artists!.add(new Artists.fromJson(v));
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
    if (this.artists != null) {
      data['artists'] = this.artists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Artists {
  String? type;
  String? id;
  String? name;
  String? shareUrl;
  Visuals? visuals;
  ChartData? chartData;

  Artists({this.type, this.id, this.shareUrl, this.visuals, this.chartData});

  Artists.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    name = json['name'];
    shareUrl = json['shareUrl'];
    visuals =
        json['visuals'] != null ? new Visuals.fromJson(json['visuals']) : null;
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
    if (this.visuals != null) {
      data['visuals'] = this.visuals!.toJson();
    }
    if (this.chartData != null) {
      data['chartData'] = this.chartData!.toJson();
    }
    return data;
  }
}

class Visuals {
  List<Avatar>? avatar;

  Visuals({this.avatar});

  Visuals.fromJson(Map<String, dynamic> json) {
    if (json['avatar'] != null) {
      avatar = <Avatar>[];
      json['avatar'].forEach((v) {
        avatar!.add(new Avatar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.avatar != null) {
      data['avatar'] = this.avatar!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Avatar {
  String? url;
  int? width;
  int? height;

  Avatar({this.url, this.width, this.height});

  Avatar.fromJson(Map<String, dynamic> json) {
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
