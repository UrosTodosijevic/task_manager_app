import 'package:flutter/foundation.dart';

enum RepeatOption {
  never,
  daily,
  weekly,
  monthly,
  yearly,
  customize,
}

enum RepeatDuration {
  forever,
  until,
  repetitions,
}

class RepeatDurationWithName {
  final RepeatDuration repeatDuration;
  final String name;

  const RepeatDurationWithName(
    this.repeatDuration,
    this.name,
  );
}

const RepeatDurationWithName repeatForever =
    RepeatDurationWithName(RepeatDuration.forever, 'Forever');
const RepeatDurationWithName repeatUntil =
    RepeatDurationWithName(RepeatDuration.until, 'Until');
const RepeatDurationWithName repeatRepetitions =
    RepeatDurationWithName(RepeatDuration.repetitions, 'Repetitions');

const List<RepeatDurationWithName> listOfRepeatDurations = const [
  repeatForever,
  repeatUntil,
  repeatRepetitions
];

// TODO: izbaciti ovo i napraviti bolje resenje
class Repeat {
  final RepeatOption repeatOption;
  final String name;

  const Repeat(this.repeatOption, this.name);
}

List<Map<String, RepeatOption>> listOfRepeatOptions = [
  {'Never': RepeatOption.never},
  {'Daily': RepeatOption.daily},
  {'Weekly': RepeatOption.weekly},
  {'Monthly': RepeatOption.monthly},
  {'Yearly': RepeatOption.yearly},
  {'Customize': RepeatOption.never},
];
