# This is the old version of the README file

This is the older, unfinished draft of the README for the initial release. It pertains to the ideal set up where jack.play and jack_capture are used together to do playback and recording. These are text-based tools, so they're very lightweight. Unfortunately I hit a complete wall where QJackCtl would go nuts, cycle through all of the connections - connecting and disconnecting them almost randomly - and throw a ton of errors ... no matter how I tweaked the 'patchbay' (except disconnecting the essential connections).

Anyways, I'm making the default be audacity, and retiring the use of jack.play and jack_capture until some other time.

## Goal

The goal is to make it easy to start playing with and recording Borderlands granular synth on Ubuntu. Running it using the Unity Launcher icon - or with the command `bash main.sh -x rak` - opens up a rack like this:

     Borderlands synth -> Rakarrack effects rack -
                                                  \    Levels meters,
                                                   =>  Recording,
                                                  /    and system sound out
                         Playback of a backtrack -

In prose, this setup is: Borderlands synth being fed into Rakarrack effects rack, alongside playback of a backtrack (via jack-tools), both streams being fed into three outputs: levels meters (via meterbridge), recording (via jack_capture), and the system sound output. All of it is patched together using QjackCtl to manage the JACK Audio Connection Kit.

It can get very repetitive to start all of this up manually every time you want to play with Borderlands. Hopefully this fixes that.

### Scope

This was supposed to (a) make my life and a friend's life easier and (b) be a first dive into bash scripting. As such it took an inordinate amount of time to write ... and probably has a lot of room for improvement. I'm putting it up here on the off-chance that it's helpful to someone else. At the moment it has only been tested in my own environment and for my own purposes, with limited time. But if you use it and find issues or room for improvement please report them, as I will be continuing to work on this.

### Incomplete work

#### Synchronized recording of backtrack and jams

In order to minimize discrepancies between the backtrack and the newly recorded Borderlands output, I aimed to record the backtrack and Borderlands into the same output file. The output would be a `.wavex` file with 4 channels, and so we'd have a recording which keeps the backtrack and Borderlands completely in sync.

Unfortunately it seems like QjackCtl's Patchbay functionality is a limiting factor here. I was able to send the two tracks to jack_capture together, but was not able to keep them separate (i.e. the resulting output was four channels, two of them with BOTH streams mixed, and two empty ones).

This is the next issue I'd like to address with this script, so hopefully I can find the time.

As a workaround, you can do the playback-and-recording with Audacity. Note that on my system, however, that incurs some clicks and so on to happen. This is the reason I went with lightweight, console-based playback and recording tools. Everything's a trade-off I guess!

#### Being able to (a) not use rakarrack or (b) use a different "extra"

This *currently* comes packaged with the appropriate QjackCtl patchbay preset to automatically connect all the programs launched - to get going! - *if* you are using rakarrack. That's the primary use case I imagined.

However as of v0.1 it does not come packaged with any other QjackCtl presets. So, if you want to *not* use rakarrack, you'll have to wire the patchbay yourself.

## Setting up borderlands-tools

### Compatibility

Written on/for Ubuntu 12.04 LTS. If you try it in another environment, please let me know how it goes!

### Prerequisites

These scripts depend on the following programs.

- Borderlands
- JACK Audio Connection Kit
- QjackCtl
- rakarrack
- jack_capture
- jack-tools
- xdotools

You can get all of these - except for Borderlands - with the following command:

    sudo apt-get install qjackctl rakarrack jack_capture jack-tools xdotools

If you haven't obtained and installed Borderlands yet, go [here](https://ccrma.stanford.edu/~carlsonc/256a/Borderlands/) for the primary (open source) release, or [here](https://github.com/hangtwenty/borderlands-granular-pitch-patch) for my little patch of it. If you are using Ubuntu 12.04, see [here](http://hangtwenty.ruhoh.com/posts/building-borderlands-granular-on-ubuntu-12-04-lts) for my tutorial on how to obtain the various prerequisites necessary to compile it.

### How to use borderlands-tools

1) Open borderlands-tools by double-clicking its icon
2) A bunch of things will open! It should come to rest with Borderlands full-screen and on top. (This is just how Borderlands opens by default and unfortunately neither `wmctrl` nor `xdotools` can get around this!)
3) Click anywhere in Borderlands to focus it.
4) Press the `o` key (letter o, not zero). This is the keyboard shortcut to un-maximize Borderlands.
5) Look for the borderlands-tools terminal. It has printed out a list of backtracks and is asking you which one you want to use.
6) Type the number of the desired backtrack.
7) Windows will flash around again as jack.play and jack_capture open, ending with Borderlands up in front.
8) Click back in Borderlands window and press `o` again to maximize.
9) Start playing!
...
10) To finish, switch back to borderlands-tools window, and press any key. It will close all of the programs it opened in a graceful order, and hopefully none of them will give you warnings :)

This is just how I go about it, but there are other ways you could do it depending on how you like to switch between windows. `Super + W` is another good way to switch between windows. (`Super` is the Windows or Mac key, etc.) 

You can find your recordings in the `recorded` directory of this repository. (TODO: Make this configurable.)

## Recommended Rakarrack configuration

By default rakarrack starts with FX off (meaning wet mix 0%) and you have to turn it on manually. Fortunately rakarrack makes it very easy to change this setting:

Settings menu > Preferences > Audio tab > FX On at Start (first option)

## How to customize settings of borderlands-tools

### config.cfg

In this repository there is a file `config.cfg`. It contains several settings that you can adjust to your needs. Notably, you can change the path to Borderlands on your system, and the folder that the script looks in for backtracks.

### Rakarrack default preset

Rakarrack lets you save presets easily. The script defaults to loading `default.rkr` in the `rak_presets` directory. That means you have two ways to change the default preset: either save a new one over this file, or alter the relevant script (`start_rakarrack.sh`).

## License

Release under the MIT license. See LICENSE in this repository.