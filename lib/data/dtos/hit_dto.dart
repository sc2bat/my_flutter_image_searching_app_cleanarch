class HitDTO {
  final int id;
  final String pageURL;
  final String type;
  final String tags;
  final String previewURL;
  final int previewWidth;
  final int previewHeight;
  final String webformatURL;
  final int webformatWidth;
  final int webformatHeight;
  final String largeImageURL;
  final String fullHDURL;
  final String imageURL;
  final int imageWidth;
  final int imageHeight;
  final int imageSize;
  final int views;
  final int downloads;
  final int likes;
  final int comments;
  final int userId;
  final String user;
  final String userImageURL;

  HitDTO({
    required this.id,
    required this.pageURL,
    required this.type,
    required this.tags,
    required this.previewURL,
    required this.previewWidth,
    required this.previewHeight,
    required this.webformatURL,
    required this.webformatWidth,
    required this.webformatHeight,
    required this.largeImageURL,
    required this.fullHDURL,
    required this.imageURL,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageSize,
    required this.views,
    required this.downloads,
    required this.likes,
    required this.comments,
    required this.userId,
    required this.user,
    required this.userImageURL,
  });

  factory HitDTO.fromJson(Map<String, dynamic> json) {
    return HitDTO(
      id: json['id'] ?? 0,
      pageURL: json['pageURL'] ?? '',
      type: json['type'] ?? '',
      tags: json['tags'] ?? '',
      previewURL: json['previewURL'] ?? '',
      previewWidth: json['previewWidth'] ?? 0,
      previewHeight: json['previewHeight'] ?? 0,
      webformatURL: json['webformatURL'] ?? '',
      webformatWidth: json['webformatWidth'] ?? 0,
      webformatHeight: json['webformatHeight'] ?? 0,
      largeImageURL: json['largeImageURL'] ?? '',
      fullHDURL: json['fullHDURL'] ?? '',
      imageURL: json['imageURL'] ?? '',
      imageWidth: json['imageWidth'] ?? 0,
      imageHeight: json['imageHeight'] ?? 0,
      imageSize: json['imageSize'] ?? 0,
      views: json['views'] ?? 0,
      downloads: json['downloads'] ?? 0,
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      userId: json['user_id'] ?? 0,
      user: json['user'] ?? '',
      userImageURL: json['userImageURL'] ?? '',
    );
  }
}
