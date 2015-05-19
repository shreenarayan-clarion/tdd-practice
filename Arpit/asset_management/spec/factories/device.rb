# This will guess the Device class
FactoryGirl.define do

  factory :device_category, class: DeviceCategory do
    name "Device1"
    description "Cat1 Description"
  end

  factory :device ,class: Device do
    device_category
    device_identifier "Monitor"
    serial_number  "123"
    model_number "MODEL1"
    status 'instock'
  end

  factory :deactivated_device ,class: Device do
    device_category
    device_identifier "Mouse"
    serial_number  "1234"
    model_number "MODEL123"
    status 'scrap'
    deleted_at Random.rand(5..500).days.ago
  end

end