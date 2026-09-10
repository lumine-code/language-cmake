const fs = require("fs");
const path = require("path");
const { Point } = require("lumine");

const highlightsPath = path.join(__dirname, "..", "grammars", "cmake-highlights.scm");

describe("CMake Tree-sitter highlights", () => {
  let editor;
  let languageMode;

  beforeEach(async () => {
    await lumine.packages.activatePackage("language-cmake");
  });

  afterEach(() => editor?.destroy());

  async function setUp(text) {
    editor = await lumine.workspace.open("CMakeLists.txt");
    editor.setText(text);
    languageMode = editor.getBuffer().languageMode;
    await languageMode.ready;
  }

  function scopesAt(row, text, occurrence = 0) {
    const line = editor.lineTextForBufferRow(row);
    let column = -1;
    for (let index = 0; index <= occurrence; index++) column = line.indexOf(text, column + 1);
    expect(column).not.toBe(-1);
    return editor.scopeDescriptorForBufferPosition([row, column]).getScopesArray();
  }

  function rawCaptures(startRow, endRow) {
    const layer = languageMode.rootLanguageLayer;
    return layer.queries.highlightsQuery.captures(layer.tree.rootNode, {
      startPosition: new Point(startRow, 0),
      endPosition: new Point(endRow, 0),
    });
  }

  it("preserves command-sensitive argument scopes", async () => {
    await setUp(`function(build target option)
endfunction()
macro(run argument)
endmacro()
set(NAME value CACHE STRING "doc")
unset(NAME CACHE)
list(APPEND ITEMS value)
list(LENGTH ITEMS ITEM_COUNT)
list(TRANSFORM ITEMS APPEND suffix OUTPUT_VARIABLE OUTPUT)
if(NAME AND OTHER)
endif()
custom(alpha beta)`);

    expect(scopesAt(0, "build")).toContain("entity.name.function.cmake");
    expect(scopesAt(0, "target")).toContain("variable.parameter.cmake");
    expect(scopesAt(2, "run")).toContain("entity.name.function.macro.cmake");
    expect(scopesAt(2, "argument")).toContain("variable.parameter.cmake");
    expect(scopesAt(4, "NAME")).toContain("variable.other.cmake");
    expect(scopesAt(4, "CACHE")).toContain("storage.modifier.cmake");
    expect(scopesAt(4, "STRING")).toContain("support.type.cmake");
    expect(scopesAt(5, "CACHE")).toContain("storage.modifier.cmake");
    expect(scopesAt(6, "ITEMS")).toContain("variable.other.cmake");
    expect(scopesAt(7, "ITEM_COUNT")).toContain("variable.other.cmake");
    expect(scopesAt(8, "OUTPUT", 1)).toContain("variable.other.cmake");
    expect(scopesAt(9, "AND")).toContain("keyword.operator.word.cmake");
    expect(scopesAt(11, "alpha")).toContain("constant.other.cmake");
  });

  it("keeps a 6000-row normal command leaf-rooted and local", async () => {
    const querySource = fs.readFileSync(highlightsPath, "utf8");
    expect(querySource).not.toMatch(/\(normal_command\s*\n(?:[^\n]*\n){0,4}\s*\(argument_list/);

    await setUp(
      ["custom(", ...Array.from({ length: 6000 }, (_, index) => `  value_${index}`), ")"].join(
        "\r\n",
      ),
    );
    const captures = rawCaptures(3000, 3006);
    expect(captures.length).toBeLessThanOrEqual(64);
    expect(
      captures.every(
        (capture) =>
          capture.node.startPosition.row >= 3000 && capture.node.startPosition.row < 3006,
      ),
    ).toBe(true);
  });
});
