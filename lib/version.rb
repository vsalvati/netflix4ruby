module Netflix4Ruby

  def self.build_version
    major = 0
    minor = 0
    build = 1
    [major, minor, build].join '.'
  end

  VERSION = build_version

end
