## MenuManager

#### Manage groups of control nodes, easily transition them in and out of view

- Add the MenuManager node as an autoload
- Add MenuEffect nodes as children of Control nodes
- Assign a MenuGroup to each effect. Nodes in the same group will activate at the same time 
- Add/Remove menu groups by editing the MenuGroup enum (menu_constants.gd)
- Subscribe to signals of MenuManager to know when the transitions are done.
- For a full example, run this scene: menu_manager_demo.tscn
- See already implemented MenuEffects at res://addons/menu_manager/menu_effect/impl/

#### Create your own MenuEffect scripts
- Create new menu effects by extending MenuEffect (menu_effect.gd)
- When extending MenuEffect, if you override _ready() then call super() in the overidden ready.