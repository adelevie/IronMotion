# IronMotion

A RubyMotion wrapper for [Iron.io's](http://iron.io) REST API.

So far, only [IronWorker](http://www.iron.io/products/worker) is partially supported.

## Installation

Add this line to your application's Gemfile:

    gem 'iron-motion'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install iron-motion

## Usage

```ruby

IronMotion.init(:oauth_token => "12345thisisanoauthtoken6789")
projects = IronMotion::Projects.all
project = projects.first
project.getTasks do |tasks|
	puts tasks.first.id
	puts tasks.first.code_name
end
project.getCodes do |codes|
	puts codes.first.id
	puts codes.first.name
end

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
