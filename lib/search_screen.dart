import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'features/application/volume_notifier.dart';
import 'features/domain/volume.dart';
import 'product/dimensions.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AsyncValue<Volume> volumes = ref.watch(volumeNotifierProvider);
    return Padding(
      padding: const EdgeInsets.all(Dimensions.pagePadding),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            onChanged: (value) async {
              if (value.length >= 3) {
                await ref.read(volumeNotifierProvider.notifier).getVolumes(value);
              }
            },
          ),
          const SizedBox(height: 20),
          volumes.when(
            data: (data) {
              if (controller.text.isNotEmpty) {
                return _resultList(data);
              } else {
                return const SizedBox();
              }
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const SizedBox(),
          )
        ],
      ),
    );
  }

  Expanded _resultList(Volume data) {
    return Expanded(
      child: ListView.separated(
        itemCount: data.items!.length,
        itemBuilder: (BuildContext context, int index) {
          var volume = data.items![index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: SizedBox(
                width: 50,
                height: 100,
                child: volume.volumeInfo!.imageLinks != null
                    ? Image.network(volume.volumeInfo!.imageLinks!.thumbnail!)
                    : const Icon(Icons.book),
              ),
              title: Text(volume.volumeInfo!.title.toString()),
              subtitle: Text(
                volume.volumeInfo?.authors?.first ?? "",
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
