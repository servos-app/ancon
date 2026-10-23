require_relative "lib/ancon/version"

Gem::Specification.new do |spec|
  spec.name = "ancon"
  spec.version = Ancon::VERSION
  spec.authors = ["SERVOS"]
  spec.email = ["a@asgerbehnckejacobsen.dk"]

  spec.summary = "Ruby client for the Ancon public core API (v1)"
  spec.description = "A client for the Ancon POS public core API (core-api.ancon.io): tenant catalog, outlets, " \
    "checks, checkouts, orders and tickets. Plain Ruby, no runtime dependencies."
  spec.homepage = "https://github.com/servos-app/ancon"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4"

  spec.files = Dir["lib/**/*.rb"]
  spec.require_paths = ["lib"]
end
