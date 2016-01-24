class RequestDynamicPassword < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
    
  def process_spdb_api(creditcard_num, dynamic_key)   
    request_dynamic_psw(build_req(creditcard_num, dynamic_key))
  end

  private
    def build_req(creditcard_num, dynamic_key)
      req = {
              cardNo: "6221775500000010",      # 信用卡号，必填
              # cardNo: creditcard_num         # 正式上线
              password: dynamic_key,           # 动态验证码
              source: "JBZCH"                  # 来源，回传
            }.to_json
    end

  def request_dynamic_psw(req)
    # UAT "http://172.30.122.161:8002/spdbcccLife/services/DynamicPsw?wsdl"
    # PRD "http://172.20.112.73:9000/spdbcccLife/services/DynamicPsw?wsdl"
    # Setup the UAT connection.
    uat_url = "http://172.30.122.161:8002/spdbcccLife/services/DynamicPsw?wsdl"
    client = Savon.client(wsdl: uat_url)
    # client = Savon.client(wsdl: "http://172.30.122.161:8002/spdbcccLife/services/DynamicPsw?wsdl", encoding: "GBK")
    
    # Call the SPDB API.
    response = client.call(:request_dynamic_psw, message: { "in0" => req })
    self.response = response
    if self.save
      if response.to_hash[:status] == '3'
        return session[:dynamic_key]
      else
        return false
      end
    else
      return false
    end
  end

end


# req = { cardNo: "6221775500000010", password: dynamic_key, source: "JBZCH" }.to_json