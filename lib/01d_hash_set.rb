class HashSet < IntHashSet
  protected
  def value_hash(value)
    # Simply start using the appropriate hash method for everything to
    # work with arbitrary object types!
    value.hash
  end
end
