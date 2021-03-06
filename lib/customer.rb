require 'json'
module MiviConsume
	class Customer
		def self.consume_data(file)
			return false unless file
			file = File.read(file)
			data_hash = JSON.parse(file)
			product_name = nil
			data_hash["included"].each{ |info| product_name = info["attributes"]["name"] if info["type"] == "products" } if data_hash["included"]
			cust = data_hash["data"]["attributes"]
			puts " Phone number: #{cust["contact-number"]}\n Email address: #{cust["email-address"]}\n Name: #{cust["title"]} #{cust["first-name"]} #{cust["last-name"]}\n Product name: #{ product_name }" if cust
		end
	end
end
Customer.consume_data(ARGV.first)

#Note: bundle install rspec and create file customer_spec.rb with following code and run rspec customer_spec.rb on terminal

# require_relative './customer'

# describe Customer do
#   it "should be true" do
#   	expect(Customer.consume_data('./collection.json')).to "Phone number: 0404000000
#  Email address: test@mivi.com
#  Name: Ms Joe Bloggs
#  Product name: UNLIMITED 7GB
# "
#   end
# end
