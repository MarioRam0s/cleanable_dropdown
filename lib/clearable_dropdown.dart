import 'package:clearable_dropdown/src/entities/catalog_object.entity.dart'
    show CatalogObject;
import 'package:flutter/material.dart';
export 'src/entities/catalog_object.entity.dart';

/// A customizable dropdown widget that allows selection clearing, focus control,
/// and various visual customizations. Ideal for use in forms.
class ClearableDropdown extends StatefulWidget {
  /// **Required.** List of items to be displayed in the dropdown.
  /// Each item must be a [CatalogObject] with an `id` and a `name`.
  final List<CatalogObject> listItems;

  /// Optional label displayed above the dropdown field.
  final String? label;

  /// Hint text displayed when no item is selected.
  final String? hint;

  /// Initial selected value, matching one of the item names.
  final String? valueInitial;

  /// Error message displayed below the field.
  final String? errorText;

  /// Helper text displayed below the field.
  final String? helperText;

  /// Whether the dropdown is enabled. Defaults to `true`.
  final bool? enable;

  /// Optional focus node to trigger scrolling or other behaviors.
  final FocusNode? focus;

  /// Callback triggered when a selection is made.
  /// Returns the `id` of the selected item as a string.
  final void Function(String?)? onSelected;

  /// Callback triggered when the clear icon is pressed.
  /// Also clears the field.
  final void Function()? onDeleteSelection;

  /// Margin around the dropdown container.
  /// Defaults to `EdgeInsets.only(left: 15, right: 15, bottom: 12.5)`.
  final EdgeInsetsGeometry? margin;

  /// Maximum height of the dropdown menu. Defaults to `250`.
  final double? menuHeight;

  /// Decoration theme for customizing the input field appearance.
  final InputDecorationTheme? inputDecorationTheme;

  /// Color used for the label text. Defaults to `Colors.black`.
  final Color? colorLabel;

  /// Optional icon displayed at the start of the field.
  final Icon? leadingIcon;

  /// Custom icon used for the clear action. Defaults to `Icons.clear`.
  final Icon? deleteIcon;

  /// Custom style applied to the dropdown menu.
  final MenuStyle? menuStyle;

  /// Creates a [ClearableDropdown] widget.
  const ClearableDropdown({
    super.key,
    required this.listItems,
    this.deleteIcon,
    this.errorText,
    this.focus,
    this.helperText,
    this.hint,
    this.label,
    this.leadingIcon,
    this.menuStyle,
    this.onDeleteSelection,
    this.onSelected,
    this.valueInitial,
    this.enable = true,
    this.menuHeight = 250,
    this.colorLabel = Colors.black,
    this.margin = const EdgeInsets.only(left: 15, right: 15, bottom: 12.5),
    this.inputDecorationTheme = const InputDecorationTheme(
      errorMaxLines: 2,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    ),
  });

  @override
  State<ClearableDropdown> createState() => _ClearableDropdown();
}

class _ClearableDropdown extends State<ClearableDropdown> {
  // Controller used to update the selected text in the input field.
  late final TextEditingController controller;

  // Key used to find the widget’s position for scrolling into view.
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.valueInitial);

    // Listen to focus changes to automatically scroll into view when focused.
    widget.focus?.addListener(_focusListener);
  }

  void _focusListener() {
    if (widget.focus!.hasFocus) {
      Future.delayed(const Duration(milliseconds: 100), () {
        final context = _key.currentContext;
        if (context != null && context.mounted) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInOut,
            alignment: 0.5,
          ).then((_) {
            if (context.mounted) FocusScope.of(context).unfocus();
          });
        }
      });
    }
  }

  @override
  void dispose() {
    // Remove the focus listener to avoid memory leaks.
    widget.focus?.removeListener(_focusListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focus,
      child: Container(
        key: _key,
        margin: widget.margin,
        child: DropdownMenu<String>(
          controller: controller,
          enabled: widget.enable!,
          enableFilter: false,
          enableSearch: false,
          errorText: widget.errorText,
          expandedInsets: const EdgeInsets.all(1),
          helperText: widget.helperText,
          hintText: widget.hint,
          initialSelection: controller.value.text,
          inputDecorationTheme: widget.inputDecorationTheme,
          leadingIcon: widget.leadingIcon,
          menuHeight: widget.menuHeight,
          menuStyle: widget.menuStyle,
          requestFocusOnTap: false,
          onSelected: (value) {
            final selected = widget.listItems.firstWhere(
              (item) => item.id.toString() == value,
            );
            controller.text = selected.name;
            widget.onSelected?.call(value);
            setState(() {});
          },
          trailingIcon:
              controller.value.text.isNotEmpty == true &&
                      widget.onDeleteSelection != null
                  ? GestureDetector(
                    onTap: () {
                      controller.clear();
                      widget.onDeleteSelection!.call();
                      setState(() {});
                    },
                    child: widget.deleteIcon ?? const Icon(Icons.clear),
                  )
                  : null,
          label:
              widget.label != null
                  ? Text(
                    widget.label!,
                    style: TextStyle(
                      color: widget.colorLabel,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                  : null,
          dropdownMenuEntries:
              widget.listItems.map<DropdownMenuEntry<String>>((
                CatalogObject item,
              ) {
                return DropdownMenuEntry<String>(
                  value: item.id.toString(),
                  label: item.name,
                );
              }).toList(),
        ),
      ),
    );
  }
}
