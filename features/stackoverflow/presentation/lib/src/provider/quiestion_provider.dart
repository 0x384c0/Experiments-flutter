import 'package:dio/dio.dart';
import 'package:features_stackoverflow_presentation/src/data/question.dart';
import 'package:html/parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'client_provider.dart';

part 'quiestion_provider.g.dart';

/// Can be created manually with
/// final paginatedQuestionsProvider = FutureProvider.autoDispose.family<QuestionsResponse, int>((ref, index) async {  }));
@riverpod
Future<QuestionsResponse> paginatedQuestions(PaginatedQuestionsRef ref, {required int pageIndex}) async {
  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);
  final dio = ref.watch(clientProvider);

  final uri = Uri(
    scheme: 'https',
    host: 'api.stackexchange.com',
    path: '/2.2/questions',
    queryParameters: <String, Object>{
      'order': 'desc',
      'sort': 'creation',
      'site': 'stackoverflow',
      'filter': '!17vW1m9jnXcpKOO(p4a5Jj.QeqRQmvxcbquXIXJ1fJcKq4',
      'tagged': 'flutter',
      'pagesize': '50',
      'page': '${pageIndex + 1}',
    },
  );

  final response = await dio.getUri(uri, cancelToken: cancelToken);

  final parsed = QuestionsResponse.fromJson(response.data!);
  final page = parsed.copyWith(
    items: parsed.items.map((e) {
      final document = parse(e.body);
      return e.copyWith(body: document.body!.text.replaceAll('\n', ' '));
    }).toList(),
  );

  ref.keepAlive();

  return page;
}

/// A provider exposing the total count of questions
final questionsCountProvider =
    Provider.autoDispose((ref) => ref.watch(paginatedQuestionsProvider(pageIndex: 0)).whenData((page) => page.total));

/// A scoped provider, exposing the current question used by [QuestionItem].
///
/// This is used as a performance optimization to pass a [Question] to
/// [QuestionItem], while still instantiating [QuestionItem] using the `const`
/// keyword.
///
/// This allows [QuestionItem] to rebuild less often.
/// By doing so, even when using [QuestionItem] in a [ListView], even if new
/// questions are obtained, previously rendered [QuestionItem]s won't rebuild.
///
/// This is an optional step. Since scoping is a fairly advanced mechanism,
/// it's entirely fine to simply pass the [Question] to [QuestionItem] directly.
final currentQuestion = Provider<AsyncValue<Question>>((ref) => throw UnimplementedError());
