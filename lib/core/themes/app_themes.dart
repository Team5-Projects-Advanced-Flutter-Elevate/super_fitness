import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_fitness/core/colors/app_colors.dart';

abstract class AppThemes {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.transparent,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
      titleSpacing: 0,
      titleTextStyle: GoogleFonts.balooThambi2(
        fontSize: 20,
        color: AppColors.white,
        fontWeight: FontWeight.w700,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.balooThambi2(
        fontSize: 22,
        color: AppColors.white,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.balooThambi2(
        fontSize: 16,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.balooThambi2(
        fontSize: 14,
        color: AppColors.white,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: GoogleFonts.balooThambi2(
        fontSize: 14,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: GoogleFonts.balooThambi2(
        fontSize: 12,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.balooThambi2(
        fontSize: 11,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: GoogleFonts.balooThambi2(
        fontSize: 16,
        color: AppColors.white,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.balooThambi2(
        fontSize: 14,
        color: AppColors.white,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.balooThambi2(
        fontSize: 12,
        color: AppColors.white,
        fontWeight: FontWeight.w400,
      ),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.mainColorDark,
      onPrimary: AppColors.white,
      secondary: AppColors.white,
      onSecondary: AppColors.mainColorDark,
      error: Colors.redAccent,
      onError: AppColors.white,
      surface: AppColors.black,
      onSurface: AppColors.mainColorDark,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.black.withAlpha(204),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        Color color;
        if (states.contains(WidgetState.selected)) {
          color = AppColors.mainColorDark;
        } else {
          color = AppColors.white;
        }
        return IconThemeData(color: color, size: 30);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return GoogleFonts.balooThambi2(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: AppColors.mainColorDark,
          );
        } else {
          return GoogleFonts.balooThambi2(color: AppColors.transparent);
        }
      }),
      indicatorColor: Colors.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 4,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      prefixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused) ||
            states.contains(WidgetState.pressed)) {
          return AppColors.mainColorDark;
        } else {
          return AppColors.black[20]!;
        }
      }),
      prefixIconConstraints: const BoxConstraints(minWidth: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: AppColors.black[20]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: AppColors.mainColorDark),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(20),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.red),
      ),

      hintStyle: GoogleFonts.balooThambi2(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.black[20],
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.error)) {
          return const TextStyle(color: Colors.red); // Red label in error state
        }
        return ThemeData.light().textTheme.titleSmall?.copyWith(
              color: AppColors.black.withValues(
                alpha: 0.7,
              ), // Default label color
            ) ??
            const TextStyle();
      }),
      //suffixIcon: suffixIcon,
      filled: false,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.balooThambi2(
            fontSize: 16,
            color: AppColors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        textStyle: GoogleFonts.balooThambi2(
          fontSize: 16,
          color: AppColors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.white,
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        textStyle: GoogleFonts.balooThambi2(
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.mainColorLight;
        } else {
          return AppColors.white;
        }
      }),
    ),
    // switchTheme: SwitchThemeData(
    //   trackColor: WidgetStateProperty.resolveWith((states) {
    //     if (states.contains(WidgetState.selected)) {
    //       return AppColors
    //           .green; // Fallback to Colors.green if AppColors.green is null
    //     }
    //     return null; // Use default (colorScheme.surface)
    //   }),
    //   overlayColor: WidgetStateProperty.resolveWith((states) {
    //     if (states.contains(WidgetState.selected)) {
    //       return AppColors.green;
    //     }
    //     return null; // Use default
    //   }),
    //   thumbColor: WidgetStateProperty.resolveWith((states) {
    //     if (states.contains(WidgetState.disabled)) {
    //       return AppColors.black;
    //     } else if (states.contains(WidgetState.selected)) {
    //       return AppColors.white;
    //     }
    //     return AppColors.black;
    //   }),
    //   trackOutlineColor: WidgetStateProperty.resolveWith((states) {
    //     return AppColors.black; // Subtle outline
    //   }),
    // ),
  );
}