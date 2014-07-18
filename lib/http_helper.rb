class HttpHelper

  def self.get_request(uri, api_key)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # set up the request
    header = {
      "Content-Type" => "application/json"
    }

    req = Net::HTTP::Get.new(uri, header)
    req.basic_auth(api_key, '')
    res = http.start { |http| http.request(req) }
    body = JSON.parse(res.body)
    if body['errors'] then
      puts "Server returned an error: #{body['errors'][0]['message']}"
      exit(0)
    else
      return body["data"]
    end

  end


end