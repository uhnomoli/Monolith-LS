# Monolith LS

A [LiteStep][1] theme inspired by futuristic, sci-fi interfaces.

I want to say that the animations are really what pulled this whole theme together for me.

The start menu and weather widget both slide on and off the screen, section by section, when showing or hiding. The sys tray slides down and up from the top of the screen when showing and hiding. The taskbar grows and shrinks to accommodate the number of active tasks. It can grow all the way out to the clock and will slide up and back down at the proper size to make room for the sys tray if needed when it's shown. It also does the same when the sys tray is then hidden if needed to expanded the taskbar back out to the clock.

They all give the theme a great feel when using it. Sometimes I find myself just playing with the start menu :s


### Notes

All modules should download just fine if you don't already have them with the __exception__ of __jDesk 0.75__. You can find it in [this][2] _([direct link][3])_ news post as well as in `/Extras`. Just extract the dll to `LiteStep/modules`. If for any reason, any other module can't be downloaded, you should be able to find it either [here][4], [here][5], or [here][6].

This theme __requires__ the font [Semplice Regular][7] _([download][8])_ which can also be found in `/Extras`.


### Configuration

The weather widget is the only thing that really requires configuration.

#### Weather

To configure the weather widget you need to find your [WOEID][9]. To do this goto [http://weather.yahoo.com/][10]. Enter your area code or city in the appropriate box and hit enter. You will be taken to a page with a URL in this format: `http://weather.yahoo.com/<country>/<state>/<city>-<WOEID>/` Simply grab the WOEID from the URL and set `mnWeatherWOEID` in `config/themeVars.rc` to it.


### Various Functionality

+ __Start Button__
    + Right click, minimizes all windows.
+ __Taskbar__
    + Middle click, closes the task clicked.
+ __Clock__
    + Left click, toggles the sys tray.
    + Right click, toggles the weather widget.
+ __Weather Widget__
    + Left click, opens your browser to your local weather.
    + Hovering over the condition icons displays the condition in a tooltip.


### Credits

+ __Font__
    + [Semplice Regular][7] by Michael Schmidt
+ __Weather Icons__
    + [Simple Weather Icons][11] by MerlinTheRed


### Preview

[![Preview][100]][12]


[1]: http://www.litestep.net/
[2]: http://www.ls-universe.ls-themes.org/comment.php?comment.news.550
[3]: http://dl.dropbox.com/u/51925/LiteStep/jDesk-0.75.zip
[4]: http://xdocs.ls-universe.ls-themes.org/doku.php?id=litestep:modules:modules
[5]: http://www.ls-themes.org/modules/
[6]: http://www.modules.shellfront.org/
[7]: http://www.style-force.net/work/type/pixelfonts
[8]: http://www.style-force.net/pixelfonts/semp_reg.zip
[9]: http://developer.yahoo.com/geo/geoplanet/guide/concepts.html
[10]: http://weather.yahoo.com/
[11]: http://merlinthered.deviantart.com/art/plain-weather-icons-157162192
[12]: http://github.com/Anomareh/Monolith-LS/raw/master/Extras/Screens/full.jpg

[100]: https://github.com/Anomareh/Monolith-LS/raw/master/Extras/Screens/thumb.jpg