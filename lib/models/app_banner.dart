class AppBanner {
  String? imageUrl;
  String? linkUrl;

  AppBanner({
    this.imageUrl,
    this.linkUrl,
  });

  factory AppBanner.fromJson(Map<String, dynamic> json) => AppBanner(
        imageUrl: json["image_url"] ?? '',
        linkUrl: json["link_url"] ?? '',
      );

  static List<AppBanner> fromJsonList(List jsonList) =>
      jsonList.map((item) => AppBanner.fromJson(item)).toList();

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "link_url": linkUrl,
      };
}
