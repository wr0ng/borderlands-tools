# What borderlands-tools does

The main function of borderlands-tools is  to launch [Borderlands granular](https://ccrma.stanford.edu/~carlsonc/256a/Borderlands/) with some auxiliary programs: JACK (using QjackCtl), Rakarrack (an effects rack), and Audacity. Using borderlands-tools, it should take about 10 seconds to get playing with Borderlands, or about 30 seconds if you're playing over a backtrack and recording your session.

The scripts are not that fancy or clever, but I find that the less time taken between inspiration and action, the better (especially when it comes to music).

You'll need to install prerequisites and/or configure a few things before starting, but for the impatient here's how to use the two utilities in this package.

## Instant granification

This is how you'll use the first utility.

1. Open BorderlandsLauncher by clicking its launcher icon.
2. Get Audacity going if you wish to play over something or record your session. Otherwise skip to step 3.

    a. Switch to the Audacity window. (To un-maximize Borderlands press `o`.)

    b. To configure Audacity, set audio host to JACK, output device to PulseAudio JACK Source, and input device to PulseAudio JACK Sink. TODO: Add screenshot

    c. If you desire to record over another track, open or import it now.

    d. Click record. This will start playback and recording in sync.

3. Switch back to the Borderlands window (and press `o` to maximize it again if necessary). 

4. Start playing!

After you've finished playing, you'll switch back to Audacity and export or save as necessary. Then you can switch windows to the borderlands-tools terminal and press any key to quit all programs.

#### Less effects mode

By right clicking the BorderlandsLauncher icon you also get an option to launch the setup without Rakarrack.

## Managing loops

The second utility is called BorderlandsLoopManager. It has two functions:

* You can drag `.wav` and `.aiff` files onto it, and they will be made available to Borderlands. (Symbolic links to the files will be made in Borderlands's `loops` folder.)
* There is a button in the right-click menu to clear the Borderlands `loops` folder. This only destroys links, and affects none of your audio files.

# Setting up borderlands-tools

## Compatibility

Written on/for Ubuntu 12.04 but it should work anywhere there's bash, as long as you install the prerequisites (Borderlands, Rakarrack, etc. - see below).

## Install prerequisites

These scripts depend on the following programs.

- Borderlands
- JACK Audio Connection Kit
- QjackCtl
- rakarrack
- Audacity

You should be able to get all of these - except for Borderlands - with the following command:

    sudo apt-get install qjackctl jackd2 libjack-jackd2-dev rakarrack audacity
### Need to install Borderlands?

If you haven't installed Borderlands yet, go [here](https://ccrma.stanford.edu/~carlsonc/256a/Borderlands/) for the primary (open source) release, or [here](https://github.com/hangtwenty/borderlands-granular-pitch-patch) for my little patch of it. If you are using Ubuntu 12.04, see [here](http://hangtwenty.ruhoh.com/posts/building-borderlands-granular-on-ubuntu-12-04-lts) for my tutorial on how to obtain the various prerequisites necessary to compile it.

## Run the setup script

Setting up borderlands-tools is quick and easy.

First you need to either put the `borderlands-tools` repository in `~/bin/borderlands-tools`, or put it somewhere else and change the appropriate setting in the configuration file, `config.cfg`.

Next open a terminal and enter:

    cd ~/bin/borderlands-tools/ # or wherever else you put it
    bash setup.sh

It will create two Unity Launchers (files with the `.desktop` extension), `BorderlandsLauncher` and `BorderlandsLoopManager`. It will then copy these into `~/.local/share/applications`, the folder where Ubuntu stores your user's Unity Launchers, and open a nautilus file browser in that folder.

Drag `BorderlandsLauncher` and `BorderlandsLoopManager` onto your launcher. Lastly right click them and click "Lock to Launcher" if necessary.

## Configure Rakarrack

By default rakarrack starts with FX off (meaning wet mix 0%) and you have to turn FX on manually, each time you boot. Fortunately Rakarrack makes it very easy to change this setting:

Settings menu > Preferences > Audio tab > FX On at Start (first option)

I would also recommend turning down the master output a few decibels so that cliclipping isn't a risk.

## That's it

You are absolutely ready to use the BorderlandsLauncher and BorderlandsLoopManager now. Have fun!

# Configuring borderlands-tools (optional)

## config.cfg

In this repository there is a file `config.cfg`. It contains several settings that you can adjust to your needs. Notably, you can specify where your copy of Borderlands lives, and you can make it so that the "clear loops" function just executes without asking you if you're sure (my preference).

## Rakarrack default preset

Rakarrack lets you save presets easily. The script defaults to loading `default.rkr` in the `rak_presets` directory. That means you have two ways to change the default preset: either save a new one over this file, or alter `start_rakarrack.sh` to load a different preset.

# Ubuntu window-switching-fu

If you don't already know this, holding `Super` in Ubuntu will present you with a bunch of super useful keyboard shortcuts. (The `Super` key is the 'operating system' key, with a Windows, Mac, or another logo.)

These are the shortcuts I find most useful for working with Linux audio. (It seems that all the tools I use have their own little windows, and it can get messy quick.)

* `Super + W` spreads all windows in the current workspace
* `Ctrl + Tab` and the cursor keys lets you switch between applications
* `Alt + F4` closes the current window (and exits the program)

Then there are these extra productive keyboard shortcuts for moving things among workspaces. I like to spread all of the windows opened by borderlands-tools to three different workspaces, to minimize layering. (I tried to automate this process but it looks like it's not very portable - what would work for me wouldn't necessarily work for you).

* `Ctrl + Alt + cursor keys` to switch workspaces
* `Ctrl + Alt + Shift + cursor keys` to switch workspaces and *bring the active window with you*.

# Stuff about the package (TLDR)

## No guarantees!

I wrote this because it was imminently useful to me and to a friend. It doubled as my first adventure into bash scripting. I wasn't able to achieve everything I wanted with it and had to roll back some features that would have made this much more fancy. It has only been tested on Ubuntu 12.04.

## Incomplete work (that may or may not come to fruition)

### Being able to use text-based playback and recording

This would use less computation, and was the original intention for the package. However I haven't been able to get the JACK connections to persist between launches in a predictable fashion.

### Being able to use a different "extra"

This *currently* comes packaged with the appropriate QjackCtl patchbay preset to automatically connect all the programs launched - to get going! - *if* you are using rakarrack. That's the primary use case I imagined.

However as of v0.1 it does not come packaged with any other QjackCtl presets. So, if you want to *not* use rakarrack, you'll have to wire the patchbay yourself.

## License

Released under the MIT license. See LICENSE in this repository.