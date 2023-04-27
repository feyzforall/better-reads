// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';

import '../../product/endpoints.dart';
import '../../product/utils/network_manager.dart';
import '../domain/volume.dart';

class VolumeRepository {
  final NetworkManager networkManager;

  VolumeRepository(this.networkManager);

  Future<Volume> fetchVolumes(String volume) async {
    try {
      final response = await networkManager.get(
        Endpoints.volumes,
        queryParameters: {
          "q": volume,
        },
      );
      final volumes = Volume.fromJson(response.data);
      return volumes;
    } on DioError catch (_) {
      rethrow;
    }
  }
}
