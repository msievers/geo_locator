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
2.1.0 :002 > GeoLocator.locate(zip_code: 10115)
 => [{:lat=>52.5337069545604, :lon=>13.387223860255}]
```

You can use the `format` option to specify, how the coordinates should be returned. This is useful for example for elasticsearch. Supported values are `:array`, `:hash`, `:string`.

```ruby
2.1.0 :003 > GeoLocator.locate(zip_code: 10115, format: :array)
 => [[13.387223860255, 52.5337069545604]]
2.1.0 :004 > GeoLocator.locate(zip_code: 10115, format: :hash)
 => [{:lat=>52.5337069545604, :lon=>13.387223860255}]
2.1.0 :005 > GeoLocator.locate(zip_code: 10115, format: :string)
 => ["52.5337069545604,13.387223860255"]
```

### Instantiating GeoLocator

`GeoLocator` provides a class level `locate` method. Due to it's stateless nature, it cannot reuse internal database connections or cache requested coordinates. If you want this kind of optimizations, create an instance of `GeoLocator`, which provides a `locate` method with the same semantic as the class level method.

Actually, the class level `locate` creates a new instance of `GeoLocator` and calls `locate` on it, internally.

## Limitations

* only locations in Germany are supported
* retrival of geo locations is only possible based on zip codes or city names

## Contributing

1. Fork it ( http://github.com/<my-github-username>/geo_locator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

This gem is based on data provided by OpenGeoDB (http://www.opengeodb.org).
