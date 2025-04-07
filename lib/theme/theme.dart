import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb2c6fb),
      surfaceTint: Color(0xffb2c6fb),
      onPrimary: Color(0xff1a2f5b),
      primaryContainer: Color(0xff001945),
      onPrimaryContainer: Color(0xff7083b4),
      secondary: Color(0xffb1c5ff),
      onSecondary: Color(0xff032c6f),
      secondaryContainer: Color(0xff002a6d),
      onSecondaryContainer: Color(0xff7894dc),
      tertiary: Color(0xffbbc3ff),
      onTertiary: Color(0xff001c95),
      tertiaryContainer: Color(0xff1f37bc),
      onTertiaryContainer: Color(0xffa9b3ff),
      error: Color(0xffe2000a),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff121316),
      onSurface: Color(0xffe3e2e6),
      onSurfaceVariant: Color(0xffc5c6d0),
      outline: Color(0xff8f909a),
      outlineVariant: Color(0xff44464f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2e6),
      inversePrimary: Color(0xff4a5d8c),
      primaryFixed: Color(0xffd9e2ff),
      onPrimaryFixed: Color(0xff001945),
      primaryFixedDim: Color(0xffb2c6fb),
      onPrimaryFixedVariant: Color(0xff324673),
      secondaryFixed: Color(0xffdae2ff),
      onSecondaryFixed: Color(0xff001947),
      secondaryFixedDim: Color(0xffb1c5ff),
      onSecondaryFixedVariant: Color(0xff254487),
      tertiaryFixed: Color(0xffdee0ff),
      onTertiaryFixed: Color(0xff000e5e),
      tertiaryFixedDim: Color(0xffbbc3ff),
      onTertiaryFixedVariant: Color(0xff1b34ba),
      surfaceDim: Color(0xff121316),
      surfaceBright: Color(0xff38393c),
      surfaceContainerLowest: Color(0xff0d0e11),
      surfaceContainerLow: Color(0xff1b1b1f),
      surfaceContainer: Color(0xff1f1f23),
      surfaceContainerHigh: Color(0xff292a2d),
      surfaceContainerHighest: Color(0xff343438),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd0dcff),
      surfaceTint: Color(0xffb2c6fb),
      onPrimary: Color(0xff0d244f),
      primaryContainer: Color(0xff7c90c2),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffd1dbff),
      onSecondary: Color(0xff00225b),
      secondaryContainer: Color(0xff738fd7),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffd7daff),
      onTertiary: Color(0xff001578),
      tertiaryContainer: Color(0xff7487ff),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff121316),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdbdce6),
      outline: Color(0xffb0b1bb),
      outlineVariant: Color(0xff8e9099),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2e6),
      inversePrimary: Color(0xff334774),
      primaryFixed: Color(0xffd9e2ff),
      onPrimaryFixed: Color(0xff000f30),
      primaryFixedDim: Color(0xffb2c6fb),
      onPrimaryFixedVariant: Color(0xff203561),
      secondaryFixed: Color(0xffdae2ff),
      onSecondaryFixed: Color(0xff000f31),
      secondaryFixedDim: Color(0xffb1c5ff),
      onSecondaryFixedVariant: Color(0xff0e3275),
      tertiaryFixed: Color(0xffdee0ff),
      onTertiaryFixed: Color(0xff000743),
      tertiaryFixedDim: Color(0xffbbc3ff),
      onTertiaryFixedVariant: Color(0xff0020a4),
      surfaceDim: Color(0xff121316),
      surfaceBright: Color(0xff444448),
      surfaceContainerLowest: Color(0xff07070a),
      surfaceContainerLow: Color(0xff1d1d21),
      surfaceContainer: Color(0xff27282b),
      surfaceContainerHigh: Color(0xff323236),
      surfaceContainerHighest: Color(0xff3d3d41),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffedefff),
      surfaceTint: Color(0xffb2c6fb),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffaec2f7),
      onPrimaryContainer: Color(0xff000a24),
      secondary: Color(0xffedefff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffabc1ff),
      onSecondaryContainer: Color(0xff000925),
      tertiary: Color(0xffefeeff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffb6beff),
      onTertiaryContainer: Color(0xff000434),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff121316),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffefeffa),
      outlineVariant: Color(0xffc1c2cc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2e6),
      inversePrimary: Color(0xff334774),
      primaryFixed: Color(0xffd9e2ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffb2c6fb),
      onPrimaryFixedVariant: Color(0xff000f30),
      secondaryFixed: Color(0xffdae2ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb1c5ff),
      onSecondaryFixedVariant: Color(0xff000f31),
      tertiaryFixed: Color(0xffdee0ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffbbc3ff),
      onTertiaryFixedVariant: Color(0xff000743),
      surfaceDim: Color(0xff121316),
      surfaceBright: Color(0xff505053),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1f1f23),
      surfaceContainer: Color(0xff303034),
      surfaceContainerHigh: Color(0xff3b3b3f),
      surfaceContainerHighest: Color(0xff46464a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );

  /// Custom Color 1
  static const customColor1 = ExtendedColor(
    seed: Color(0xff50b680),
    value: Color(0xff50b680),
    light: ColorFamily(
      color: Color(0xff006d43),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff50b680),
      onColorContainer: Color(0xff004327),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff006d43),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff50b680),
      onColorContainer: Color(0xff004327),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff006d43),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff50b680),
      onColorContainer: Color(0xff004327),
    ),
    dark: ColorFamily(
      color: Color(0xff75daa1),
      onColor: Color(0xff003920),
      colorContainer: Color(0xff50b680),
      onColorContainer: Color(0xff004327),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff75daa1),
      onColor: Color(0xff003920),
      colorContainer: Color(0xff50b680),
      onColorContainer: Color(0xff004327),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff75daa1),
      onColor: Color(0xff003920),
      colorContainer: Color(0xff50b680),
      onColorContainer: Color(0xff004327),
    ),
  );


  List<ExtendedColor> get extendedColors => [
    customColor1,
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
