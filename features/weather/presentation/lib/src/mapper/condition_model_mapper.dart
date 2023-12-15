import 'package:common_domain/mapper/mapper.dart';
import 'package:features_weather_domain/data/weather_model.dart';
import '../data/weather_state.dart';

class ConditionModelMapper extends Mapper<ConditionModel?, ConditionState> {
  @override
  ConditionState map(ConditionModel? input) => ConditionState(
        input?.text ?? "",
        input?.icon?.replaceAll("//", "https://") ?? "",
      );
}
