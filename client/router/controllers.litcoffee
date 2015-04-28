# Route Controllers

Example controller


    @RouteControllers =
      allPinkis: RouteController.extend
        waitOn: -> Meteor.subscribe 'allPinkis'
        data: -> pinkis: Pinkis.find()
      singlePinki: RouteController.extend
        waitOn: -> Meteor.subscribe 'singlePinki', this.params._id
        data: -> Pinkis.findOne()
