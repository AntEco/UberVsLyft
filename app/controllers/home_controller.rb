class HomeController < ApplicationController
    
    def index
        
    
    @uber_request = `curl -H "Authorization: Token "#{UBER_TOKEN}"" \
"https://api.uber.com/v1/estimates/price?start_latitude=40.707910&start_longitude=-74.006483&end_latitude=40.721837&end_longitude=-73.987707"`
    @uber_output = (JSON.parse(@uber_request))["prices"]
       
        
        
        
    @test = @uber_output.is_a? Array
        

    @obtainLyftToken = `curl -X POST -H "Content-Type: application/json" \
     --user "#{LYFT_ID}:#{LYFT_SECRET}" \
     -d '{"grant_type": "client_credentials", "scope": "public"}' \
     "https://api.lyft.com/oauth/token"`

	@lyft_response = JSON.parse(@obtainLyftToken)	
	@lyftToken = @lyft_response["access_token"]

	@lyftRequest = `curl --include -X GET -H 'Authorization: Bearer #{@lyftToken}' \
     "https://api.lyft.com/v1/cost?start_lat=40.787011&start_lng=-73.975368&end_lat=40.7079100&end_lng=-74.0064830"`

     @splitLyftRequest = @lyftRequest.split('version: HTTP/1.1', 2)[1]

     @lyftData = JSON.parse(@splitLyftRequest)
     
	 @lyftHash = @lyftData["cost_estimates"]

    end
    
end
