# Pinkis Collection

    PinkiSchema = new SimpleSchema
      userId:
        type: String
        regEx: SimpleSchema.RegEx.Id
      username:
        type: String
      timeLocked:
        type: Date

    PinkisSchema = new SimpleSchema
      creatorId:
        type: String
        regEx: SimpleSchema.RegEx.Id
        optional: yes
      creatorUsername:
        type: String
        autoValue: ->
          if this.isInsert
            Meteor.user().username
          else
            this.unset()
        optional: yes
      timeCreated:
        type: Date
        autoValue: ->
          if this.isInsert
            moment.utc().toDate()
          else
            this.unset()
        optional: yes
      description:
        type: String
        max: 1000
        label: 'What do you promise?'
      pinkisLocked:
        type: [PinkiSchema]
        optional: yes
        autoValue: ->
          if this.isInsert
            [ ]
          else
            this.value

    @Pinkis = new Mongo.Collection 'pinkis'
    Pinkis.attachSchema PinkisSchema

    Pinkis.allow
      insert: (userId, doc, field, name) -> Meteor.userId()?
      update: (userId, doc) -> Meteor.userId()?
      remove: (userId, doc) -> Meteor.userId() is doc.creatorId

## Client side hooks

    if Meteor.isClient
      AutoForm.hooks
        pinkiInsertForm:
          onSuccess: (formType, result) ->
            if formType is 'insert'
              Router.go 'pinki', _id: result

## Meteor Methods

    Meteor.methods
      lockPinkis: (pinkiId) ->

Check logged in

        if not this.userId? then throw new Meteor.Error 'You have to logged in to do that', 'not-logged-in'

Lookup pinki

        criteria = _id: pinkiId
        pinki = Pinkis.find criteria

        if not pinki? then throw new Meteor.Error "Could not find pinki with id #{pinkiId}", 'pinki-not-found'

Check if user is already locked

        if (_.findWhere pinki.pinkisLocked, userId: this.userId)? then throw new Meteor.Error 'You are already locked to this pinki!', 'already-locked'

Lock pinkis

        pinkiLocked =
          userId: this.userId
          username: Meteor.user().username
          timeLocked: moment.utc().toDate()
        update =
          $addToSet:
            pinkisLocked: pinkiLocked

        Pinkis.update criteria, update
