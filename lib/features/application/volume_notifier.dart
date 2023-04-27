import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

import '../data/volume_repository.dart';
import '../domain/volume.dart';

final StateNotifierProvider<VolumeNotifier, AsyncValue<Volume>> volumeNotifierProvider =
    StateNotifierProvider<VolumeNotifier, AsyncValue<Volume>>(
  (ref) {
    return VolumeNotifier(
      ref.watch(volumeRepositoryProvider),
    );
  },
);

class VolumeNotifier extends StateNotifier<AsyncValue<Volume>> {
  VolumeNotifier(this.volumeRepository) : super(const AsyncValue.loading());

  final VolumeRepository volumeRepository;

  Future<void> getVolumes(String query) async {
    try {
      final response = await volumeRepository.fetchVolumes(query);
      state = AsyncValue.data(response);
    } on DioError catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }
}
