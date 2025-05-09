import 'package:clearable_dropdown/src/entities/catalog_object.entity.dart'
    show CatalogObject;
import 'package:flutter/material.dart';
export 'src/entities/catalog_object.entity.dart';

class ClearableDropdown extends StatefulWidget {
  final List<CatalogObject> listItems;

  final String? label;
  final String? hint;
  final String? valueInitial;
  final String? errorText;
  final String? helperText;
  final bool? enable;

  final FocusNode? focus;

  final void Function(String?)? onSelected;
  final void Function()? onDeleteSelection;

  final EdgeInsetsGeometry? margin;
  final double? menuHeight;
  final InputDecorationTheme? inputDecorationTheme;
  final Color? colorLabel;
  final Icon? leadingIcon;
  final Icon? deleteIcon;
  final MenuStyle? menuStyle;

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
  late final TextEditingController controller;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.valueInitial);
    widget.focus?.addListener(() {
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
              // Quita el focus después de animar
              if (context.mounted) FocusScope.of(context).unfocus();
            });
          }
        });
      }
    });
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
