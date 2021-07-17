# Tests

Integration tests are provided in either the test/integration directory.
For application cookbooks, unit test are provided in either the spec/unit or test/unit directory.

# Running tests

## Integration

Integration tests are run in test Kitchen.

`kitchen test`

## Unit

Unit tests use rspec.

`chef exec rspec`

# Requirements

## Dependencies

For running tests in Test Kitchen a few dependencies must be installed.

If kitchen uses vagrant, then a vagrant environment must be available.

* Install [ChefDK](https://downloads.chef.io/chef-dk)
* Install [Vagrant](https://www.vagrantup.com/downloads.html)
* Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* Install the Vagrant WinRM plugin if the cookbook supports Windows: `vagrant plugin install vagrant-winrm`
* Install the cookbook dependency tree with `berks install`

If kitchen uses EC2, then aws-cli must be installed on the system and a profile configured.
The default region must feature a default vpc for the kitchen ec2 driver to function.
Chef code to set this up may be similar to below.

```ruby
# Assumes Debian-based
package 'python3'
package 'python3-pip'

python_package 'awscli' do
  python '/usr/bin/python3'
end

file '/home/user/.aws/config' do
  owner 'user'
  group 'user'
  content <<~CONTENT
    [profile default]
    region = us-west-2
    output = json
  CONTENT
end

# This key must be setup in AWS
secret = chef_vault_item('aws', 'key')

file '/home/user/.aws/credentials' do
  owner 'user'
  group 'user'
  content <<~CONTENT
    [default]
    aws_access_key_id = #{secret['access_key_id']}
    aws_secret_access_key = #{secret['secret_access_key']}
  CONTENT
end
```

## Platforms and storage

Integration tests run on multiple platforms.
Many vagrant boxes may be added the first time the tests are run.
For cross-platform cookbooks this may entail 90 GB of downloads.

Some platforms are commented out .kitchen.yml.
These platforms were tested and found to not work.
See .kitchen.yml for notes on failures.

## Secrets

Some cookbooks require secrets to be placed in the `test/integration/data_bags` directory.
Such tests typically fail with an HTTP 404 error when the appropriate data bag is not found.
