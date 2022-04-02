require "pry"
require "dotenv/load"

# Load helpers
Dir["./lib/helpers/*.rb"].sort.each { require _1 }

# Load application
require "./lib/operations/operation"
Dir["./lib/operations/*.rb"].sort.each { require _1 }
Dir["./lib/events/*.rb"].sort.each { require _1 }
Dir["./lib/**/*.rb"].sort.each { require _1 }
