## MenuManager

#### Manage the visibility of groups of control nodes.

- Add the MenuManager node as an autoload.
- Create new menus by extending MyMenu (my_menu.gd) on your own Control nodes.
- Add/Remove menu groups by editing the MenuGroup enum.
- Override the functions in my_menu.gd to create custom transitions.
- If you override _ready() then call super() in the overidden ready.
- Subscribe to signals of MenuManager to know when your custom transitions are done.