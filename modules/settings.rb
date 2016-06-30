module Settings
  @production = false

  def self.production=(x)
    @production = x
  end

  def self.production?
    @production
  end

  def self.development?
    !@production
  end
end
