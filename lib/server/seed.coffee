Meteor.startup ->
  unless Config.findOne()
    Config.insert
      target: "http://localhost:8080"
      delay: 0
