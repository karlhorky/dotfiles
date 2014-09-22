$ = require 'jquery'

module.exports =

  activate: (state) ->
    atom.workspaceView.command "resize-panes:enlarge-active-pane", => @enlarge()
    atom.workspaceView.command "resize-panes:shrink-active-pane", => @shrink()

  enlarge: ->
    flex = @getFlex()
    flex.grow *= 1.1
    flex.shrink *= 1.1
    @setFlex flex

  shrink: ->
    flex = @getFlex()
    flex.shrink /= 1.1
    flex.grow /= 1.1
    @setFlex flex

  getFlex: ->
    [grow,shrink,basis] = $('.pane.active').css('-webkit-flex').split ' '
    return {grow,shrink,basis}

  setFlex: ({grow,shrink,basis}) ->
    flex = [grow,shrink,basis].join ' '
    $('.pane.active').css('-webkit-flex', flex)

  deactivate: ->

  serialize: ->
