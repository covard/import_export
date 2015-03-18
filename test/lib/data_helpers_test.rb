require 'minitest/spec'
require 'minitest/autorun'

describe DataHelpers do
  subject { DataHelpers }
  it 'returns true for missing headers' do
    req_headers = [:name, :price]
    file_headers = [:name, :sku, :description]
    subject.missing_req_headers?(req_headers, file_headers).must_equal true
  end

  it 'returns false for no missing headers' do
    req_headers = [:name, :price]
    file_headers = [:name, :description, :price]
    subject.missing_req_headers?(req_headers, file_headers).must_equal false
  end

  it 'returns proper product columns array' do
    subject.obj_columns('Product').must_equal [:id, :name, :description, :price, :created_at, :updated_at, :sku]
  end

  it 'returns data hash for obj attributes only' do
    data = { name: 'Product Name', description: 'Product description', price: 22.00, sku: '123456A', unkown_attr: 'Shouldnt be returned' }
    expected_data = { name: 'Product Name', description: 'Product description', price: 22.00, sku: '123456A' }
    obj_columns = subject.obj_columns('Product')
    subject.generate_attr_hash(obj_columns, data).must_equal expected_data
  end
end
