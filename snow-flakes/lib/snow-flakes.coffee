SnowFlakesView = require './snow-flakes-view'
{CompositeDisposable} = require 'atom'

module.exports = SnowFlakes =
  snowFlakesView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @snowFlakesView = new SnowFlakesView(state.snowFlakesViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @snowFlakesView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'snow-flakes:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @snowFlakesView.destroy()

  serialize: ->
    snowFlakesViewState: @snowFlakesView.serialize()

  toggle: ->
    console.log 'SnowFlakes was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
