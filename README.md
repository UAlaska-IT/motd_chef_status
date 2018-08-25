# MOTD Chef Status Cookbook

__Maintainer: OIT Systems Engineering__ (<ua-oit-se@alaska.edu>)

## Purpose

This cookbook configures Message of the Day to display system information and Chef status

* Standard OS, machine, and hostname information
* Chef node name, run success status, last run timing

It also clears some distro-standard MOTD fragments.

## Requirements

### Chef

This cookbook requires Chef 13+

### Platforms

Supported Platform Families:

* Linux
* BSD

Platforms validated via Test Kitchen:

* Ubuntu
* Debian
* CentOS
* Fedora
* FreeBSD

Notes:

* This cookbook should support any recent Linux variant with the caveat that it will not clear novel MOTD fragments.

## Resources

This cookbook provides no custom resources.

## Recipes

### chef_run_recorder::default

This recipe installs MOTD and configures the fragments.

__Attributes__

Attributes are used mostly to enable fragments and set position.
For all positions, setting the position to nil will disable that fragment.

* `node['motd_chef_status']['system_info_position']` - Defaults to `??`.

## Examples

This is an application cookbook; no custom resources are provided.  See recipes and attributes for details of what this cookbook does.
