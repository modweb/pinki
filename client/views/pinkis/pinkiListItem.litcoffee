    Template.pinkiListItem.helpers
      isLocked: -> (_.findWhere this.pinkisLocked, userId: Meteor.userId())?
    Template.pinkiListItem.events
      'click .lock-pinkis': (event, template) ->
        Meteor.call 'lockPinkis', Template.currentData()._id, (error, result) ->
          if error?
            sweetAlert 'Oh no!', error.reason, 'error'
          else
            sweetAlert 'Yippee!', 'Pinkis locked!', 'success'
