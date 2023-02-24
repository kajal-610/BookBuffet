json.extract! store, :id, :name, :category, :description, :price, :author, :created_at, :updated_at
json.url store_url(store, format: :json)
