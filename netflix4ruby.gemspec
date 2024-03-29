# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{netflix4ruby}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nick Veys"]
  s.date = %q{2011-09-25}
  s.description = %q{Access the Netflix API using Ruby}
  s.email = %q{nveys@aramisgroup.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.markdown"
  ]
  s.files = [
    ".document",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.markdown",
    "Rakefile",
    "lib/api.rb",
    "lib/builders/catalog_titles_builder.rb",
    "lib/builders/delivery_formats_builder.rb",
    "lib/builders/queue_builder.rb",
    "lib/netflix4ruby.rb",
    "lib/version.rb",
    "netflix4ruby.gemspec",
    "spec/api_spec.rb",
    "spec/catalog_titles_builder_spec.rb",
    "spec/data/catalog_titles.xml",
    "spec/data/credentials.yml",
    "spec/data/delivery_formats_1.xml",
    "spec/data/delivery_formats_2.xml",
    "spec/data/instant_queue.xml",
    "spec/delivery_formats_builder_spec.rb",
    "spec/queue_builder_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/aramis/netflix4ruby}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Netflix API for Ruby}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<oauth>, [">= 0.4.5"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.5.0"])
      s.add_runtime_dependency(%q<rdoc>, [">= 2.4.2"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<oauth>, [">= 0.4.5"])
      s.add_dependency(%q<nokogiri>, [">= 1.5.0"])
      s.add_dependency(%q<rdoc>, [">= 2.4.2"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<oauth>, [">= 0.4.5"])
    s.add_dependency(%q<nokogiri>, [">= 1.5.0"])
    s.add_dependency(%q<rdoc>, [">= 2.4.2"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end

