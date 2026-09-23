## 0.0.1

* TODO: Describe initial release.

## [1.0.0] - 2024-10-21
### Added
- Added new feature Snackbar, Textfield, Buttons, example project

## [1.0.1] - 2024-10-21
### Fixed
- Fixed small issue

## [2.0.0] - 2026-09-23
### Changed (breaking)
- Restructured into `foundation/`, `theme/` and `components/<category>/<name>/`.
  Every component is self-contained and imports nothing else from the package.
- New per-area libraries: `buttons.dart`, `inputs.dart`, `overlays.dart`,
  `feedback.dart`, `layout.dart`, `media.dart`, `text.dart`, `foundation.dart`,
  `theme.dart`. `flutter_common_components.dart` still exports everything.
- `GradientFillButton`, `OutlineFillButton`, `SmallButton` and `IconTextButton`
  now have their own `ThemeExtension` (`GradientFillButtonTheme`, ...) with
  defaults from `ColorScheme`, passed per instance via `style:`.
  Disabled = `onPressed: null`, loading = `isLoading: true`, icons are `Widget`s.
- `AppTheme(colorScheme: ...).build()` / `AppTheme.standard()` / `.dark()` /
  `.charcoal()`; dark and charcoal now actually use their own color schemes.
- Renamed: `ButtonStyle` → `CommonButtonStyle`, `ButtonVariant` →
  `CommonButtonVariant`, alert `CommonDialog` → `CommonAlertDialog`
  (`AlertDialogStyle`, `AlertDialogVariant`), `CommonSearchBar` →
  `CommonSearchDelegate(items: ...)`, `ColorSchemeUtils` → `AppColorSchemes`,
  `GoogleFontsThemeUtil` → `AppTextThemes`, `PaddingUtils` → `AppInsets`,
  `ConstSizedBox` → `AppGaps`, `RadiusUtils` → `AppRadius`, `ShadowUtils` →
  `AppShadows`, `CommonInputChip(name:, number:)` → `(label:, count:)`.

### Removed
- `WidgetToolkitTheme`, the design-system classes, `ButtonStateModel`,
  `ButtonColorStyle`, `SvgFile`, `IconUtils`, `SearchTextField` and empty
  utility stubs; `theme_tailor` and `copy_with_extension` code generation.