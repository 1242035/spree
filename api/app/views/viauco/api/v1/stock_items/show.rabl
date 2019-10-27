object @stock_item
attributes *stock_item_attributes
child(:variant) do
  extends 'viauco/api/v1/variants/small'
end
