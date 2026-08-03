# language-cmake

CMake language support.

## Features

- **Grammars**: provides Tree-sitter grammars.
- **Syntax highlighting**: commands, variable references, quoted and bracket arguments, and the operators that only mean something inside `if()`.
- **Folding**: folds function, macro, conditional and loop blocks.
- **Auto-indentation**: indents block bodies and lines `else` and `elseif` up with their `if`.
- **Symbol navigation**: function and macro definitions.

## Services

- **hyperlink.injection** (`^1.0.0`): consumed to highlight URLs inside CMake files as clickable links.
- **todo.injection** (`^1.0.0`): consumed to highlight `TODO`-style markers inside comments.

## Contributing

Got ideas to make this package better, found a bug, or want to help add new features? Just drop your thoughts on GitHub. Any feedback is welcome!
