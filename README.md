# borderlands-tools

The main function of borderlands-tools is  to launch [Borderlands granular](https://ccrma.stanford.edu/~carlsonc/256a/Borderlands/) with some auxiliary programs: QjackCtl, Rakarrack effects rack, and Audacity. Using borderlands-tools, it should take about 10 seconds to get playing, or about 30 seconds if you're starting a backtrack and recording your session.

The scripts are not that fancy or clever, but I find that the less time taken between inspiration and action, the better - especially when it comes to music.

You'll need to install prerequisites and/or configure a few things before starting, but for the impatient here's how you'll use the two utilities in this package.

## ![BorderlandsLauncher][launcher] Instant granification 

The first utility is called **BorderlandsLauncher**. This is how you'll use it if you're just playing. 

1. Click the launcher icon.
2. Start playing!

This is how you'll use it if you're playing over a backtrack and/or recording your session.

1. Click the BorderlandsLauncher icon.
2. Get Audacity rolling.
  * Switch to the Audacity window. (To un-maximize Borderlands press `o`.)
  * To configure Audacity, set audio host to JACK, output device to system, and input device to rakarrack. Don't know where to change these settings? See below.
  * Open or import your backtrack if you desire.
  * Click record. This will also start playback.
3. Switch back to the Borderlands window (and press `o` to maximize it again if necessary). 
4. Start playing!

![Configuring audacity][audacity]

After you've finished playing, you'll switch back to Audacity and export or save as necessary. Then you can switch windows to the borderlands-tools terminal and press any key to quit all programs.

[launcher]: http://imageshack.us/a/img708/4969/borderlandslauncherscre.png
[audacity]: http://img195.imageshack.us/img195/8540/configuringaudacityhelp.png

#### Less-effects mode

By right clicking the BorderlandsLauncher icon you also get an option to launch the setup without Rakarrack.

## ![BorderlandsLoopManager][loop] Managing loops

The second utility is called **BorderlandsLoopManager** and it looks like this:

It has two functions:

* You can drag `.wav` and `.aiff` files onto it, and they will be made available to Borderlands. (Symbolic links to the files will be made in Borderlands's `loops` folder.)
* There is a button in the right-click menu to clear the Borderlands `loops` folder. This only destroys links, and affects none of your audio files.

[loop]: http://imageshack.us/a/img189/9145/borderlandsloopmanagers.png

----------------------------------------------------------

# How to set up borderlands-tools

It's written on/for Ubuntu 12.04 but it should work anywhere there's bash, as long as you install the prerequisites. Regardless of your environment, please report any issues you have with setup and I'll be glad to help troubleshoot and make fixes.

If you want to use this somewhere besides Ubuntu, note that `main.sh`, `loop_add.sh`, and `loops_clear.sh` are the scripts you should be running: they are the ones that get called by the Unity Launchers.

## 1. Install prerequisites

These scripts depend on the following programs.

- Borderlands
- JACK Audio Connection Kit
- QjackCtl
- rakarrack
- Audacity

You should be able to get all of these - except for Borderlands - with the following command:

    sudo apt-get install qjackctl jackd2 libjack-jackd2-dev rakarrack audacity

### Haven't installed Borderlands?

If you haven't installed Borderlands yet, go [here](https://ccrma.stanford.edu/~carlsonc/256a/Borderlands/) for the primary (open source) release, or [here](https://github.com/hangtwenty/borderlands-granular-pitch-patch) for my little patch of it. If you are using Ubuntu 12.04, see [here](http://hangtwenty.ruhoh.com/posts/building-borderlands-granular-on-ubuntu-12-04-lts) for my tutorial on how to obtain the various prerequisites necessary to compile it.

## 2. Run the setup script

The setup is quick and easy.

First get borderlands-tools and put it in `~/bin/borderlands-tools`. In a terminal:

    cd ~/bin/
    git clone https://github.com/hangtwenty/borderlands-tools/

(You can also put it somewhere else and change the `borderlands_tools_dir` setting in the configuration file, `config.cfg`.)

Next run the setup script:

    cd ~/bin/borderlands-tools/ # or wherever else you put it
    bash setup.sh

It will create two Unity Launchers named **BorderlandsLauncher** and **BorderlandsLoopManager**. Then it copies these into `~/.local/share/applications` and open a nautilus file browser in that folder.

Drag the two icons onto your launcher. You may or may not need to right-click them and click *Lock to Launcher*.

(`~/.local/share/applications` is where Ubuntu stores Unity Launchers for your user. If you want these icons to appear for all users, move these Unity Launchers to `/usr/share/applications` and then drag them onto the launcher.)

## 3. Configure Rakarrack

By default rakarrack starts with effects off, meaning you would have to turn effects on manually each time you open it. Fortunately Rakarrack makes it very easy to change this:

    Settings menu 
      > Preferences
        > Audio tab
          > FX On at Start (first option)

I would also recommend turning down the master output a few decibels to prevent clipping.

### That's it

You are now ready to use the BorderlandsLauncher and BorderlandsLoopManager now. Have fun!

---------------------------------------------------------

# To get the most out of borderlands-tools

## Configure borderlands-tools

### config.cfg

In this repository there is a file `config.cfg`. It contains several settings that you can adjust to your needs. Notably, you can specify where your copy of Borderlands lives, and you can make it so that the "clear loops" function just executes without asking you if you're sure (my preference).

## Add a keyboard shortcut to display Borderlands keybindings

Most of the cool stuff you can do with Borderlands is through keyboard controls. There are a good amount of them, so it takes a bit to memorize. This could be prohibitive, so to overcome this, you can make a keyboard shortcut that displays Borderlands' keyboard controls. Configure a keyboard shortcut to call the following command:

    bash </path/to/borderlands-tools>/keybindings_display.sh

Insert your own path, like `/home/m/bin/borderlands-tools/keybindings_display.sh`. (Note that `~/bin/...` and `$HOME/bin/...` will NOT work right if you are using the Ubuntu keyboard shortcuts editor.) 

The advantage of binding a keyboard shortcut to this is that you can then accessit easily in the middle of a Borderlands session. The shortcut I use is `Ctrl + Shift + O` (that's the letter not a zero). Pressing return should close the notification regardless of your personal shortcut.

**This is not a substitute for the official documentation!** This command displays my own abbreviation of the author's documentation on the controls. This feature should only serve as a reminder - go to [the official documentation](https://ccrma.stanford.edu/%7Ecarlsonc/256a/Borderlands/) for complete instructions and read those before you rely on these.

## Harness the power of Ubuntu window-switching-fu

If you don't already know this, holding `Super` in Ubuntu will present you with a bunch of super useful keyboard shortcuts. (The `Super` key is the 'operating system' key, with a Windows, Mac, or another logo.)

Below are the shortcuts I find most useful for working with Linux audio. It seems that all the open source audio tools I use have their own little windows, and it can get unmanageable quickly.

* `Super + W` spreads all windows in the current workspace
* `Ctrl + Tab` and the cursor keys lets you switch between applications
* `Alt + F4` closes the current window (and exits the program)

Then there are these *extra* productive keyboard shortcuts for moving things among workspaces. I like to spread all of the windows opened by borderlands-tools to three different workspaces, to minimize layering and make it absolutely easy to switch between Borderlands and Rakarrack. (I tried to automate this process but it can't be done easily in a portable way.)

* `Ctrl + Alt + cursor keys` to switch workspaces
* `Ctrl + Alt + Shift + cursor keys` to switch workspaces and *bring the active window with you*.

## Make Rakarrack load your own preset bank every time

~~Rakarrack lets you save presets easily. BorderlandsLauncher automatically loads the preset named `default.rkr` in the `rak_presets` directory on launch. If you want to change the default preset, simply overwrite this file with another.~~

I have not been able to get Rakarrack to load presets from the commandline in a predictable fashion. Instead, Rakarrack seems to always just load the preset bank specified in the Rakarrack settings, and load the individual preset with the *number* you had open last time you used Rakarrack.

So for example you might modify preset number 7 from the factory bank and then click use Rakarrack's buttons to 'save preset', and save it somewhere. But next time you open rakarrack it will load number 7 from the factory bank, not the last actual preset you used.

This leaves you with a few options for controlling the default preset it loads. First, you could switch to the Rakarrack window and dial in new settings every time. Second, you could work with the factory preset bank and save new presets there, by saving the actual *bank* every time you want to save changes to a preset. Third - which seems preferable - you could make a new bank for working with Borderlands, and save that bank whenever you make changes to its presets.

I have provided a bank in the `rak_presets` directory for just this purpose. To make Rakarrack load it by default, go into its preferences like so:

    Settings menu
      > Preferences
        > Bank
          > Bank Filename
            > Browse
              # ~/bin/borderlands-tools/rak_presets/bank.rkrb

Then you can save all your own presets to this bank. Of course you can also keep it somewhere else, but you may need to go through Rakarrack's interface to initially save the bank somewhere.

----------------------------------------------------

# About this package

## Disclaimer

I wrote this because it was imminently useful to me and to a friend. It doubled as my first adventure into bash scripting. I wasn't able to achieve everything I wanted with it and had to roll back some features that would have made this much more fancy. It has only been tested on Ubuntu 12.04.

## Incomplete work

### Being able to use terminal-based playback and recording

This would be an extremely processor efficient, and it was my original intention for the package. However I haven't been able to get the JACK connections to persist between launches in a predictable fashion.

### Being able to use a different effects unit

Currently only one is supported: Rakarrack. I have tried to set this up in a modular fashion, and in the future I would like to have other options in the BorderlandsLauncher, to let you launch PureData, Processing, and/or JACK Effects Rack as an effects unit. Hopefully even combinations thereof.

## License

Released under the MIT license. See LICENSE in this repository.