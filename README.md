# borderlands-tools

The main function of borderlands-tools is  to launch [Borderlands granular](https://ccrma.stanford.edu/~carlsonc/256a/Borderlands/) with some auxiliary programs: QjackCtl, Rakarrack effects rack, and Audacity. Using borderlands-tools, it should take about 10 seconds to get playing, or about 30 seconds if you're starting a backtrack and recording your session.

The scripts are not that fancy or clever, but I find that the less time taken between inspiration and action, the better - especially when it comes to music.

You'll need to install prerequisites and/or configure a few things before starting, but for the impatient here's how you'll use the two utilities in this package.

## 1. Instant granification

This is how you'll use the first utility if you're just playing.

1. Open **BorderlandsLauncher** by clicking its launcher icon. ![BorderlandsLauncher][launcher]
2. Start playing!

This is how you'll use it if you're playing over a backtrack and/or recording your session.

1. Open **BorderlandsLauncher** by clicking its launcher icon. ![BorderlandsLauncher][launcher]
2. Get Audacity rolling.
  * Switch to the Audacity window. (To un-maximize Borderlands press `o`.)
  * To configure Audacity, set audio host to JACK, output device to PulseAudio JACK Source, and input device to PulseAudio JACK Sink. ![Configuring audacity][audacity]
  * Open or import your backtrack if you desire.
  * Click record. This will also start playback.
3. Switch back to the Borderlands window (and press `o` to maximize it again if necessary). 
4. Start playing!

After you've finished playing, you'll switch back to Audacity and export or save as necessary. Then you can switch windows to the borderlands-tools terminal and press any key to quit all programs.

[launcher]: icons/BorderlandsLauncherScreenshot.png
[audacity]: ConfiguringAudacityHelp.png

#### Less-effects mode

By right clicking the BorderlandsLauncher icon you also get an option to launch the setup without Rakarrack.

## 2. Managing loops

The second utility is called **BorderlandsLoopManager**.

![BorderlandsLauncher][loop]

It has two functions:

* You can drag `.wav` and `.aiff` files onto it, and they will be made available to Borderlands. (Symbolic links to the files will be made in Borderlands's `loops` folder.)
* There is a button in the right-click menu to clear the Borderlands `loops` folder. This only destroys links, and affects none of your audio files.

[loop]: icons/BorderlandsLoopManagerScreenshot.png

# How to set up borderlands-tools

It's written on/for Ubuntu 12.04 but it should work anywhere there's bash, as long as you install the prerequisites.[1] Regardless of your environment, please report any issues you have with setup and I'll be glad to help troubleshoot and make fixes.

[1]: If you want to use this somewhere besides Ubuntu, note that `main.sh`, `loop_add.sh`, and `loops_clear.sh` are the scripts you should be running: they are the ones that get called by the Unity Launchers.

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

It will create two Unity Launchers (files with the `.desktop` extension) named **BorderlandsLauncher** and **BorderlandsLoopManager**. It will then copy these into the folder where Ubuntu stores Unity Launchers (`~/.local/share/applications`) and open a nautilus file browser in that folder.

Drag **BorderlandsLauncher** and **BorderlandsLoopManager** onto your launcher. You may need to right-click them and click *Lock to Launcher*.

## 3. Configure Rakarrack

By default rakarrack starts with FX off (meaning wet mix 0%) and you have to turn FX on manually, each time you open it. Fortunately Rakarrack makes it very easy to change this setting:

    Settings menu 
      > Preferences
        > Audio tab
          > FX On at Start (first option)

I would also recommend turning down the master output a few decibels to prevent clipping..

## You're done!

You are absolutely ready to use the BorderlandsLauncher and BorderlandsLoopManager now. Have fun!

# Optional: configuring borderlands-tools

## config.cfg

In this repository there is a file `config.cfg`. It contains several settings that you can adjust to your needs. Notably, you can specify where your copy of Borderlands lives, and you can make it so that the "clear loops" function just executes without asking you if you're sure (my preference).

## Rakarrack default preset

Rakarrack lets you save presets easily. BorderlandsLauncher automatically loads the preset named `default.rkr` in the `rak_presets` directory on launch.

If you want to change the default preset, simply overwrite this file with another.

# Tip: Ubuntu window-switching-fu

If you don't already know this, holding `Super` in Ubuntu will present you with a bunch of super useful keyboard shortcuts. (The `Super` key is the 'operating system' key, with a Windows, Mac, or another logo.)

Below are the shortcuts I find most useful for working with Linux audio. It seems that all the open source audio tools I use have their own little windows, and it can get unmanageable quickly.

* `Super + W` spreads all windows in the current workspace
* `Ctrl + Tab` and the cursor keys lets you switch between applications
* `Alt + F4` closes the current window (and exits the program)

Then there are these *extra* productive keyboard shortcuts for moving things among workspaces. I like to spread all of the windows opened by borderlands-tools to three different workspaces, to minimize layering and make it absolutely easy to switch between Borderlands and Rakarrack. (I tried to automate this process but it can't be done easily in a portable way.)

* `Ctrl + Alt + cursor keys` to switch workspaces
* `Ctrl + Alt + Shift + cursor keys` to switch workspaces and *bring the active window with you*.

# About this package

## No guarantees!

I wrote this because it was imminently useful to me and to a friend. It doubled as my first adventure into bash scripting. I wasn't able to achieve everything I wanted with it and had to roll back some features that would have made this much more fancy. It has only been tested on Ubuntu 12.04.

## Incomplete work (that may or may not come to fruition)

### Being able to use terminal-based playback and recording

This would be an extremely processor efficient, and it was my original intention for the package. However I haven't been able to get the JACK connections to persist between launches in a predictable fashion.

### Being able to use a different effects unit

Currently only one is supported: Rakarrack.

I have tried to set this up in a modular fashion, and in the future I would like to have launcher options for using PureData, Processing, and/or JACK Effects Rack as an extra. Hopefully even chaining.

## License

Released under the MIT license. See LICENSE in this repository.