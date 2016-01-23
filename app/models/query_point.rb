class QueryPoint < ActiveRecord::Base
  belongs_to :user

  validates :creditcard_num, presence: true
  validates_length_of :creditcard_num, is: 16, message: "浦发的信用卡号是16位。"

  # after_save :query_point

  def build_req(creditcard_num)
    req = {
            PapersType: "",                  # 证件种类，选填
            adjustmentIntegralPlan: "9975",  # 积分调整计划
            adjustmentIntegralValue: "",     # 积分调整值，选填
            adjustmentMark: "",              # 积分调整标志 + 加，- 减，选填
            cardNo: "6221775500000010",      # 信用卡号，必填
            # cardNo: creditcard_num         # 正式上线
            cardStateExamination: "N",       # 卡片状态检查 N:不检查（建议送N），必填
            certno: "",                      # 证件号码，选填
            checkItem: "0",                  # 检查项目选择， 默认为"0"， 不检查，必填
            competentNumber: "777733",       # 主管管号
            isPassword: "0",                 # 是否检查密码标志，0 不检查，1 卡片级别，2 取款密码，3 客户级别密码，必填
            password: "",                    # 密码，选填
            resaveDomain: "",                # 保留域，目前填空
            source: "JBZCH",                 # 来源，回传
            tradeOptions: "1"                # 交易选项，1 查询，2 调整，必填
          }.to_json
  end

  def query_point
    # Setup the UAT connection.
    uat_url = "http://172.30.122.161:8002/spdbcccLife/services/DynamicPsw?wsdl"
    client = Savon.client(wsdl: uat_url)
    # client = Savon.client(wsdl: "http://172.30.122.161:8002/spdbcccLife/services/DynamicPsw?wsdl", encoding: "GBK")

    # Call the SPDB API.
    response = client.call(:queryPoint, message: { "in0" => self.request.to_json })
    self.response = response
    if self.save
      return
    else
      logger.error "查询不成功。"
    end
  end

  private
    def set_connection
      # UAT "http://172.30.122.161:8002/spdbcccLife/services/DynamicPsw?wsdl"
      # PRD "http://172.20.112.73:9000/spdbcccLife/services/DynamicPsw?wsdl"

      client = Savon.client(wsdl: "http://172.30.122.161:8002/spdbcccLife/services/DynamicPsw?wsdl")
    end
end
