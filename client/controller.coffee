Router.route "/", ->
  @layout "layout"
  @render "list"

Template.list.helpers
  config: ->
    Config.findOne()

  rules: ->
    Rules.find({}, {sort: {priority: 1}})

  class: ->
    if @active then "default" else "danger"

Template.list.events
  "submit form.target": (event, template) ->
    event.preventDefault()
    form = $(event.currentTarget)
    config =
      target: form.find(".input-target").val()
      delay: form.find(".input-delay").val()
    #TODO: Validate
    Config.update Config.findOne()._id,
      $set: config
    bootbox.alert "The target config has been saved!"

  "click button.btn-pause": (event, template) ->
    Rules.update @_id,
      $set:
        active: false

  "click button.btn-resume": (event, template) ->
    Rules.update @_id,
      $set:
        active: true

  "click button.btn-remove": (event, template) ->
    bootbox.confirm "Are you sure you want to remove this rule?", (result) =>
      if result
        Rules.remove @_id

Router.route "/new", ->
  @layout "layout"
  @render "new"

Template.new.events
  "submit form": (event, template) ->
    event.preventDefault()
    form = $(event.currentTarget)
    rule =
      method: form.find(".input-method").val()
      url: form.find(".input-url").val()
      code: form.find(".input-code").val()
      body: form.find(".input-body").val()
      priority: form.find(".input-priority").val()
      active: true
    #TODO: Validate...
    Rules.insert rule
    Router.go "/"

Router.route "/edit/:ruleId", ->
  @layout "layout"
  @render "edit", data: Rules.findOne(@params.ruleId)

Template.edit.events
  "submit form": (event, template) ->
    event.preventDefault()
    form = $(event.currentTarget)
    rule =
      method: form.find(".input-method").val()
      url: form.find(".input-url").val()
      code: form.find(".input-code").val()
      body: form.find(".input-body").val()
      priority: form.find(".input-priority").val()
    #TODO: Validate...
    Rules.update @_id, $set: rule
    Router.go "/"
