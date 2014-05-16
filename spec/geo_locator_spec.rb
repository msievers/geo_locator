require_relative "./spec_helper"

describe GeoLocator do
  let(:database_path) { File.expand_path("./geo_locator_test.sqlite3", File.dirname(__FILE__)) }

  it "is a class" do
    expect(GeoLocator.class).to be(Class)
  end

  describe ".locate" do
    it "is a class level proxy for the class method _locate without the need for instantiation" do
      expect(GeoLocator).to respond_to(:locate)
    end

    it "returns a array of geo locations if a zip_code is given" do
      expect(GeoLocator.locate(zip_code: 33100)).to eq([{:lat=>51.7240488542403, :lon=>8.82975311690181}])
    end
  end

  describe ".new" do
    let(:geo_locator) { GeoLocator.new }

    it "creates an instance of GeoLocator to memoize the internal database connection" do
      expect(geo_locator).to be_a(GeoLocator)
    end

    describe "#locate" do
      it "is an instance level proxy for the class method _locate" do
        expect(geo_locator).to respond_to(:locate)
      end

      it "returns a array of geo locations if a zip_code is given" do
        expect(GeoLocator.locate(zip_code: 33100)).to eq([{:lat=>51.7240488542403, :lon=>8.82975311690181}])
      end
    end
  end

  #
  # private methods used internally
  #
  describe "._locate" do
    let(:db) { SQLite3::Database.open(database_path) }

    it "is a private class method used internally by the various locate methods" do
      expect(GeoLocator.private_methods.include?(:_locate)).to eq(true)
      expect { GeoLocator._locate }.to raise_error(NoMethodError)
    end

    it "expects a sqlite3 database named geo_locator.sqlite3 in the gems root dir" do
    end

    it "needs to be called with a database connection" do
      expect { GeoLocator.send(:_locate) }.to raise_error(ArgumentError)
    end

    it "returns a array of geo locations if only db and zip_code is given" do
      expect(GeoLocator.send(:_locate, db: db, zip_code: 33100)).to eq([{:lat=>51.7240488542403, :lon=>8.82975311690181}])
    end

    it "returns a array of geo locations if only db and location is given" do
      expect(GeoLocator.send(:_locate, db: db, location: "Schwerin")).to eq([{:lat=>53.6247393347882, :lon=>11.4081221498717}, {:lat=>53.6577581258256, :lon=>11.4356781728688}, {:lat=>53.6517809563862, :lon=>11.3497453888959}, {:lat=>53.6360865636739, :lon=>11.3920850320353}, {:lat=>53.6021672992816, :lon=>11.4110439798182}, {:lat=>53.5808291697605, :lon=>11.4498483787143}])
    end
  end 
end
