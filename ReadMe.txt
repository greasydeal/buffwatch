***********************
    BuffWatch Readme
         By Greasydeal
***********************

Installation:
Copy the contents of the zip file into a folder named "buffwatch" under the addons folder in your Ashita directory.

Use:

Open the settings.json under {Ashita Directory}\addons\buffwatch\settings directory in your favorite text editor.

The "font" field controls the colors and location of the buff indicators. 
The color fields are the decimal equivalents of a hex value formated as: AARRGGBB, A - Alpha, R- Red, G- Green, B - Blue. 
The "position" field is an array value that controls X and Y location of the indicators.

The buffs monitored are job specific. 
Add the buff names that you want to monitor for each job between the [ ] brackets. 
Make sure each buff name is in quotations and separated by commas. 
Example:  ["Protect", "Shell"]. 

If you modify the settings.json file you will need to reload the addon by typing: /addon reload buffwatch

To load the addon type: /addon load buffwatch
