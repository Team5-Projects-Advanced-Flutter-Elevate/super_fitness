abstract class YoutubeVideoThumbnail {
  static String getYouTubeVideoId(String url) {
    Uri uri = Uri.parse(url);
    if (uri.host == 'youtu.be') {
      return uri.pathSegments.first;
    } else if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'] ?? '';
    }
    return '';
  }

  static String getYouTubeThumbnail(String url) {
    final videoId = getYouTubeVideoId(url);
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }
}
