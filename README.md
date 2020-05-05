#  Screenshoddy

### Installation

### Usage

### Meta

### Restore Application To Fresh Install

Here’s how to start over with untouched preferences and default window sizes:

1. Quit Screenshoddy if it’s running.

2. Delete the application support folder. On the command line: `rm -rf ~/Library/Application\ Support/Screenshoddy/`

3. Delete the preferences.  On the command line do: `defaults delete com.geofcrowl.Screenshoddy` and then `killall cfprefsd`

4. Launch Screenshody or build and run. All the preferences and window sizes should be set back to the defaults.


### Contributing

- Fork it
- Create your feature branch: `git checkout -b feature/fooBar`
- Commit your changes: `git commit -am 'Add some fooBar'`
- Push to the branch: `git push origin feature/fooBar`
- Create a new Pull Request
