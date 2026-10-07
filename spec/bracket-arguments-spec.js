const path = require("node:path");

describe("CMake bracket argument delimiters", () => {
  let editor;

  beforeEach(async () => {
    const pack = await lumine.packages.activatePackage(path.resolve(__dirname, ".."));
    editor = await lumine.workspace.open();
    editor.setGrammar(pack.grammars.find((grammar) => grammar.scopeName === "source.cmake"));
  });

  afterEach(() => editor.destroy());

  async function parse(text) {
    editor.setText(text);
    expect(await editor.whenGrammarSettled()).toBeTrue();
    return editor.getSyntaxNodeAtBufferPosition([0, 0], (node) => !node.parent);
  }

  for (const argument of ["[=[a]]=]", "[==[value]===]still] ]==]", "[=[a\0b]]=]"]) {
    it(`keeps mismatched closing characters inside ${JSON.stringify(argument)}`, async () => {
      const root = await parse(`message(${argument})\nset(NEXT ok)\n`);
      expect(root.hasError).toBeFalse();
      expect(root.descendantsOfType("bracket_argument").map((node) => node.text)).toEqual([
        argument,
      ]);
      expect(root.descendantsOfType("normal_command").length).toBe(2);
      expect(editor.scopeDescriptorForBufferPosition([0, 10]).getScopesArray()).toContain(
        "string.quoted.other.bracket.cmake",
      );
    });
  }

  it("reparses a trailing bracket after an unsaved content edit", async () => {
    await parse("message([=[value]=])\n");
    const root = await parse("message([=[value]]=])\n");
    expect(root.hasError).toBeFalse();
    expect(root.descendantsOfType("bracket_argument")[0].text).toBe("[=[value]]=]");
  });
});
