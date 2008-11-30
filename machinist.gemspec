Gem::Specification.new do |s|
  s.name = %q{machinist}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pete Yandell"]
  s.date = %q{2008-11-18}
  s.description = %q{Fixtures aren't fun. Machinist is.}
  s.email = %q{pete@notahat.com}
  s.extra_rdoc_files = ["lib/machinist.rb", "lib/sham.rb", "README.markdown"]
  s.files = ["init.rb", "lib/machinist.rb", "lib/sham.rb", "machinist.gemspec", "Manifest", "MIT-LICENSE", "rails/init.rb", "Rakefile", "README.markdown"]
  s.homepage = %q{http://github.com/notahat/machinist}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Machinist", "--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{machinist}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Fixtures aren't fun. Machinist is.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
    else
    end
  else
  end
end