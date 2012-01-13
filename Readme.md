RspecEnhancedProfile
=====================
Normal profile output only shows top 10 time consuming examples:

    Top 10 slowest examples:
    0.5215740 User downgrades to a person
    0.4326950 User finds invalid
    0.1914630 User remembering unsets remember token
    0.1218360 User is valid
    0.0903790 Festival is valid

This enhanced formatter will give you n-slowes examples AND groups:

    Groups:
    5.1150300 Movie
    4.9603220 Icon
    1.7279670 User
    1.4466160 Person
    1.1001500 Review
    0.6654430 MovieObserver
    0.5624980 Tag
    ...

    Single examples:
    4.8707710 Icon refresh! resizes existing thumbs
    0.9086340 Review releases the movie
    0.5203390 Movie finds invalid
    0.4428370 MovieObserver sending mails does not send when inactive
    0.3279970 Person merging cannot merge with a user
    0.3189010 Movie Hyper Estraier searches category_id STREQ
    ...


Install
=======
    rails plugin install git://github.com/grosser/rspec_enhanced_profile.git

### As only formatter:
add to .rspec
    --format RspecEnhancedProfile

### As additional formatter:
add to .rspec
    --format progress
    --format RspecEnhancedProfile:tmp/profile.txt

### Need more then 20 ?
    PROFILE_SHOW_TOP=100 rake spec

Author
======

### [Contributors](http://github.com/grosser/rspec_enhanced_profile/contributors)
 - [Keeran Raj Hawoldar](https://github.com/keeran)


[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
Hereby placed under public domain, do what you want, just do not hold me accountable...
