# Demonstrates 3 bugs still present in LV v0.19.5

## Installation

Make sure to run `npm install` in `/assets` to install AlpineJS and its focus plugin. 

The url is: `http://localhost:4000/live`

## Demoed Bugs

### 1. Hooks not working when prepending to a stream

[Bug #1 in Issue #2657](https://github.com/phoenixframework/phoenix_live_view/issues/2657) 

To reproduce the bug, click on the "Prepend a random item" button. The prepended item name should be underlined as
it is when appending items, but it's not.
   
Also, clicking the "Open Popup" of a prepended item will fail to set correct coordinates for the popup so it will
show in the top left corner of the window. This too is because the Alpine code was never invoked.  

[See the code](https://github.com/DaTrader/lv_bugs_0_19_5/blob/e202c71aa2206ebc910aa25e35ed877d189efc68/lib/lv_bugs_0_19_5_web/live/home/item_component.html.heex#L7C11-L7C11)
    
### 2. Stream reset messes up nested components

[Bug #2 in Issue #2657](https://github.com/phoenixframework/phoenix_live_view/issues/2657)

To reproduce the bug, click on the color buttons of a home appliance items to change their order. Make sure the
item is one of the default ones (not a prepended or appended one). Then click "Reset items". All colors except
for the one picked last will have vanished (and they shouldn't have)
   
A similar result can be achieved by clicking on a "Start Carousel" button after the item colors start rotating,
click the "Reset items" button.
   
Also, a weird thing happens when colors are rotating and the "Reset items" button is pressed several times.
The rotation becomes faster and faster although it's achieved with the `send_after_update` and a 2 seconds
delay.
   
### 3. Coordinates set to child element in JS are lost when ancestor state is updated

[Issue #2711](https://github.com/phoenixframework/phoenix_live_view/issues/2711)

Click a "Start carousel" button and then the "Open Popup" button next to it. As soon as the appliance item gets updated
to rotate the colors, the popup will lose its coordinates and get placed in the top left corner.
