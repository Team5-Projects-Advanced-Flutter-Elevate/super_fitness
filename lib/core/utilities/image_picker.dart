import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../colors/app_colors.dart';

class ImagePickerService {
  final int maxFileSize = 1024 * 1024; // 1MB in bytes
  final int maxDimension = 1200; // Maximum width/height in pixels

  Future<File?> pickImage(ImageSource source) async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;

    try {
      // Request permissions
      if (source == ImageSource.camera) {
        final permissionStatus = await Permission.camera.request();
        if (!permissionStatus.isGranted) return null;
      } else {
        if (androidInfo.version.sdkInt <= 32) {
          final permissionStatus = await Permission.storage.request();
          if (!permissionStatus.isGranted) return null;
        } else {
          final PermissionStatus permissionStatus =
              await Permission.photos.request();
          if (!permissionStatus.isGranted) return null;
        }
      }

      final XFile? pickedFile = await ImagePicker().pickImage(
        //source: ImageSource.gallery,
        source: source,
        requestFullMetadata: false, // For privacy-safe access
      );
      debugPrint('pickedFile: ${pickedFile?.path}');
      if (pickedFile == null) return null;

      // Process the image to meet requirements
      return await _processImage(File(pickedFile.path));
    } catch (e) {
      debugPrint('Image picker error: $e');
      return null;
    }
  }

  Future<File> _processImage(File originalImage) async {
    File processedImage = originalImage;
    int quality = 85; // Start with high quality

    // Check and reduce until under size limit
    while (true) {
      final fileSize = await processedImage.length();
      if (fileSize <= maxFileSize) break;

      // Reduce quality and/or dimensions
      quality = (quality * 0.8).round(); // Reduce quality by 20%
      processedImage = await _compressAndResizeImage(
        processedImage,
        quality: quality > 30 ? quality : 30, // Never go below 30% quality
      );

      // Final check to prevent infinite loops
      if (quality <= 30 && (await processedImage.length()) > maxFileSize) {
        throw Exception('Unable to compress image below 4MB');
      }
    }

    return processedImage;
  }

  Future<File> _compressAndResizeImage(File file, {int quality = 70}) async {
    final tempDir = await getTemporaryDirectory();
    final targetPath = '${tempDir.path}/processed_${file.path.split('/').last}';

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: quality,
      minWidth: 600, // Minimum width after resize
      //minHeight: 1000, // Minimum height after resize
    );

    return File(result!.path);
  }

  Future<void> showImageSourceDialog(
    BuildContext context, {
    required Function(File) onImageSelected,
  }) async {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: AppColors.mainColorDark,
                  ),
                  title: const Text('Take Photo'),
                  onTap: () async {
                    Navigator.pop(context);
                    final image = await pickImage(ImageSource.camera);
                    if (image != null) onImageSelected(image);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    final image = await pickImage(ImageSource.gallery);
                    if (image != null) onImageSelected(image);
                  },
                ),
              ],
            ),
          ),
    );
  }
}
