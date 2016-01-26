class RequestDynamicPassword < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  belongs_to :adjust_point
    
  def process_spdb_api(creditcard_num, dynamic_key)   
    request_dynamic_psw(build_req(creditcard_num, dynamic_key), dynamic_key)
  end

  # 创建动态验证码
  def create_rand_key
    keys = ""
    4.times{
      key = Random.rand(9).to_s
      keys += key
    }
    return keys
  end

  private
    def build_req(creditcard_num, dynamic_key)
      d_req = {
              cardNo: "6221775500000010",      # 信用卡号，必填
              # cardNo: creditcard_num         # 正式上线
              password: dynamic_key,           # 动态验证码
              source: "JBZCH"                  # 来源，回传
            }.to_json
    end

    # req = { cardNo: "6221775500000010", password: "1234", source: "JBZCH" }.to_json

    def request_dynamic_psw(d_req, dy_key)
      # UAT "http://172.30.122.161:8002/spdbcccLife/services/DynamicPsw?wsdl"
      # PRD "http://172.20.112.73:9000/spdbcccLife/services/DynamicPsw?wsdl"
      # Setup the UAT connection.
      # uat_url = "http://172.30.122.161:8002/spdbcccLife/services/DynamicPsw?wsdl"
      client = Savon.client(wsdl: ENV['SPDB_API_URL'])
      # client = Savon.client(wsdl: "http://172.30.122.161:8002/spdbcccLife/services/DynamicPsw?wsdl", encoding: "GBK")
      
      self.request = d_req                                                      # Save the req.
      response = client.call(:request_dynamic_psw, message: { "in0" => d_req })  # Call the SPDB API.
      self.response = response                                                   # Save the original response.
      self.dynamic_key = dy_key
      # self.order_id = session[:order_id]
      # session[:order_id] = nil

      dynamic_password_hash = eval(response.to_hash[:request_dynamic_psw_response][:out].to_s.underscore)

      self.status = dynamic_password_hash[:status]

      if self.save
        # status 值在 response.to_hash 中的位置
        if self.status == "3"
          self.dynamic_key
        else
          redirect_to new_wechat_adjust_point_path, notice: "暂时无法发送随机码。请稍后再试。"
        end
      else
        logger.error "随机码生成错误。"
        redirect_to new_wechat_adjust_point_path, notice: "暂时无法发送随机码。请稍后再试。"
      end
    end
end

