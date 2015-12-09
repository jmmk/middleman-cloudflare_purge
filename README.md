# Middleman::CloudflarePurge

This gem clears your Cloudflare cache. Useful after making changes to a static site.

## Installation

Add this line to your application's Gemfile:

    gem 'middleman-cloudflare_purge'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middleman-cloudflare_purge

## Usage

You need to add the following code to your ```config.rb``` file:

```ruby
activate :cloudflare_purge
```

You can then clear your cache with ```middleman cloudflare_purge```.

##Configuration

There are a few ways to provide the Cloudflare credentials for cloudflare_purge:

#### Through ```.cloudflare_purge``` File (recommended)

You can create a ```.cloudflare_purge``` at the root of your middleman project.
The credentials are passed in the YAML format. The keys match the
options keys. You should then add this file to your ```.gitignore``` so that you don't commit your information.

The .cloudflare_purge file takes precedence to the configuration passed in the
activate method.

A sample ```.cloudflare_purge``` file is included at the root of this repo.

#### Through ```config.rb```

```ruby
activate :cloudflare_purge do |cf|
  cf.token = '11223344aabbccdd1234abcd5678efgh' # Your Cloudflare API token
  cf.email = 'joe@example.com'                  # Email address associated with your Cloudflare account
  cf.domain = 'example.com'                     # Base URL of your site
end
```
