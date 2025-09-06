import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Theme cho chế độ sáng (Light Mode)
  static ThemeData get lightTheme {
    return FlexThemeData.light(
      scheme: FlexScheme.dellGenoa, 
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold, 
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useMaterial3Typography: true, 
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
        cardRadius: 12.0,
        inputDecoratorRadius: 12.0,
        elevatedButtonRadius: 12.0, 
        textButtonRadius: 12.0,
        outlinedButtonRadius: 12.0,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true, 
      swapLegacyOnMaterial3: true,
      // fontFamily: GoogleFonts.openSans().fontFamily, // Vô hiệu hóa
    );
  }

  // Theme cho chế độ tối (Dark Mode)
  static ThemeData get darkTheme {
    return FlexThemeData.dark(
      scheme: FlexScheme.dellGenoa,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        useMaterial3Typography: true, 
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
        cardRadius: 12.0,
        inputDecoratorRadius: 12.0,
        elevatedButtonRadius: 12.0,
        textButtonRadius: 12.0,
        outlinedButtonRadius: 12.0,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // fontFamily: GoogleFonts.openSans().fontFamily, // Vô hiệu hóa
    );
  }
}
