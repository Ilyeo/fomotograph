require 'httparty'
require 'json'

class Product
    # read access for the Product attributes
    attr_reader :id, :title, :location, :summary, :url, :price

    # ping the API for the product JSON
    url = 'https://fomotograph-api.udacity.com/products.json'
    DATA = HTTParty.get(url)['photos']

    # locations offered by Fomotograph
    LOCATIONS = ['canada', 'england', 'france', 'ireland', 'mexico', 'scotland', 'taiwan', 'us']
    
    # initialize a Product object using a data hash
    def initialize(product_data = {})
        @id = product_data['id']
        @title = product_data['title']
        @location = product_data['location']
        @summary = product_data['summary']
        @url = product_data['url']
        @price = product_data['price']
    end
    
    # return an array of Product objects
    def self.all
        DATA.map { |product| new(product) }
    end

    # return an array of sample products from each location
    def self.sample_locations
        @products = []
        LOCATIONS.each do |location|
            @products.push self.all.select { |product| product.location == location }.sample
        end
        return @products
    end

    # returns an array of products from a given location
    def self.find_by_location(location)
        self.all.select{ |product| product.location == location } 
    end

    # return a product from a given id
    def self.find_by_id(id)
        self.all.select { |product| product.id == id.to_i }.first
    end

end
