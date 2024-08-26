import 'dart:async';

import 'package:features_stackoverflow_presentation/src/data/question.dart';
import 'package:features_stackoverflow_presentation/src/provider/quiestion_provider.dart';
import 'package:features_stackoverflow_presentation/src/data/user.dart';
import 'package:features_stackoverflow_presentation/src/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A UI widget rendering a [Question].
///
/// That question will be obtained through [currentQuestion]. As such, it is
/// necessary to override that provider before using [QuestionItem].
class QuestionItem extends HookConsumerWidget {
  const QuestionItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final question = ref.watch(currentQuestion);

    return question.when(
      error: (error, stack) => const Center(child: Text('Error')),
      loading: () => const Center(child: Text('loading')),
      data: (question) {
        return ListTile(
          title: Text(question.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                question.body,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: PostInfo(
                          originalPoster: question.owner,
                          postCreationDate: question.creationDate,
                        ),
                      ),
                      UpvoteCount(question.score),
                      const SizedBox(width: 10),
                      AnswersCount(
                        question.answerCount,
                        accepted: question.acceptedAnswerId != null,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

/// A "hook" (see flutter_hooks) for rendering how far a [DateTime] is from now
/// ("5 seconds ago", ...).
///
/// This hook also takes care of refreshing the UI when the label changes.
/// More particularly, it will check every minute if the label has changed.
String _useAskedHowLongAgo(DateTime creationDate) {
  final label = useState('');

  useEffect(
    () {
      void setLabel() {
        final now = DateTime.now();
        final diff = now.difference(creationDate);

        String value;
        if (diff.inDays > 1) {
          value = '${diff.inDays} days';
        } else if (diff.inHours > 0) {
          value = '${diff.inHours} hours';
        } else if (diff.inMinutes > 0) {
          value = '${diff.inMinutes} mins';
        } else {
          value = '${diff.inSeconds} seconds';
        }

        label.value = 'asked $value ago';
      }

      setLabel();
      final timer = Timer.periodic(const Duration(minutes: 1), (_) => setLabel());

      return timer.cancel;
    },
    [creationDate],
  );

  return label.value;
}

class PostInfo extends HookConsumerWidget {
  const PostInfo({
    super.key,
    required this.originalPoster,
    required this.postCreationDate,
  });

  final User originalPoster;
  final DateTime postCreationDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final askedHowLongAgoLabel = _useAskedHowLongAgo(postCreationDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          askedHowLongAgoLabel,
          style: const TextStyle(color: Color(0xFF9fa6ad), fontSize: 12),
        ),
        const SizedBox(height: 3),
        UserAvatar(owner: originalPoster),
      ],
    );
  }
}

/// A UI component for showing the answer count on a question
class AnswersCount extends StatelessWidget {
  const AnswersCount(
    this.answerCount, {
    super.key,
    required this.accepted,
  });

  final int answerCount;
  final bool accepted;

  @override
  Widget build(BuildContext context) {
    final textStyle = accepted
        ? null
        : answerCount == 0
            ? const TextStyle(color: Color(0xffacb2b8))
            : const TextStyle(color: Color(0xff5a9e6f));
    return Container(
      decoration: answerCount > 0
          ? BoxDecoration(
              color: accepted ? const Color(0xff5a9e6f) : null,
              border: Border.all(color: const Color(0xff5a9e6f)),
              borderRadius: BorderRadius.circular(3),
            )
          : null,
      padding: const EdgeInsets.all(7),
      child: Column(
        children: [
          Text(answerCount.toString(), style: textStyle),
          Text('answers', style: textStyle),
        ],
      ),
    );
  }
}

/// A UI component for showing the upvotes count on a question
class UpvoteCount extends StatelessWidget {
  const UpvoteCount(this.upvoteCount, {super.key});

  final int upvoteCount;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Color(0xffacb2b8));

    return Padding(
      padding: const EdgeInsets.all(7),
      child: Column(
        children: [
          Text(upvoteCount.toString(), style: textStyle),
          const Text('votes', style: textStyle),
        ],
      ),
    );
  }
}
