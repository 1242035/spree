Viauco::Role.where(name: 'admin').first_or_create
Viauco::Role.where(name: 'user').first_or_create
