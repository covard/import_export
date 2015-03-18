module DataHelpers
  def self.obj_columns(klass_name)
    klass_name.constantize.column_names.map &:to_sym
  end

  def self.generate_attr_hash(obj_attr_ary, data)
    data.select { |key, value| obj_attr_ary.include?(key) }
  end

  def self.missing_req_headers?(req_headers, file_headers)
    req_headers.each.inject({}) { |hsh, rh| hsh.merge({ rh => file_headers.include?(rh) }) }.has_value? false
  end
end
