unless ENV['SKIP_SAMPLE_IMAGES']
  Viauco::Sample.load_sample('products')
  Viauco::Sample.load_sample('variants')
  products = {}
  products[:ror_baseball_jersey] = Viauco::Product.find_by!(name: 'Ruby on Rails Baseball Jersey')
  products[:ror_tote] = Viauco::Product.find_by!(name: 'Ruby on Rails Tote')
  products[:ror_bag] = Viauco::Product.find_by!(name: 'Ruby on Rails Bag')
  products[:ror_jr_spaghetti] = Viauco::Product.find_by!(name: 'Ruby on Rails Jr. Spaghetti')
  products[:ror_mug] = Viauco::Product.find_by!(name: 'Ruby on Rails Mug')
  products[:ror_ringer] = Viauco::Product.find_by!(name: 'Ruby on Rails Ringer T-Shirt')
  products[:ror_stein] = Viauco::Product.find_by!(name: 'Ruby on Rails Stein')
  products[:viauco_baseball_jersey] = Viauco::Product.find_by!(name: 'Viauco Baseball Jersey')
  products[:viauco_stein] = Viauco::Product.find_by!(name: 'Viauco Stein')
  products[:viauco_jr_spaghetti] = Viauco::Product.find_by!(name: 'Viauco Jr. Spaghetti')
  products[:viauco_mug] = Viauco::Product.find_by!(name: 'Viauco Mug')
  products[:viauco_ringer] = Viauco::Product.find_by!(name: 'Viauco Ringer T-Shirt')
  products[:viauco_tote] = Viauco::Product.find_by!(name: 'Viauco Tote')
  products[:viauco_bag] = Viauco::Product.find_by!(name: 'Viauco Bag')
  products[:ruby_baseball_jersey] = Viauco::Product.find_by!(name: 'Ruby Baseball Jersey')
  products[:apache_baseball_jersey] = Viauco::Product.find_by!(name: 'Apache Baseball Jersey')

  def image(name, type = 'jpeg')
    images_path = Pathname.new(File.dirname(__FILE__)) + 'images'
    path = images_path + file_name(name, type)
    return false unless File.exist?(path)

    File.open(path)
  end

  def file_name(name, type = 'jpeg')
    "#{name}.#{type}"
  end

  def attach_paperclip_image(variant, name, type)
    if variant.images.where(attachment_file_name: file_name(name, type)).none?
      image = image(name, type)
      variant.images.create!(attachment: image)
    end
  end

  def attach_active_storage_image(variant, name, type)
    if variant.images.with_attached_attachment.where(active_storage_blobs: { filename: file_name(name, type) }).none?
      image = image(name, type)
      variant.images.create!(attachment: { io: image, filename: file_name(name, type) })
    end
  end

  images = {
    products[:ror_tote].master => [
      {
        name: file_name('ror_tote'),
        attachment: image('ror_tote')
      },
      {
        name: file_name('ror_tote_back'),
        attachment: image('ror_tote_back')
      }
    ],
    products[:ror_bag].master => [
      {
        name: file_name('ror_bag'),
        attachment: image('ror_bag')
      }
    ],
    products[:ror_baseball_jersey].master => [
      {
        name: file_name('ror_baseball'),
        attachment: image('ror_baseball')
      },
      {
        name: file_name('ror_baseball_back'),
        attachment: image('ror_baseball_back')
      }
    ],
    products[:ror_jr_spaghetti].master => [
      {
        name: file_name('ror_jr_spaghetti'),
        attachment: image('ror_jr_spaghetti')
      }
    ],
    products[:ror_mug].master => [
      {
        name: file_name('ror_mug'),
        attachment: image('ror_mug')
      },
      {
        name: file_name('ror_mug_back'),
        attachment: image('ror_mug_back')
      }
    ],
    products[:ror_ringer].master => [
      {
        name: file_name('ror_ringer'),
        attachment: image('ror_ringer')
      },
      {
        name: file_name('ror_ringer_back'),
        attachment: image('ror_ringer_back')
      }
    ],
    products[:ror_stein].master => [
      {
        name: file_name('ror_stein'),
        attachment: image('ror_stein')
      },
      {
        name: file_name('ror_stein_back'),
        attachment: image('ror_stein_back')
      }
    ],
    products[:apache_baseball_jersey].master => [
      {
        name: file_name('apache_baseball', 'png'),
        attachment: image('apache_baseball', 'png')
      }
    ],
    products[:ruby_baseball_jersey].master => [
      {
        name: file_name('ruby_baseball', 'png'),
        attachment: image('ruby_baseball', 'png')
      }
    ],
    products[:viauco_bag].master => [
      {
        name: file_name('viauco_bag'),
        attachment: image('viauco_bag')
      }
    ],
    products[:viauco_tote].master => [
      {
        name: file_name('viauco_tote_front'),
        attachment: image('viauco_tote_front')
      },
      {
        name: file_name('viauco_tote_back'),
        attachment: image('viauco_tote_back')
      }
    ],
    products[:viauco_ringer].master => [
      {
        name: file_name('viauco_ringer_t'),
        attachment: image('viauco_ringer_t')
      },
      {
        name: file_name('viauco_ringer_t_back'),
        attachment: image('viauco_ringer_t_back')
      }
    ],
    products[:viauco_jr_spaghetti].master => [
      {
        name: file_name('viauco_spaghetti'),
        attachment: image('viauco_spaghetti')
      }
    ],
    products[:viauco_baseball_jersey].master => [
      {
        name: file_name('viauco_jersey'),
        attachment: image('viauco_jersey')
      },
      {
        name: file_name('viauco_jersey_back'),
        attachment: image('viauco_jersey_back')
      }
    ],
    products[:viauco_stein].master => [
      {
        name: file_name('viauco_stein'),
        attachment: image('viauco_stein')
      },
      {
        name: file_name('viauco_stein_back'),
        attachment: image('viauco_stein_back')
      }
    ],
    products[:viauco_mug].master => [
      {
        name: file_name('viauco_mug'),
        attachment: image('viauco_mug')
      },
      {
        name: file_name('viauco_mug_back'),
        attachment: image('viauco_mug_back')
      }
    ]
  }

  products[:ror_baseball_jersey].variants.each do |variant|
    color = variant.option_value('tshirt-color').downcase

    attach_active_storage_image(variant, "ror_baseball_jersey_#{color}", 'png')
    attach_active_storage_image(variant, "ror_baseball_jersey_back_#{color}", 'png')
  end

  images.each do |variant, attachments|
    puts "Loading images for #{variant.product.name}"
    attachments.each do |attrs|
      name, type = attrs.delete(:name).split('.')
      attach_active_storage_image(variant, name, type)
    end
  end
end
