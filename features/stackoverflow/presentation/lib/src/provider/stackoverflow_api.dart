import 'package:dio/dio.dart';
import 'package:features_stackoverflow_presentation/src/data/question.dart';
import 'package:html/parser.dart';

Future<QuestionsResponse> getQuestionsResponse(int pageIndex, Dio dio, CancelToken cancelToken) async {
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
  return page;
}
