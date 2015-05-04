MatiasSnippets = require '../lib/matias-snippets'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "MatiasSnippets", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('matias-snippets')

  describe "when the matias-snippets:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.matias-snippets')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'matias-snippets:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.matias-snippets')).toExist()

        matiasSnippetsElement = workspaceElement.querySelector('.matias-snippets')
        expect(matiasSnippetsElement).toExist()

        matiasSnippetsPanel = atom.workspace.panelForItem(matiasSnippetsElement)
        expect(matiasSnippetsPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'matias-snippets:toggle'
        expect(matiasSnippetsPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.matias-snippets')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'matias-snippets:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        matiasSnippetsElement = workspaceElement.querySelector('.matias-snippets')
        expect(matiasSnippetsElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'matias-snippets:toggle'
        expect(matiasSnippetsElement).not.toBeVisible()
