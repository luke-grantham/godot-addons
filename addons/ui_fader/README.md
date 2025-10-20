## UI Fader
Automatically fade out UI elements when they aren't being used.


## Setup
Set this node as a child of any Control node.
The parent node must have a signal with a single argument.

On the UiFader node export variable, set the name of the parent signal.

The UiFader will watch the value attached to that signal and fade out the parent Control node when the value is not being updated for some amount of time.
