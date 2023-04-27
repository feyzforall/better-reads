// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../product/endpoints.dart';
import '../../product/utils/network_manager.dart';
import '../domain/volume.dart';

final volumeRepositoryProvider = Provider<VolumeRepository>(
  (ref) {
    return VolumeRepository(
      NetworkManager(
        Dio(),
      ),
    );
  },
);

class VolumeRepository {
  final NetworkManager networkManager;

  VolumeRepository(this.networkManager);

  Future<Volume> fetchVolumes(String query) async {
    try {
      final response = await networkManager.get(
        Endpoints.volumes,
        queryParameters: {
          "q": query,
        },
      );
      final volumes = Volume.fromJson(response.data);
      return volumes;
    } on DioError catch (_) {
      rethrow;
    }
  }
}
