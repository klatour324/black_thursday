class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @item_id = attributes[:item_id].to_i
    @invoice_id = attributes[:invoice_id].to_i
    @quantity = attributes[:quantity].to_i
    @unit_price = BigDecimal(attributes[:unit_price]) / 100
    @created_at = Time.parse(attributes[:created_at].to_s)
    @updated_at = Time.parse(attributes[:updated_at].to_s)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update_quantity(attributes)
    @quantity = attributes
    update_updated_time
  end

  def update_updated_time
    @updated_at = Time.now
  end

  def update_unit_price(attributes)
    @unit_price = attributes
    update_updated_time
  end
end
