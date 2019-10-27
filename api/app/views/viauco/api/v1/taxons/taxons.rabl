attributes *taxon_attributes

node :taxons do |t|
  t.children.map { |c| partial('viauco/api/v1/taxons/taxons', object: c) }
end
