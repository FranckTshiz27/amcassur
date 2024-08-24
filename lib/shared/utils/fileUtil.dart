import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path_provider/path_provider.dart';

class FileUtil {
  /*
   * * Récupère le repertoire courant selon que vous êtes sur Android ou IOS
   */
  static Future<Directory?> getDirectory() async {
    return Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory(); //FOR IOS
  }

  /*
   * * Transforme une liste de type XFile en une liste de type File
   */
  static List<File> xfileToFile(List<XFile> xFiles) {
    List<File> files = [];
    for (XFile xFile in xFiles) {
      File file = File(xFile.path);
      files.add(file);
    }
    return files;
  }

  /*
   * * Transforme une liste de type File en une liste de type XFile
   */
  static List<XFile> fileToXFile(List<File> files) {
    List<XFile> xfiles = [];
    for (File file in files) {
      XFile xFile = XFile(file.path);
      xfiles.add(xFile);
    }
    return xfiles;
  }

  /*
   * * Compresse une liste de type File
   */
  static Future<List<File>> compressImages(List<File> files) async {
    List<File> cfiles = [];
    for (File file in files) {
      XFile? cxfile = await compressImage(file);
      if (cxfile != null) {
        File cFile = File(cxfile.path);
        cfiles.add(cFile);
      }
    }
    return cfiles;
  }

  /*
   * * Compresse un fichier de type File
   */
  static Future<XFile?> compressImage(File file) async {
    String newPath = file.path;
    if (newPath.endsWith('.jpg') || newPath.endsWith('.jpeg')) {
      String name = file.path.split('/').last;
      Directory? directory = await getDirectory();
      if (directory != null) {
        String path = directory.path;
        XFile? cxfile = await FlutterImageCompress.compressAndGetFile(
          file.path,
          '$path/$name',
          quality: 10,
        );
        return cxfile;
      }
    } else
      return XFile(newPath);

    return null;
  }

  /*
   * * Récuperer l'extention d'un fichier
   */
  static String getFileExtension(String filePath) {
    return filePath.split('.').last;
  }

  /*
   * * Récuperer le nom d'un fichier
   */
  static String getFileName(String filePath) {
    return filePath.split('/').last;
  }

  /*
   * * Compresse un fichier de type File
   */
  static Future<XFile?> compressImageXFile(XFile file) async {
    String newPath = file.path;
    if (newPath.endsWith('.jpg') || newPath.endsWith('.jpeg')) {
      String name = file.path.split('/').last;
      Directory? directory = await getDirectory();
      if (directory != null) {
        String path = directory.path;
        XFile? cxfile = await FlutterImageCompress.compressAndGetFile(
          file.path,
          '$path/$name',
          quality: 25,
        );
        return cxfile;
      }
    } else
      return file;

    return null;
  }

  static String? xFileToBase64(XFile? xFile) {
    if (xFile != null) {
      Uint8List bytes = File(xFile.path).readAsBytesSync();
      return base64Encode(bytes);
    }
    return null;
  }

  static Future<String?> convertXFileToBase64(XFile file) async {
    try {
      // Lire le fichier comme un tableau de bytes
      List<int> imageBytes = await file.readAsBytes();

      // Convertir le tableau de bytes en une chaîne de base64
      String base64String = base64Encode(Uint8List.fromList(imageBytes));

      return base64String;
    } catch (e) {
      print("Erreur lors de la conversion en base64 : $e");
      return null;
    }
  }

  static Future<File> getFileFromPlatformFile(PlatformFile platformFile) async {
    // Récupérer le chemin d'accès au fichier depuis l'objet PlatformFile
    String filePath = platformFile.path!;

    // Créer un objet File à partir du chemin d'accès
    File file = File(filePath);

    // Retourner le fichier
    return file;
  }

  Future<XFile> convertPlatformFileToXFile(PlatformFile platformFile) async {
    // Créez un XFile à partir de l'URI du fichier
    return XFile(platformFile.path!);
  }

  static Future<XFile> base64ToXFile(
      {required String base64String, String? extention = 'png'}) async {
    // Decode the base64 string into bytes
    final bytes = base64.decode(base64String);

    // Get the temporary directory
    final tempDir = await getTemporaryDirectory();

    // Create a temporary file with a unique name
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File('${tempDir.path}/file${timestamp}.$extention');

    // Write the bytes to the file
    await file.writeAsBytes(bytes);

    // Return an XFile instance
    return XFile(file.path);
  }
}
