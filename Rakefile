require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
task :release => :check_database # ensure that there is a database before releasing

task :check_database do
  raise "Database does not exist!" unless File.exist?(File.expand_path("geo_locator.sqlite3", File.dirname(__FILE__)))
end

task :create_database do
  require "sqlite3"

  database_name = "geo_locator.sqlite3"
  plz_tab_url = "http://fa-technik.adfc.de/code/opengeodb/PLZ.tab"
  raw_plz_tab = Net::HTTP.get(URI(plz_tab_url))
  plz_tab = raw_plz_tab
    .split("\n")
    .delete_if { |line| line[0] == "#" }
    .map! { |line| line.split("\t") }

  unless File.exist?(File.expand_path(database_name, File.dirname(__FILE__)))
    db = SQLite3::Database.new(database_name)
    db.execute("CREATE TABLE IF NOT EXISTS locations(loc_id INTEGER PRIMARY KEY, zip_code INTEGER, lon REAL, lat REAL, location TEXT)")
    db.execute("CREATE UNIQUE INDEX 'loc_id_UNIQUE' ON 'locations' ('loc_id')")
    db.execute("CREATE INDEX 'location' ON 'locations' ('location')")
    db.execute("CREATE INDEX 'zip_code' ON 'locations' ('zip_code')")

    plz_tab.each do |line|
      db.execute("INSERT INTO locations VALUES(#{line[0]}, #{line[1]}, #{line[2]}, #{line[3]}, '#{line[4]}')")
    end
  else
    puts "Database already exists!"
  end
end
task :create_db => :create_database # alias for the command line
