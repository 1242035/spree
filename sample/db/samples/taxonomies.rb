taxonomies = [
  { name: I18n.t('viauco.taxonomy_categories_name') },
  { name: I18n.t('viauco.taxonomy_brands_name') }
]

taxonomies.each do |taxonomy_attrs|
  Viauco::Taxonomy.where(taxonomy_attrs).first_or_create!
end
