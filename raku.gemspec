
Gem::Specification.new do |s|
  s.name = 'raku'
  s.version = '0.0.1'
  s.date = '2022-04-12'
  s.summary = "<:as-cute-as-possible>~ rack router"
  s.authors = ["xxanon"]
  s.email = "ironald@gmail.com"
  s.files = `git ls-files`.split("\n") - %w[bin misc]
  s.executables += `git ls-files bin`.split("\n").map{|e| File.basename(e)}
  s.homepage = "https://github.com/nonnax/raku.git"
  s.license = "GPL-3.0"
end

