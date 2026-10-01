const fs = require("fs");
const path = require("path");

const packagePath = (name) => {
  const sibling = path.resolve(__dirname, "..", "..", name);
  return fs.existsSync(sibling) ? sibling : name;
};

describe("CMake static annotations", () => {
  it("highlights both comment forms and filters comments without annotations", async () => {
    for (const name of ["language-cmake", "language-hyperlink", "language-todo"]) {
      await lumine.packages.activatePackage(packagePath(name));
    }
    const editor = await lumine.workspace.open("CMakeLists.txt");
    try {
      const text =
        "# TODO https://example.com/line\n#[=[ FIXME https://example.com/block ]=]\n# ordinary comment\n";
      editor.setText(text);
      const mode = editor.languageMode;
      await mode.ready;
      await mode.atGrammarSettlement();
      const annotations = mode
        .getAllInjectionLayers()
        .filter((layer) => ["text.hyperlink", "text.todo"].includes(layer.grammar.scopeName));
      expect(annotations.length).toBe(4);
      expect(annotations.every((layer) => layer.injectionPoint.patternIndex !== undefined)).toBe(
        true,
      );
      for (const needle of ["TODO", "FIXME"]) {
        const position = editor.getBuffer().positionForCharacterIndex(text.indexOf(needle));
        expect(editor.scopeDescriptorForBufferPosition(position).getScopesArray()).toContain(
          "storage.type.class.todo",
        );
      }
      for (const needle of ["https://example.com/line", "https://example.com/block"]) {
        const position = editor.getBuffer().positionForCharacterIndex(text.indexOf(needle));
        expect(editor.scopeDescriptorForBufferPosition(position).getScopesArray()).toContain(
          "markup.underline.link.hyperlink",
        );
      }
    } finally {
      editor.destroy();
    }
  });
});
