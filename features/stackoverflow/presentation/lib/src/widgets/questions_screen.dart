import 'package:dio/dio.dart';
import 'package:features_stackoverflow_presentation/src/widgets/quiestion_item.dart';
import 'package:features_stackoverflow_presentation/src/provider/quiestion_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuestionsScreen extends HookConsumerWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => HookConsumer(
        builder: (context, ref, child) {
          final count = ref.watch(questionsCountProvider);

          return count.when(
            loading: _loadingView,
            error: _errorView,
            data: (count) => _list(count, ref),
          );
        },
      );

  Widget _list(int count, WidgetRef ref) => RefreshIndicator(
        onRefresh: () => _refresh(ref),
        child: ListView.builder(
          itemCount: count,
          itemBuilder: (context, index) {
            return ProviderScope(
              overrides: [
                currentQuestion.overrideWithValue(
                  ref
                      .watch(paginatedQuestionsProvider(pageIndex: index ~/ 50))
                      .whenData((page) => page.items[index % 50]),
                ),
              ],
              child: const QuestionItem(),
            );
          },
        ),
      );

  Widget _loadingView() => const Center(child: CircularProgressIndicator());

  Widget _errorView(Object err, StackTrace stack) {
    if (err is DioException) return Text(err.response!.data.toString());
    return Text('Error $err\n$stack');
  }

  Future<void> _refresh(WidgetRef ref) {
    ref.invalidate(paginatedQuestionsProvider(pageIndex: 0));
    return ref.read(paginatedQuestionsProvider(pageIndex: 0).future);
  }
}
