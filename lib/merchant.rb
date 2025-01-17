class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(csv_data, repository)
    @repository = repository
    @id = csv_data[:id].to_i
    @name = csv_data[:name]
    @created_at = csv_data[:created_at]
    @updated_at = csv_data[:updated_at]
  end

  def change_merchant_name(name)
    @name = name
  end

  def item_name
    @repository.find_all_items_by_merchant_id(@id)
  end
end
