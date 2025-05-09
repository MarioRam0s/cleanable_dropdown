/// Class used in the `DropdownMenuEntry`.
class CatalogObject {
  /// Identifier used to track the selected item.
  final int id;

  /// Label to be displayed in the dropdown.
  final String name;

  /// Creates an instance of [CatalogObject] with required [id] and [name] properties.
  CatalogObject({required this.id, required this.name});
}
