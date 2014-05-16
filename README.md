# GeoLocator [![Dependency Status](https://gemnasium.com/msievers/geo_locator.svg)](https://gemnasium.com/msievers/geo_locator)

A gem which packages a offline database to geocode zip codes and locations without the need for an external web service.

## Installation

Add this line to your application's Gemfile:

    gem 'geo_locator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install geo_locator

## Usage

```ruby
$ irb
2.1.0 :001 > require "geo_locator"
 => true
2.1.0 :002 > GeoLocator.locate(zip_code: 12681)
 => [{:lat=>52.5392572203694, :lon=>13.5398499484887}]
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/geo_locator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
