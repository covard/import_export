class ProductImporter < Importer
  def process(file_path)
    csv = SmarterCSV.process file_path
    self.req_headers = [:name, :sku, :price]

    # todo: email error message
    raise 'Missing required headers' if DataHelpers.missing_req_headers? self.req_headers, csv[0].keys

    csv.each do |data|
      add_update_product data
    end

    process_time = self.run_time(Time.now)[:diff]

    # email report
  end

  def add_update_product(data)
    # finding by this instead of find_or_create_by because user can update product through import wouldn't match and would create a new one
    product = Product.find_by_sku data[:sku]
    data_hsh = DataHelpers.generate_attr_hash(DataHelpers.obj_columns('Product'), data)
    product.blank? ? Product.create(data_hsh) : product.update(data_hsh)
  end
end
