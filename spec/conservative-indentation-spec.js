describe("CMake conservative indentation", () => {
  let editor;
  beforeEach(async () => {
    jasmine.useRealClock();
    await lumine.packages.activatePackage("language-cmake");
    editor = await lumine.workspace.open("indentation.cmake");
    editor.update({ autoIndent: true, tabLength: 2, softTabs: true });
  });
  afterEach(() => editor.destroy());
  async function start(source) {
    editor.setText(source);
    expect(await editor.whenGrammarSettled()).toBe(true);
  }

  it("indents block commands and returns to their owner at endblock", async () => {
    await start('block()\nmessage(STATUS "hi")\nendblock()');
    await editor.autoIndentBufferRows(0, 2);
    expect(editor.getText()).toBe('block()\n  message(STATUS "hi")\nendblock()');
  });

  it("indents command continuations without accumulating indentation", async () => {
    await start('message(\nSTATUS\n"hi"\n)');
    await editor.autoIndentBufferRows(0, 3);
    expect(editor.getText()).toBe('message(\n  STATUS\n  "hi"\n)');
    editor.setCursorBufferPosition([3, Infinity]);
    await editor.insertNewline();
    expect(editor.lineTextForBufferRow(4)).toBe("");
  });

  it("starts a block body after a multiline condition closes", async () => {
    await start("if(\n  READY\n)\nendif()");
    editor.setCursorBufferPosition([2, Infinity]);
    await editor.insertNewline();
    expect(editor.lineTextForBufferRow(3)).toBe("  ");
  });

  it("aligns else and endif and opens each branch only once", async () => {
    await start('if(READY)\nmessage(STATUS "one")\nelse()\nmessage(STATUS "two")\nendif()');
    await editor.autoIndentBufferRows(0, 4);
    expect(editor.getText()).toBe(
      'if(READY)\n  message(STATUS "one")\nelse()\n  message(STATUS "two")\nendif()',
    );
  });

  it("does not indent after a complete one-line block or a comment", async () => {
    for (const source of ['if(READY) message(STATUS "hi") endif()', "# if(READY) ("]) {
      await start(source);
      editor.setCursorBufferPosition([0, Infinity]);
      await editor.insertNewline();
      expect(editor.lineTextForBufferRow(1)).toBe("");
    }
  });

  it("preserves bracket arguments and bracket comments during reindent", async () => {
    for (const source of [
      "set(VALUE [=[first\n      ( if(ON)\n  last]=])",
      "#[=[first\n      ( if(ON)\n  last]=]",
    ]) {
      await start(source);
      await editor.autoIndentBufferRows(0, editor.getLastBufferRow());
      expect(editor.getText()).toBe(source);
    }
  });
});
