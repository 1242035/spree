Viauco::Sample.load_sample('option_values')
Viauco::Sample.load_sample('products')

product = Viauco::Product.find_by(name: 'Ruby on Rails Baseball Jersey')
size = Viauco::OptionValue.find_by(name: 'Small')
color = Viauco::OptionValue.find_by(name: 'Red')
eligible_values = "#{size.id},#{color.id}"

promotion = Viauco::Promotion.where(
  name: 'free shipping',
  usage_limit: nil,
  path: nil,
  match_policy: 'any',
  description: ''
).first_or_create

Viauco::PromotionRule.where(
  promotion_id: promotion.id,
  type: 'Viauco::Promotion::Rules::OptionValue',
  preferences: { match_policy: 'any', eligible_values: { product.id.to_s => eligible_values } }
).first_or_create

Viauco::Promotion::Actions::FreeShipping.where(promotion_id: promotion.id).first_or_create
