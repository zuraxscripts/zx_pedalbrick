Config = {}

-- Framework Support
framework = "ESX"           -- Use "esx" for ESX framework
itemname = "brick"       -- Item Name
target = "ox_target"        -- Supports "ox_target" only
inv = "ox_inventory"        -- Inventory system: Use "ox_inventory" for ox support

-- Props for Pickup
brick = {              -- Add props to represent bricks
    "prop_pile_dirt_02",
    "ng_proc_brick_01a",
    "prop_conc_blocks01b",
}

-- Vehicle Behavior
time = -1                   -- How long the car drives before stopping (in ms, e.g., 30000 for 30 seconds)
breakcar = true            -- If true, the car breaks when it hits something (one-way trip)

-- Language Settings
Language = {
    pickup = "Pick up brick",                     -- Pickup brick
    placedonpedal = "You placed the brick on the gas pedal",  -- Place brick on pedal
    locked = "The vehicle is locked",             -- Car is locked
    close = "You need to be closer to a vehicle", -- Need to be near a vehicle
    plasserpedal = "Place the brick on the pedal", -- Target: Place brick on pedal
    noitem = "You dont have any Brick" -- If player dont have any brick in inventory 
}
