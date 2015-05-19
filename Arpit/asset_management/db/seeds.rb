# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

ActiveRecord::Base.transaction do
	branch1 = Branch.create!(name: 'ADC')
	branch2 = Branch.create!(name: 'BDC')
	branch3 = Branch.create!(name: 'PDC')

	puts "*** Branches created ***"

	client1 = Client.create!(name: Faker::Name.name.gsub!(/[^A-Za-z]/, ' '))
	client2 = Client.create!(name: Faker::Name.name.gsub!(/[^A-Za-z]/, ' '))
	client3 = Client.create!(name: Faker::Name.name.gsub!(/[^A-Za-z]/, ' '))

	puts "*** Clients created ***"

	name1 = Faker::Name.name.gsub!(/[^A-Za-z]/, ' ')
	name2 = Faker::Name.name.gsub!(/[^A-Za-z]/, ' ')
	name3 = Faker::Name.name.gsub!(/[^A-Za-z]/, ' ')

	address1 = "#{Faker::Address.secondary_address}\n#{ Faker::Address.street_address}"
	address2 = "#{Faker::Address.secondary_address}\n#{ Faker::Address.street_address}"
	address3 = "#{Faker::Address.secondary_address}\n#{ Faker::Address.street_address}"

	vendor1 = Vendor.create!(name: name1, email: Faker::Internet.email(name1), address: address1, city: Faker::Address.city, state: Vendor::STATE.sample, contact_number: Faker::Base.numerify('####-########'), fax_number: Faker::Base.numerify('####-########'), mobile_number: Faker::Base.numerify('##########'), website: Faker::Internet.url)
	vendor2 = Vendor.create!(name: name2, email: Faker::Internet.email(name2), address: address2, city: Faker::Address.city, state: Vendor::STATE.sample, contact_number: Faker::Base.numerify('####-########'), fax_number: Faker::Base.numerify('####-########'), mobile_number: Faker::Base.numerify('##########'), website: Faker::Internet.url)
	vendor3 = Vendor.create!(name: name3, email: Faker::Internet.email(name3), address: address3, city: Faker::Address.city, state: Vendor::STATE.sample, contact_number: Faker::Base.numerify('####-########'), fax_number: Faker::Base.numerify('####-########'), mobile_number: Faker::Base.numerify('##########'), website: Faker::Internet.url)

	puts "*** Vendors created ***"

	device_category1 = DeviceCategory.create!(name: 'Desktop Asset', description: Faker::Company.catch_phrase.gsub!(/[^0-9A-Za-z]/, ' '))
	device_category2 = DeviceCategory.create!(name: 'Mobile Asset', description: Faker::Company.catch_phrase.gsub!(/[^0-9A-Za-z]/, ' '))
	device_category3 = DeviceCategory.create!(name: 'Peripharials', description: Faker::Company.catch_phrase.gsub!(/[^0-9A-Za-z]/, ' '))

	puts "*** Device Categories created ***"

	employee1 = Employee.create!(first_name: "Parth", last_name: "Mewada", email: "parth@example.com", employee_number: 740, designation: DESIGNATIONS[2], technology: TECHNOLOGIES[1], department: DEPARTMENTS[1], branch_id: branch1.id, join_date: Random.rand(5..500).days.ago, join_date: rand(30..600).days.ago)
	employee2 = Employee.create!(first_name: "Sapna", last_name: "Prajapati", email: "sapna@example.com", employee_number: 867, designation: DESIGNATIONS[2], technology: TECHNOLOGIES[1], department: DEPARTMENTS[1], branch_id: branch1.id, join_date: Random.rand(5..500).days.ago, join_date: rand(30..600).days.ago)
	employee3 = Employee.create!(first_name: "Kaushal", last_name: "Sharma", email: "kaushal@example.com", employee_number: 949, designation: DESIGNATIONS[2], technology: TECHNOLOGIES[1], department: DEPARTMENTS[1], branch_id: branch1.id, join_date: Random.rand(5..500).days.ago, join_date: rand(30..600).days.ago)
	employee4 = Employee.create!(first_name: "Arpit", last_name: "Vaishnav", email: "arpit@example.com", employee_number: 979, designation: DESIGNATIONS[2], technology: TECHNOLOGIES[1], department: DEPARTMENTS[1], branch_id: branch1.id, join_date: Random.rand(5..500).days.ago, join_date: rand(30..600).days.ago)

	puts "*** Employees created ***"

	user1 = User.create!(email: employee1.email, password: "test1234", password_confirmation: "test1234", employee_id: employee1.id)
	user2 = User.create!(email: employee2.email, password: "test1234", password_confirmation: "test1234", employee_id: employee2.id)
	user3 = User.create!(email: employee3.email, password: "test1234", password_confirmation: "test1234", employee_id: employee3.id)
	user4 = User.create!(email: employee4.email, password: "test1234", password_confirmation: "test1234", employee_id: employee4.id)

	puts "*** Users created ***"

	software_product1 = SoftwareProduct.create!(name: Faker::Commerce.product_name, device_category_id: device_category1.id, version: Random.rand(1111..9999))
	software_product2 = SoftwareProduct.create!(name: Faker::Commerce.product_name, device_category_id: device_category2.id, version: Random.rand(1111..9999))
	software_product3 = SoftwareProduct.create!(name: Faker::Commerce.product_name, device_category_id: device_category3.id, version: Random.rand(1111..9999))

	puts "*** Software Products created ***"

	device1 = Device.create!(status: 'assigned', device_category_id: device_category1.id, device_identifier: 'PC', serial_number: 'CT-A-PC-010', model_number: Random.rand(1111..9999), branch_id: branch1.id, employee: employee1, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)
	device1_1 = Device.create!(status: 'assigned', parent_id: device1.id, device_category_id: device_category1.id, device_identifier: 'Monitor', serial_number: 'CT-A-PC-010-MON', model_number: Random.rand(1111..9999), branch_id: branch1.id, employee: employee1, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)
	device1_2 = Device.create!(status: 'assigned', parent_id: device1.id, device_category_id: device_category1.id, device_identifier: 'Key Board', serial_number: 'CT-A-PC-010-KEY', model_number: Random.rand(1111..9999), branch_id: branch1.id, employee: employee1, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)
	device1_3 = Device.create!(status: 'assigned', parent_id: device1.id, device_category_id: device_category1.id, device_identifier: 'Mouse', serial_number: 'CT-A-PC-010-MOU', model_number: Random.rand(1111..9999), branch_id: branch1.id, employee: employee1, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)

	device2 = Device.create!(status: 'assigned', device_category_id: device_category1.id, device_identifier: 'PC', serial_number: 'CT-A-PC-011', model_number: Random.rand(1111..9999), branch_id: branch1.id, employee: employee2, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)
	device2_1 = Device.create!(status: 'assigned', parent_id: device1.id, device_category_id: device_category1.id, device_identifier: 'Monitor', serial_number: 'CT-A-PC-011-MON', model_number: Random.rand(1111..9999), branch_id: branch1.id, employee: employee2, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)
	device2_2 = Device.create!(status: 'assigned', parent_id: device1.id, device_category_id: device_category1.id, device_identifier: 'Key Board', serial_number: 'CT-A-PC-011-KEY', model_number: Random.rand(1111..9999), branch_id: branch1.id, employee: employee2, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)
	device2_3 = Device.create!(status: 'assigned', parent_id: device1.id, device_category_id: device_category1.id, device_identifier: 'Mouse', serial_number: 'CT-A-PC-011-MOU', model_number: Random.rand(1111..9999), branch_id: branch1.id, employee: employee2, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)

	device2 = Device.create!(status: 'assigned', device_category_id: device_category1.id, device_identifier: 'PC', serial_number: 'CT-A-PC-012', model_number: Random.rand(1111..9999), branch_id: branch1.id, employee: employee3, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)
	device2_1 = Device.create!(status: 'assigned', parent_id: device1.id, device_category_id: device_category1.id, device_identifier: 'Monitor', serial_number: 'CT-A-PC-012-MON', model_number: Random.rand(1111..9999), branch_id: branch1.id, employee: employee3, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)
	device2_2 = Device.create!(status: 'assigned', parent_id: device1.id, device_category_id: device_category1.id, device_identifier: 'Key Board', serial_number: 'CT-A-PC-012-KEY', model_number: Random.rand(1111..9999), branch_id: branch1.id, employee: employee3, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)
	device2_3 = Device.create!(status: 'assigned', parent_id: device1.id, device_category_id: device_category1.id, device_identifier: 'Mouse', serial_number: 'CT-A-PC-012-MOU', model_number: Random.rand(1111..9999), branch_id: branch1.id, employee: employee3, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)

	device3 = Device.create!(status: 'assigned', device_category_id: device_category1.id, device_identifier: 'PC', serial_number: 'CT-A-PC-013', model_number: Random.rand(1111..9999), branch_id: branch1.id, employee: employee4, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)
	device3_1 = Device.create!(status: 'assigned', parent_id: device1.id, device_category_id: device_category1.id, device_identifier: 'Monitor', serial_number: 'CT-A-PC-013-MON', model_number: Random.rand(1111..9999), branch_id: branch1.id, employee: employee4, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)
	device3_2 = Device.create!(status: 'assigned', parent_id: device1.id, device_category_id: device_category1.id, device_identifier: 'Key Board', serial_number: 'CT-A-PC-013-KEY', model_number: Random.rand(1111..9999), branch_id: branch1.id, employee: employee4, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)
	device3_3 = Device.create!(status: 'assigned', parent_id: device1.id, device_category_id: device_category1.id, device_identifier: 'Mouse', serial_number: 'CT-A-PC-013-MOU', model_number: Random.rand(1111..9999), branch_id: branch1.id, employee: employee4, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)

	device4 = Device.create!(status: 'instock', device_category_id: device_category2.id, device_identifier: 'Iphone 4S', serial_number: Random.rand(1111..9999), model_number: Random.rand(1111..9999), branch_id: branch1.id, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)
	device5 = Device.create!(status: 'instock', device_category_id: device_category3.id, device_identifier: 'Graphic Card', serial_number: Random.rand(1111..9999), model_number: Random.rand(1111..9999), branch_id: branch1.id, purchase_date: rand(1..5).days.ago, lifetime_warranty: true)

	puts "*** Devices created ***"

	device1.device_assignments.create!(employee_id: device1.employee_id, assign_date: device1.purchase_date, branch_id: device1.branch_id, device_category_id: device1.device_category_id)
	device2.device_assignments.create!(employee_id: device2.employee_id, assign_date: device2.purchase_date, branch_id: device2.branch_id, device_category_id: device2.device_category_id)
	device3.device_assignments.create!(employee_id: device3.employee_id, assign_date: device3.purchase_date, branch_id: device3.branch_id, device_category_id: device3.device_category_id)


	puts "*** Device assignments created ***"

	request1 = DeviceRequest.new(on_date: Date.today - 5, vendor_ids: [vendor1.id.to_s, vendor2.id.to_s])
	transaction1   = request1.requested_transactions.new(device_category_id: device_category1.id, request_title: 'Monitor', request_description: 'Request for monitor', request_quantity: 10)
	transaction1_2 = request1.requested_transactions.new(device_category_id: device_category1.id, request_title: 'Mouse', request_description: 'Request for mouse', request_quantity: 20)
	request2 = DeviceRequest.new(on_date: Date.today - 5, vendor_ids: [vendor1.id.to_s, vendor2.id.to_s])
	transaction2   = request2.requested_transactions.new(device_category_id: device_category2.id, request_title: 'I phone',quotation_title: 'I phone',purchase_title: 'I phone',invoice_title: 'I phone', request_description: 'Request for i phone',quotation_description: 'Quotation for i phone',purchase_description: 'Purchase for i phone',invoice_description: 'Request for i phone', request_quantity: 2, quotation_quantity: 2, purchase_quantity: 2, invoice_quantity: 2,quotation_price: 200,purchase_price: 200,invoice_price: 200)
	transaction2_1 = request2.requested_transactions.new(device_category_id: device_category2.id, request_title: 'Mac Mini',quotation_title: 'Mac Mini',purchase_title: 'Mac Mini',invoice_title: 'Mac Mini', request_description: 'Request for mac mini',quotation_description: 'Quotation for mac mini',purchase_description: 'Purchase for mac mini',invoice_description: 'Request for mac mini', request_quantity: 2, quotation_quantity: 2, purchase_quantity: 2, invoice_quantity: 2,quotation_price: 1950,purchase_price: 1950,invoice_price: 1900)
	request1.save
	request2.save
	transaction1.save
	transaction1_2.save
	transaction2.save
	transaction2_1.save

	puts "*** Request created ***"
	quotation      = Quotation.create(identifier: 'QT1', device_request_id: request2.id, on_date: Date.today - 4)		
	transaction2.update(quotation_id: quotation.id)
	transaction2_1.update(quotation_id: quotation.id)
	purchase_order = PurchaseOrder.create(identifier: 'PO1',quotation_id: quotation.id, on_date: Date.today - 3)
  transaction2.update(purchase_order_id: purchase_order.id)
	#transaction2_3 = DeviceTransaction.create(vendor_id: vendor3.id, device_category_id: device_category2.id,device_request_id: request2.id, request_title: 'I phone', request_description: 'Request for i phone', request_quantity: 2)
	#transaction2_4 = DeviceTransaction.create(vendor_id: vendor3.id, device_category_id: device_category2.id,device_request_id: request2.id, request_title: 'Mac Mini', request_description: 'Request for mac mini', request_quantity: 2)

	puts "*** Request Transactions created ***"


	puts "%%%%% All Done !!! %%%%%"
end