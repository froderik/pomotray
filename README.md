# Pomotray
A tray pomodoro clock written in Ruby and Qt - cross platform! [qtbindings](https://github.com/ryanmelt/qtbindings/)
is used to bridge over from Ruby to Qt.

# Credits
The [tomato icon](http://www.iconarchive.com/show/vegetables-icons-by-fengsj/Tomato-icon.html)
is created by Guo Xiaofeng and is available for non-commercial user.

# Running from source
Need to have `qt4` and `cmake` installed. And a ruby. Running with 2.1.5 at the moment. Ruby need to be installed with:

    CONFIGURE_OPTS="--enable-shared" rbenv install 2.1.5

otherwise qtbindings won't compile. When prereqs are in place install gems:

    bundle install
