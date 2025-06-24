import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

abstract class ThumbnailVideoProvider {
  static Future<String?> getVideoThumbnail(
    String videoUrl,
    String videoId,
  ) async {
    final tempDir = await getTemporaryDirectory();
    final thumbPath = '${tempDir.path}/thumb_$videoId.png';
    final fileName = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: thumbPath,
      imageFormat: ImageFormat.PNG,
      maxHeight: 80,
      // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      maxWidth: 80,
      quality: 75,
    );
    return fileName;
  }
}
