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
