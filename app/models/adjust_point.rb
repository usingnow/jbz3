class AdjustPoint < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  has_many :request_dynamic_passwords

  def process_spdb_api(order)
    # Setup the UAT connection.
    uat_url = "http://172.30.122.161:8002/spdbcccLife/services/DynamicPsw?wsdl"
    client = Savon.client(wsdl: uat_url)

    # 构建数据结构。
    # 6221775500000010 测试卡号。
    a_req = {
            PapersType: "",                    # 证件种类，选填
            adjustmentIntegralPlan: "9975",    # 积分调整计划
            adjustmentIntegralValue: order.total_reward,       # 积分调整值，选填
            adjustmentMark: "-",                # 积分调整标志 + 加，- 减，选填
            cardNo: order.creditcard_num.to_s, # 信用卡号，必填
            cardStateExamination: "N",         # 卡片状态检查 N:不检查（建议送N），必填
            certno: "",                        # 证件号码，选填
            checkItem: "0",                    # 检查项目选择， 默认为"0"， 不检查，必填
            competentNumber: "777733",         # 主管管号
            isPassword: "0",                   # 是否检查密码标志，0 不检查，1 卡片级别，2 取款密码，3 客户级别密码，必填
            password: "",                      # 密码，选填
            resaveDomain: "",                  # 保留域，目前填空
            source: "JBZCH",                   # 来源，回传
            tradeOptions: "2"                  # 交易选项，1 查询，2 调整，必填
          }.to_json

    # a_req = {
    #         PapersType: "",                    # 证件种类，选填
    #         adjustmentIntegralPlan: "9975",    # 积分调整计划
    #         adjustmentIntegralValue: "9000000",       # 积分调整值，选填
    #         adjustmentMark: "+",                # 积分调整标志 + 加，- 减，选填
    #         cardNo: 6221775500000010, # 信用卡号，必填
    #         cardStateExamination: "N",         # 卡片状态检查 N:不检查（建议送N），必填
    #         certno: "",                        # 证件号码，选填
    #         checkItem: "0",                    # 检查项目选择， 默认为"0"， 不检查，必填
    #         competentNumber: "777733",         # 主管管号
    #         isPassword: "0",                   # 是否检查密码标志，0 不检查，1 卡片级别，2 取款密码，3 客户级别密码，必填
    #         password: "",                      # 密码，选填
    #         resaveDomain: "",                  # 保留域，目前填空
    #         source: "JBZCH",                   # 来源，回传
    #         tradeOptions: "2"                  # 交易选项，1 查询，2 调整，必填
    #       }.to_json

    self.request = a_req

    # Call the SPDB API.
    response = client.call(:query_point, message: { "in0" => a_req })
    self.response = response
    query_response_hash = response.to_hash[:query_point_response][:out].underscore
    self.update_attributes eval(query_response_hash)
    if self.status == "000000"
      order.if_paid = true
      order.save
      return true
    else
      return false
    end
  end
end
