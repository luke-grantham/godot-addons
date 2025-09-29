
1. Install and login with butler commandline: https://itch.io/docs/butler/
2. Export your game (here I'm exporting to a directory named target)
3. Run command according to your game's url: https://grantlerr.itch.io/godot4-web-export-test

`butler push target grantlerr/godot4-web-export-test:html5`

You need to check the box for "This file will be played in the browser" on the first build you upload with your chosen channel.
The channel here being 'html5'. After that, all builds uploaded with that channel will have that option checked, and will replace the previous build.
