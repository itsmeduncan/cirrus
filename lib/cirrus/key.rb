class Cirrus::Key

  def self.generate(*ids)
    ids.each_with_object([]) do |id, keys|
      id = id.is_a?(String) ? id.downcase.gsub(/[^a-z]/i, '') : id
      keys << id unless id == ''
    end.join("_")
  end

end