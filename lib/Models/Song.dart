import 'dart:convert';

Song songFromJson(String str) => Song.fromJson(json.decode(str));

String songToJson(Song data) => json.encode(data.toJson());

class Song {
  Song({
    this.album,
    this.albumUrl,
    this.autoplay,
    this.duration,
    this.eSongid,
    this.hasRbt,
    this.imageUrl,
    this.label,
    this.labelUrl,
    this.language,
    this.liked,
    this.map,
    this.music,
    this.origin,
    this.originVal,
    this.page,
    this.passAlbumCtx,
    this.permaUrl,
    this.publishToFb,
    this.singers,
    this.songid,
    this.starred,
    this.starring,
    this.streamingSource,
    this.tinyUrl,
    this.title,
    this.twitterUrl,
    this.url,
    this.year,
  });

  String album;
  String albumUrl;
  String autoplay;
  String duration;
  String eSongid;
  String hasRbt;
  String imageUrl;
  String label;
  String labelUrl;
  String language;
  String liked;
  String map;
  String music;
  String origin;
  String originVal;
  int page;
  String passAlbumCtx;
  String permaUrl;
  bool publishToFb;
  String singers;
  String songid;
  String starred;
  String starring;
  dynamic streamingSource;
  String tinyUrl;
  String title;
  String twitterUrl;
  String url;
  String year;

  factory Song.fromJson(Map<String, dynamic> json) => Song(
    album: json["album"],
    albumUrl: json["album_url"],
    autoplay: json["autoplay"],
    duration: json["duration"],
    eSongid: json["e_songid"],
    hasRbt: json["has_rbt"],
    imageUrl: json["image_url"],
    label: json["label"],
    labelUrl: json["label_url"],
    language: json["language"],
    liked: json["liked"],
    map: json["map"],
    music: json["music"],
    origin: json["origin"],
    originVal: json["origin_val"],
    page: json["page"],
    passAlbumCtx: json["pass_album_ctx"],
    permaUrl: json["perma_url"],
    publishToFb: json["publish_to_fb"],
    singers: json["singers"],
    songid: json["songid"],
    starred: json["starred"],
    starring: json["starring"],
    streamingSource: json["streaming_source"],
    tinyUrl: json["tiny_url"],
    title: json["title"],
    twitterUrl: json["twitter_url"],
    url: json["url"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "album": album,
    "album_url": albumUrl,
    "autoplay": autoplay,
    "duration": duration,
    "e_songid": eSongid,
    "has_rbt": hasRbt,
    "image_url": imageUrl,
    "label": label,
    "label_url": labelUrl,
    "language": language,
    "liked": liked,
    "map": map,
    "music": music,
    "origin": origin,
    "origin_val": originVal,
    "page": page,
    "pass_album_ctx": passAlbumCtx,
    "perma_url": permaUrl,
    "publish_to_fb": publishToFb,
    "singers": singers,
    "songid": songid,
    "starred": starred,
    "starring": starring,
    "streaming_source": streamingSource,
    "tiny_url": tinyUrl,
    "title": title,
    "twitter_url": twitterUrl,
    "url": url,
    "year": year,
  };
}
