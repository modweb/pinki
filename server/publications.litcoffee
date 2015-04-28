# Publications

    Meteor.publish 'allPinkis', -> Pinkis.find()
    Meteor.publish 'singlePinki', (_id) -> Pinkis.find _id: _id
