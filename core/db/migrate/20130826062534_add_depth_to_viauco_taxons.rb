class AddDepthToViaucoTaxons < ActiveRecord::Migration[4.2]
  def up
    if !Viauco::Taxon.column_names.include?('depth')
      add_column :viauco_taxons, :depth, :integer

      say_with_time 'Update depth on all taxons' do
        Viauco::Taxon.reset_column_information
        Viauco::Taxon.all.each { |t| t.save }
      end
    end
  end

  def down
    remove_column :viauco_taxons, :depth
  end
end
