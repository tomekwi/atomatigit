File = require '../../lib/models/file'
Diff = require '../../lib/models/diff'
FileView = require '../../lib/views/file-view'

describe "FileView", ->
  view = model = null
  beforeEach ->
    model = new File path: "death.bar"
    view = new FileView model

  describe ".showSelection", ->
    it "adds selected class if model is selected", ->
      model.select()
      view.showSelection()
      expect(view.hasClass "selected").toBe true

    it "removes selected class if model is not selected", ->
      model.deselect()
      view.showSelection()
      expect(view.hasClass "selected").toBe false

  describe ".clicked", ->
    it "calls model.selfSelect", ->
      spyOn(model, "selfSelect")
      view.clicked()
      expect(model, "selfSelect").toHaveBeenCalled

  describe ".showDiff", ->
    it "empties diff dom element if diff should not be shown", ->
      model.set diff: false
      view.showDiff()
      expect(view.find(".diff").length).toBe 0

    it "Fills diff dom element if diff should be shown", ->
      string = ["--- a/lib/models/diff.coffee",
                "+++ b/lib/models/diff.coffee",
                "@@ -1,37 +1,29 @@",
                "-{Collection} = require 'backbone'",
                "+List = require './list'",
                "_ = require 'underscore'",
                "@@ -1,54 +1,33 @@",
                "DiffChunk = require './diff-chunk'",
                "-ListModel = require './list-model'"].join "\n"

      model.set diff: true
      model.sublist = new Diff diff: string
      view.showDiff()
      expect(view.find(".diff").length).toBe 1
