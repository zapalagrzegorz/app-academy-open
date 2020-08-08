# Art Share API

We're going to continue building on the API we built in the first routes project. Our goal is to build an application to store, share, and comment on artwork, as well as search for users.
This README would normally document whatever steps are necessary to get the
application up and running.


Each user has a set of artworks that they own/control. These artworks can also be shared with other users. An artwork that has been shared with one or more other users will be visible to those users, but the artwork still 'belongs to' the original user.
Things you may want to cover:


Although we will maintain this conceptual distinction between a user's own artworks vs. the artworks that have been shared with that user, we will eventually write an index method that will combine both types of a user's viewable artworks together so that we can see any art made by or shared with that user.