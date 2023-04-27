import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'features/application/volume_notifier.dart';
import 'features/domain/volume.dart';

class VolumeScreen extends ConsumerStatefulWidget {
  const VolumeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VolumeScreenState();
}

class _VolumeScreenState extends ConsumerState<VolumeScreen> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AsyncValue<Volume> volumes = ref.watch(volumeNotifierProvider);
    return Column(
      children: [
        TextFormField(
          controller: controller,
          // onChanged: (value) async => await ref.read(volumeNotifierProvider.notifier).getVolumes(value),
          onEditingComplete: () async => await ref.read(volumeNotifierProvider.notifier).getVolumes(controller.text),
          decoration: InputDecoration(
            suffix: IconButton(
              onPressed: () async {
                await ref.read(volumeNotifierProvider.notifier).getVolumes(controller.text);
              },
              icon: Icon(Icons.search),
            ),
          ),
        ),
        volumes.when(
          data: (data) {
            return Expanded(
              child: ListView.builder(
                itemCount: data.items?.length,
                itemBuilder: (BuildContext context, int index) {
                  var volume = data.items![index];
                  return ListTile(
                    title: Text(volume.id.toString()),
                  );
                },
              ),
            );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => CircularProgressIndicator(),
        )
      ],
    );
  }
}
