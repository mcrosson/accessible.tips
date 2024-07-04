---
title: In Game Controller Configurations
author: 
  - KemoNine
publishDate: 2023-03-25
lastMod: 2023-03-25
toc: true
draft: false
categories:
  - tips
  - gaming
tags:
  - controller
changelog:
  - date: 2023-03-25
    text: "Initial creation"
---

## Attribution
{{< back_to_top >}}

This tip is a syndicated copy of KemoNine's [blog post](https://blog.kemonine.info/blog/2023-01-15-controller-gaming/). It has been adapted to our site's format by KemoNine.

## KemoNine's Destiny 2 In-Game Config
{{< back_to_top >}}

### Important Notes
{{< back_to_top >}}

- **ALL config has been play tested heavily**
- This setup alternates hands for complimentary actions and balancing forces applied to buttons/triggers/sticks as you play
- This lets you move around while holding sticks for things like 'interact holds' or 'toggle crouch' -- if you have crouch on movement stick itll auto-drop you out of crouch because youve tripped the movement stick -- moving it to look stick fixed the problem -- the game engine input processing limits stick config options that work with the flow of movement in-game
- You can safely shuffle some things around based on usage patterns ; just dont change single/double/hold for how things activate ; a lot of this layout avoids issues with the input engine (see below)
- Long press events trigger single press events ; you should NOT overlap long and single press on a single button -- this appears to be a BUG in the input engine code
- With Strand using so many grenade, class ability and melee actions, the 4 paddle version was updated to make it easier to manage ability spam. The 2 paddle form _does work_ but is harder to use tactically in my _opinion_ and prompted the updates above

{{< back_to_top >}}

### General
{{< back_to_top >}}

- **Look sensitivity:** 8 (direct hid)
- **Look sensitivity:** 12 (steam link / elite)
- **Look sensitivity:** 10 (steam link / powera moba xp7x plus)
-   **Ads sensitivity modifier:** 0.5
-   **Sprint-turn scale:** 0.8
-   **Vertical inversion:** inverted (I'm a monster, deal with it)
- **Buttons:** (Be sure to start with the defaults before applying the below.)
   - **Fire:** right triger (single press)
   - **Hold zoom:** left trigger (single press)
   - **Reload:** left stick (double press)
   - **Alternate weapon action:** dpad right (single press)
   - **Auto melee:** right shoulder (single press)
   - **Grenade:** (Tune based on number of paddles)
       - **2 paddles or less:** left shoulder (double press)
       - **4 paddles or more:** left shoulder (single press)
   - **Super:** left + right shoulder (single press concurrently -- combo/chord)
   - **Jump:** a (single press)
   - **Finisher:** right stick (single press)
   - **Highlight player:** right stick (long press)
   - **Sprint:** left stick (single press)
   - **Toggle crouch:** right stick (double press)
   - **Light attack:** right shoulder (single press)
   - **Heavy attack:** right trigger (single press)
   - **Block:** left trigger (long press / hold)
   - **Stasis breakout:** b (double press)
   - **Class ability (all):** (tune based on number of paddles)
       - **2 paddles or less:** left shoulder (long press)
       - **4 paddles or more:** b (single press)
   - **Air dive ability:** (tune based on number of paddles)
       - **2 paddles or less:** left shoulder (long press)
       - **4 paddles or more:** b (single press)
   - **Swap to kinetic or energy weapon:** y (single press)
   - **Swap to power weapon:** y (long press)
   - **Interact:** dpad up (single press)
   - **Emoji 1:** dpad left (double press) / thanks
   - **Emoji 2:** dpad left (long press) / face palm
   - **Emoji 3:** dpad down (double press) / cowbell
   - **Emoji 4:** dpad down (long press) / salute or sit

{{< back_to_top >}}

### Tuneables
{{< back_to_top >}}

- If you find yourself needing stasis breakout in a better spot than b, dpad may be a good spot if you can spare an emoji
- Long press events trigger single press events ; you should NOT overlap long and single press on a single button

{{< end_section >}}

## KemoNine's No Man's Sky In-Game Config
{{< back_to_top >}}

### Important Notes
{{< back_to_top >}}

- This setup was reconciled against Destiny 2. In particular the `Discoveries / Options` and `Inventories` functions are in opposite locations compared to Destiny 2 by default and I have flipped them universally to help with muscle memory when swapping between the two games.

{{< back_to_top >}}

### Buttons
{{< back_to_top >}}

#### Menus

- **View Button:** Skip, Discoveries / Options
- **Menu Button:** Options / Quit
- **Left Stick Click:** Retry Network Connection
- **Right Stick Click:** Discard Item, Delete, Pin Formula
- **Y:** Quick Transfer, Retry Network Connection, Toggle Wiring Mode
- **X:** Initiate Process, Toggle Trade Inventory, Toggle Edit / Build
- **B:** Mode Select: Cancel, Back, Exit Menu
- **A:** Confirm (Menus)

{{< back_to_top >}}

#### On Foot

- **View Button:** Discoveries / Options, Skip
- **Menu Button:** Inventories
- **Left Stick Click:** Zoom, Pick Up Technology, Run
- **Right Stick Click:** Scan
- **Y:** Change Weapon Mode
- **X:** Interact, Place Marker, Tag Marker, Reload Weapon
- **B:** Switch Alt Weapon, Back
- **A:** Jump, Secondary Interaction

{{< back_to_top >}}

#### Quick Menu (On Foot)

- **View Button:** Discoveries / Options
- **Menu Button:** Inventories
- **Left Stick Click:** Run
- **Right Stick Click:** N/A
- **Y:** Change Weapon Mode
- **X:** Change Terrain Shape, Interact
- **B:** Switch Alt Weapon, Back, Toggle Terrain Mine / Create
- **A:** Jump, Confirm (Quick Menu)

{{< back_to_top >}}

#### Flight Controls

- **View Button:** Discoveries / Options, Skip
- **Menu Button:** Inventories
- **Left Stick Click:** Zoom In
- **Right Stick Click:** Scan
- **Y:** Change Weapon Mode
- **X:** Land Ship, Exit Ship, Tag Marker, Combat Autopilot (Toggle)
- **B:** Boost, Back
- **A:** Thrust

{{< back_to_top >}}

#### Quick Menu (Ship)

- **View Button:** Discoveries / Options
- **Menu Button:** Inventories
- **Left Stick Click:** N/A
- **Right Stick Click:** N/A
- **Y:** N/A
- **X:** Land Ship
- **B:** Back
- **A:** Confirm (Quick Menu)

{{< back_to_top >}}

#### Exocraft

- **View Button:** Discoveries / Options, Skip
- **Menu Button:** Inventories
- **Left Stick Click:** Horn
- **Right Stick Click:** Perform Scan
- **Y:** Switch Weapon Mode
- **X:** Exit Exocraft, Tag Marker
- **B:** Delete Checkpoint, Back
- **A:** Vertical Thrust

{{< back_to_top >}}

#### Galactic Map

- **View Button:** N/A
- **Menu Button:** Exit Map
- **Left Stick Click:** View Current Location
- **Right Stick Click:** Scan
- **Y:** Expand System Info
- **X:** Add Waypoint
- **B:** Back
- **A:** Confirm (Menus)

{{< back_to_top >}}

#### Photo Mode

- **View Button:** Discoveries / Options
- **Menu Button:** Inventories

{{< back_to_top >}}

#### Photo Mode (Menu)

- **View Button:** Discoveries / Options
- **Menu Button:** Inventories

{{< back_to_top >}}

#### Base Part Editing

- **View Button:** Discoveries / Options
- **Menu Button:** Recolour Building Part
- **Left Stick Click:** Run
- **Right Stick Click:** Toggle Build Camera
- **Y:** Toggle Wiring Mode
- **X:** Toggle Edit / Build
- **B:** Back
- **A:** Jump

{{< back_to_top >}}

#### Base Part Placing

- **View Button:** Discoveries / Options
- **Menu Button:** Recolour Building Part
- **Left Stick Click:** Run
- **Right Stick Click:** Toggle Build Camera
- **Y:** Toggle Wiring Mode
- **X:** Toggle Edit / Build
- **B:** Back
- **A:** Jump

{{< end_section >}}

## Related Pages
{{< back_to_top >}}

- [Controller Configurations]({{< ref "/tips/gaming-controllers-configs.md" >}})
- [Controller Gaming]({{< ref "/tips/gaming-controllers.md" >}})

{{< end_section >}}
