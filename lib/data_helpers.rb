module DataHelpers
  def self.columns_as_hash(klass_name)
    klass_name.constantize.column_names.map &:to_sym
  end

  def self.generate_attr_hash(obj_attr_hash, data)
    data.select { |key, value| obj_attr_hash.include?(key) }
  end

  def self.missing_req_headers?(req_headers, file_headers)
    req_headers.each.inject({}) { |hsh, rh| hsh.merge({ rh => file_headers.include?(rh) }) }.has_value? false
  end
end
