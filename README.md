# MOTD Chef Status Cookbook

__Maintainer: OIT Systems Engineering__ (<ua-oit-se@alaska.edu>)

## Purpose

This cookbook configures Message of the Day to display system information and Chef status.

* Standard OS, machine, and hostname information
* Chef node name, run success status, last run timing

It also clears some distro-standard MOTD fragments.

MOTD is dynamic on every supported distro.
When it is available and works on the platform, update-motd is used. Otherwise profile is used as a fallback.

The MOTD message is reasonably standard across platforms.
This cookbook does not configure SSH, so any login message will remain.
Effort has been made to remove fragments from standard distributions and cloud-provider fragments, but is it infeasible to remove every possible fragment while respecting attributes that govern their removal.
## Requirements

### Chef

This cookbook requires Chef 13+

### Platforms

Supported Platform Families:

* Debian
  * Ubuntu, Mint
* Red Hat Enterprise Linux
  * Amazon, CentOS, Oracle
* OpenSuse

Platforms validated via Test Kitchen:

* Ubuntu
* Debian
* CentOS
* Oracle
* Fedora
* Amazon
* OpenSuse

Notes:

* This cookbook should support any recent Linux variant with the caveat that it will not clear novel MOTD fragments.

## Resources

This cookbook provides one resources for configuring and installing a MOTD fragment. The fragment will be placed in the appropriate directory and given the appropriate extension for the platform.

### motd_fragment

A motd_fragment manages a single script fragment (file).

__Actions__

Two action are provided.

* `create` - Post condition is that the fragment exists in the appropriate directory to be executed.
* `delete` - Post condition is that the fragment exists in neither /etc/update-motd.d/ nor /etc/profile.d/.

__Attributes__

This resource has four attributes.

* `fragment_name` - Defaults to `nil`. The stem of the fragment file, if nil the name of the resource is used.
* `template_cookbook` - Required. The name of the cookbook where the fragment is located.
* `template_source` - Required. The name of the template to use for the fragment, inside template_cookbook/templates/.
* `template_variables` - Defaults to `{}`.

## Recipes

### motd_chef_status::default

This recipe installs and configures dynamic MOTD by calling all of the other recipes.

__Attributes__

None

### motd_chef_status::install

This recipe installs update-motd on platforms that support it.

__Attributes__

None

### motd_chef_status::remove_fragments

This recipe removes possibly all pre-existing MOTD fragments to keep the login uncluttered and the Che warning prominent.

__Attributes__

* `node['motd_chef_status']['remove_existing_fragments']` - Defaults to `true`. Determines if existing fragments are removed. If false, the attributes below have no effect.
* `node['motd_chef_status']['remove_document_fragments']` - Defaults to `true`. Determines if documentation-related fragments are removed.
* `node['motd_chef_status']['remove_status_fragments']` - Defaults to `false`. Determines if status-related fragments are removed.
* `node['motd_chef_status']['remove_update_fragments']` - Defaults to `false`. Determines is update-related fragments are removed.

### motd_chef_status::add_fragments

This recipe installs possibly two fragments, one a banner and the other a Chef warning and status.

__Attributes__

* `node['motd_chef_status']['add_header_fragment']` - Defaults to `true`. Determines if the header fragment is installed.
* `node['motd_chef_status']['header_position']` - Defaults to `'00'`. Determines the position of the header fragment. The default position places the header before anything else.

* `node['motd_chef_status']['add_chef_fragment']` - Defaults to `true`. Determines if the Chef status/warning fragment is installed.
* `node['motd_chef_status']['chef_status_position']` - Defaults to `'99'`. Determines the position of the Chef fragment.  The default position is at the end of the MOTD.

## Examples

The `motd_fragment` resource can be used as below.

```ruby
motd_fragment 'motd-header' do
  fragment_name '00-header'
  template_cookbook 'my_cookbook'
  template_source 'motd-header.sh.erb'
  template_variables {}
end
```
