part of '../colors.dart';

abstract class AccentColors {
  const AccentColors();

  Color get blue;
  Color get purple;
  Color get yellow;
  Color get yellowLight;
}

class _LightAccentColors extends AccentColors {
  const _LightAccentColors();

  @override
  Color get blue => _Primitive.accentBlue;

  @override
  Color get purple => _Primitive.accentPurple;

  @override
  Color get yellow => _Primitive.accentYellow;

  @override
  Color get yellowLight => _Primitive.accentYellowLight;
}

class _DarkAccentColors extends AccentColors {
  const _DarkAccentColors();

  @override
  Color get blue => _Primitive.accentBlue;

  @override
  Color get purple => _Primitive.accentPurple;

  @override
  Color get yellow => _Primitive.accentYellow;

  @override
  Color get yellowLight => _Primitive.accentYellowLight;
}
