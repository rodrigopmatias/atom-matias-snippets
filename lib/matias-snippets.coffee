MatiasSnippetsView = require './matias-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = MatiasSnippets =
  matiasSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @matiasSnippetsView = new MatiasSnippetsView(state.matiasSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @matiasSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'matias-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @matiasSnippetsView.destroy()

  serialize: ->
    matiasSnippetsViewState: @matiasSnippetsView.serialize()

  toggle: ->
    console.log 'MatiasSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
