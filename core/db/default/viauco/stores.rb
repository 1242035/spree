# Possibly already created by a migration.
unless Viauco::Store.where(code: 'viauco').exists?
  Viauco::Store.new do |s|
    s.code              = 'viauco'
    s.name              = 'Viauco Demo Site'
    s.url               = 'example.com'
    s.mail_from_address = 'viauco@example.com'
    s.default_currency  = 'USD'
  end.save!
end
