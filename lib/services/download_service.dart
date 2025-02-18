import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'init_depedencies.dart';

class DownloadService {
  bool downloading = false;
  bool isDownloaded = false;
  int idPathUrl = 0;

  final Dio _dio = Dio();

  void onReceiveProgress(int received, int total) async {
    if (total != -1) {
      await InitDepedencies().cancelAllNotification();
      await InitDepedencies().showNotification(
        "Sedang Mengunduh",
        "${((received / total * 100) + 1).toStringAsFixed(0)} dari 100",
      );

      if (int.parse((received / total * 100).toStringAsFixed(0)) >= 99) {
        isDownloaded = true;
      }
    }
  }

  Future<void> startDownload(String url, String _path, String savePath) async {
    _dio.interceptors..add(LogInterceptor());
    final response = await _dio.download(
      url,
      savePath,
      options: Options(
        responseType: ResponseType.json,
        followRedirects: false,
        headers: {
          HttpHeaders.acceptEncodingHeader: "*",
          // "authorization": "${await SharedPref.getAccessToken()}",
        },
        validateStatus: (status) {
          return status! < 500;
        },
      ),
      onReceiveProgress: onReceiveProgress,
    );

    if (response.statusCode == 200) {
      // File file = File(savePath);
      // var raf = file.openSync(mode: FileMode.append);
      // raf.writeFromSync(response.data);
      // // raf.writeStringSync(response.data);
      // await raf.close();
      await InitDepedencies().cancelAllNotification();
      await InitDepedencies().showNotification(
        "Berhasil mengunduh",
        "Silahkan cek di dokumen Anda",
        message: {
          "type": "open",
          "file": savePath,
        },
      );
    } else {
      await InitDepedencies().cancelAllNotification();
      await InitDepedencies().showNotification(
        "Gagal Mengunduh",
        "Coba lagi nanti",
      );
    }
  }

  Future<void> download(String url, String name, String subFolder) async {
    final _path = await InitDepedencies().createFolder(subFolder);
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
    if (info.version.sdkInt >= 33) {
      final savePath = path.join(_path, name);

      await startDownload(url, _path, savePath);
    } else {
      final isPermissionStatusGranted =
          await InitDepedencies().requestPermissions();

      if (isPermissionStatusGranted) {
        final savePath = path.join(_path, name);

        await startDownload(url, _path, savePath);
      }
    }
  }
}
