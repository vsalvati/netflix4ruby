module Netflix4Ruby

  def self.build_version
    major = 0
    minor = 1
    patch = 0
    [major, minor, patch].join '.'
  end

  VERSION = build_version

end