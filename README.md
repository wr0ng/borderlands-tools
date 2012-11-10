
## Compatibility

Written on/for Ubuntu 12.04 LTS. If you try it in another environment, please let me know how it goes!

## Prerequisites

These scripts depend on the following programs.

- Borderlands
- JACK Audio Connection Kit
- QjackCtl
- rakarrack
- jack_capture
- jack-tools
- xdotools

You can get all of these - except for Borderlands - with the following command:

    TODO

If you haven't obtained and installed Borderlands yet, go here for the primary release, or here for my patch of it. [<-- TODO - LINKS] If you are using Ubuntu, see here for my tutorial on how to obtain the various prerequisites necessary to compile it.




## Recommended configuration

### Rakarrack

By default rakarrack starts with FX off (meaning wet mix 0%) and you have to turn it on manually. Fortunately rakarrack makes it very easy to change this setting:

Settings menu > Preferences > Audio tab > FX On at Start (first option)


## How to customize settings

### Rakarrack

Rakarrack lets you save presets easily. The script defaults to loading `default.rkr` in the `rak_presets` directory. That means you have two ways to change the default preset: either save a new one over this file, or alter the relevant script (`start_rakarrack.sh`).

### In the future ...

I hope to make this group of scripts more configurable. It'd be nice to have a `config.yml` file that is very easy to alter and makes the functionality more flexible.