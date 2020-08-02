class Application

  @@items = ["Apples","Carrots","Pears"]

  #Create a new class array called @@cart to hold any items in your cart
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    #Create a new route called /cart to show the items in your cart
    elsif req.path.match(/cart/)
      if @@cart.empty?
          resp.write "Your cart is empty"

        else @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    
    #Create a new route called /add that takes in a GET param with the key item.
    elsif req.path.match(/add/)
      item = req.params["item"]

      #check to see if item is in @@items and add it to cart if it is
      if @@items.include?(item)
        @@cart << item
        resp.write "added #{item}"
      #else give an error
      else 
        resp.write "We don't have that item"
      end

    elsif req.path.match(/search/)
        search_term = req.params["q"]
        resp.write handle_search(search_term)
    else
        resp.write "Path Not Found"
    end
  
    resp.finish
    end
end


