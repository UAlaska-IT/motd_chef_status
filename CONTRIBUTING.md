# Uniformity

This project lints code with both Rubocop and Foodcritic.
The purpose is to encourage uniformity within the project and with community standards for Ruby and Chef.
Disabling checks is discouraged, and developers should have a good reason for doing so.

# Code review

Development should follow [GitHub Flow](https://guides.github.com/introduction/flow/) to foster some shared responsibility.
Test-driven development is encouraged to ensure comprehensive coverage, but at a minimum tests should reasonably cover all changes.

* Fork/branch the repository
* Write InSpec tests (`kitchen test`)
* For application cookbooks, write ChefSpec tests (`chef exec rspec`)
* Make changes to fix all test errors
* Fix all lint offenses (`make lint`)
* Submit a Pull Request on Github
* Wait for feedback and merge from a second developer

# Release to marketplace

A multistep process is required to release a cookbook on the Chef marketplace.

1. Merge the PR in github.com/ualaska-it/<cookbook-name>
1. Clone a fresh repo and move to the root of that repo
    * This is important to prevent secret spillage and superfluous uploads
1. Tag the release, `make tag`
1. Push the tag, `make tag-push`
    * The tag should exist before sharing the cookbook
1. Enable the knife config for chef marketplace (see below)
1. Upload the cookbook, `make share`

The knife config in `/path/to/cookbook/repo/.chef/knife.rb` for the chef marketplace should be similar to below.

```ruby
current_dir = File.dirname(__FILE__)
user = 'ualaska'
knife[:vault_mode] = 'client'
log_level       :info
log_location    STDOUT
node_name       user
client_key      "#{current_dir}/#{user}.pem"
chef_server_url "https://supermarket.chef.io"
cookbook_path   ["#{current_dir}/.."]
```

Contact `ualaska-se` users for the `ualaska.pem` secret.
