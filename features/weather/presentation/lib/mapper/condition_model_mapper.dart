import 'package:common_presentation/data/mapper.dart';
import 'package:features_weather_domain/data/weather_model.dart';
import 'package:features_weather_presentation/data/weather_state.dart';

class ConditionModelMapper extends Mapper<ConditionModel?, ConditionState> {
  @override
  ConditionState map(ConditionModel? input) => ConditionState(
        input?.text ?? "",
        input?.icon?.replaceAll("//", "https://") ?? "",
      );
}
