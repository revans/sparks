module Sparks
  def self.version
    [
      MAJOR,
      MINOR,
      PATCH
    ].join('.')
  end

  MAJOR = 0
  MINOR = 0
  PATCH = 15
end
