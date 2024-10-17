### Attachment:
Take screenshot of screen or list item.

### Example Prompt:
```
Task:
Create flutter widget code for this screenshot form Figma

Details:
This is a single list item in forum posts list

General requirements:
Give only code, without key points, explanation and comments
If necessary, create empty methods for business logic
Reusable widgets should be in separate build methods
Avoid long nested widgets, move them in to separate build methods
Project has theme and colorScheme, don't use hardcoded colors and styles,
Project has extension to get theme, instead of theme `Theme.of(context)` use `context.theme`
Project has extension to get common sizes, if possible use these values: context.dimensions.small - 8, context.dimensions.medium - 16, context.dimensions.large - 24

Specific requirements:
It has Card as root

Code for class:
class ExampleWidget extends StatelessWidget {
```