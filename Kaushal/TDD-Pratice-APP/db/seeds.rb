# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Admin.count == 0
  Admin.invite!(:email => "admin@popsocket.com", :name => "Super Admin", password: 'password', password_confirmation: 'password', role: 'super_admin') do |u|
    u.skip_invitation = true
  end     
  Admin.first.update!(confirmation_token: nil, confirmed_at: Time.now, created_at: Time.now, updated_at: Time.now, invitation_token: nil, invitation_accepted_at: Time.now)
end 

super_admin = Admin.find_by_role(1)
product = super_admin.products.find_or_create_by(shopify_product_id: '2323323', name: 'Single-popsocket', description: 'Single side popsocket', base_price: 440, active: true, image: 'https://cdn.shopify.com/s/files/1/0257/6087/products/Featured_single_SIDE.76.png?9999999')
if product.present?
  button = product.components.find_or_create_by(admin_id: super_admin.id, name: 'Buttons', description: 'Single Side Popsocket Button', image: 'http://www.pop-sockets.com/uploads/buttons/438_popsockets-for-all-single_button_side_top_no-image-selected.png')
  accordion = product.components.find_or_create_by(admin_id: super_admin.id, name: 'Accordions', description: 'Single Side Popsocket Accordion', image: 'http://www.pop-sockets.com/uploads/accordions/18_popsockets-for-all-single_accordion_side_top_lightgrey.png')
  platform = product.components.find_or_create_by(admin_id: super_admin.id, name: 'Platform', description: 'Single Side Popsocket Platform', image: 'http://www.pop-sockets.com/uploads/body/18_popsockets-for-all-single_body_side_lightgrey.png')
end

['Colors', 'Designs', 'Sports', 'Others'].each do |name|
  category = super_admin.categories.find_or_create_by(name: name)
end

category_ids = Category.all.ids
if button.product_images.blank?
  Dir[Rails.root.to_s+"/public/default_images/buttons/*"].each do |image_path|
    button.product_images.create(admin_id: super_admin.id, category_id: category_ids.sample, image: File.open(image_path, 'r'))
  end
end

if accordion.product_images.blank?
  Dir[Rails.root.to_s+"/public/default_images/accordions/*"].each do |image_path|
    accordion.product_images.create(admin_id: super_admin.id, image: File.open(image_path, 'r'))
  end
end

if platform.product_images.blank?
  Dir[Rails.root.to_s+"/public/default_images/platforms/*"].each do |image_path|
    platform.product_images.create(admin_id: super_admin.id, image: File.open(image_path, 'r'))
  end
end