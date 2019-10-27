module Viauco
  class HomeController < Viauco::StoreController
    helper 'viauco/products'
    respond_to :html

    def index
      @searcher = build_searcher(params.merge(include_images: true))
      @products = @searcher.retrieve_products
      @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
      @taxonomies = Viauco::Taxonomy.includes(root: :children)
    end
  end
end
