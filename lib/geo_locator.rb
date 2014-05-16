require "sqlite3"

class GeoLocator
  require "geo_locator/version"

  class << self
    private
    def _locate(options = {})
      unless db = (options[:db] || options["db"])
        raise ArgumentError, "Options do not contain a db connection!"
      end

      location = options[:location] || options["location"]
      zip_code = options[:zip_code] || options["zip_code"]

      unless location || zip_code
        raise ArgumentError, "Options do not contains neither location nor zip_code!"
      end

      options[:format] = :hash unless options[:format] || options["format"]

      db_result = db.execute("SELECT lat, lon FROM locations WHERE #{location ? 'location LIKE \'' + location + '\'' : ''} #{location && zip_code ? 'AND' : ''} #{zip_code ? 'zip_code = \'' + zip_code.to_s + '\'' : ''}")

      db_result.map! do |row|
        lat = row[0]
        lon = row[1]

        case options[:format]
          when :array  then [lon, lat] # order conforms to GeoJSON and is supported as such be elasticsearch
          when :hash   then { lat: lat, lon: lon  }
          when :string then "#{lat},#{lon}"
        end
      end
    end
  end

  def self.locate(options = {})
    self.new.locate(options)
  end

  def initialize(options = {})
    @db = SQLite3::Database.open(File.expand_path("../geo_locator.sqlite3", File.dirname(__FILE__)))
    @format = options[:format] || options["format"] || :hash
  end

  def locate(options = {})
    options[:db] = @db
    options[:format] = options[:format] || options["format"] || @format

    self.class.send(:_locate, options)
  end

end
