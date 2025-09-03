## MenuManager

#### Manage groups of control nodes, easily transition them in and out of view

- Add the MenuManager node as an autoload
- Add MenuEffect nodes as children of Control nodes
- see InstantMenuEffect and SlideMenuEffect
- Create new menu effects by extending MenuEffect (menu_effect.gd)
- Add/Remove menu groups by editing the MenuGroup enum (menu_manager.gd)
- When extending MenuEffect, if you override _ready() then call super() in the overidden ready.
- Subscribe to signals of MenuManager to know when your custom transitions are done.
- Call MenuManager.clear() when switching scenes