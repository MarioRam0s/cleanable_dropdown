# clearable_dropdown

Un widget personalizado de Flutter que extiende `DropdownMenu`, permitiendo selección limpia (reset) y personalización adicional, ideal para formularios.

## ✨ Características

- Permite limpiar la selección con un botón (`onDeleteSelection`)
- Soporte para `FocusNode` (útil para validaciones y navegación)
- Personalización de estilos (`MenuStyle`, íconos, colores, márgenes, etc.)
- Animación al hacer focus (opcional)
- Fácil de integrar y reutilizar

## 🚀 Instalación

Agrega esta línea a tu archivo `pubspec.yaml`:

```yaml
dependencies:
  clearable_dropdown: ^1.0.0
```

Luego ejecuta:

```bash
flutter pub get
```

## 🧪 Uso básico

```dart
import 'package:clearable_dropdown/clearable_dropdown.dart';

SelectBox(
  listItems: [
    CatalogObject(id: 1, name: 'Manzana'),
    CatalogObject(id: 2, name: 'Naranja'),
  ],
  label: 'Fruta',
  onSelected: (value) {
    print('Seleccionaste $value');
  },
  onDeleteSelection: () {
    print('Selección eliminada');
  },
)
```

## 📂 Ejemplo

Puedes encontrar un ejemplo completo en la carpeta [`example/`](example/).

## 🤝 Contribuciones

¡Las contribuciones son bienvenidas! Puedes abrir issues o hacer pull requests si deseas proponer mejoras.
