# Pomotray
A tray pomodoro clock written in Ruby and Qt - cross platform! [qtbindings](https://github.com/ryanmelt/qtbindings/)
is used to bridge over from Ruby to Qt.

## Running from source
Need to have `qt4` and `cmake` installed. And a ruby. Running with 2.1.5 at the moment. Ruby need to be installed with:

    CONFIGURE_OPTS="--enable-shared" rbenv install 2.1.5

otherwise qtbindings won't compile. When prereqs are in place install gems:

    bundle install

then run it with

    bundle exec ruby pomotray.rb

## Features
- [x] starts the clock
- [x] pauses the clock
- [x] resets the clock
- [x] tells with a popup that the time is up
- [x] time left as a tooltip

## Future plans
- [ ] make it possible to quit from the context menu
- [ ] make an arch linux package
- [ ] make stuff configurable in `~/.pomotray.conf`
- [ ] voice syntesizer sound
- [ ] have an optional number showing minutes left instead of a tomato in the tray
- [ ] someone else may package this thing for other platforms

## Credits
The [tomato icon](http://www.iconarchive.com/show/vegetables-icons-by-fengsj/Tomato-icon.html)
is created by Guo Xiaofeng and is available for non-commercial user.
