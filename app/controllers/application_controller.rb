class ApplicationController < Sinatra::Base
  # add routes

  set :default_content_type, 'application/json'

  get '/bakeries' do
    # get all the bakeries from the database
    bakeries = Bakery.all
    # send them back as a JSON array
    bakeries.to_json
  end

  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods/by_price' do
    baked_good = BakedGood.all.order(price: :desc) # baked_goods has to match the route name. baked_good wouldn't work
    baked_good.to_json
  end
  # response would be: [{ name: "Croissant", price: 5 }, { name: "Banana Bread", price: 3 }, { name: "Bagel", price: 2 }]
  # .order with desc uses this syntax .order(price: :desc). 
  # .order asc syntax: .order(:price)

  get '/baked_goods/most_expensive' do
    baked_goods = BakedGood.all.order(price: :desc).first # limit(1) doesn't work bc of argument error, comparison of integer with :name failed
    baked_goods.to_json
  end

end
