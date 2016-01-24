class QueryPoint < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  def process_spdb_api(order)
    # Setup the UAT connection.
    uat_url = "http://172.30.122.161:8002/spdbcccLife/services/DynamicPsw?wsdl"
    client = Savon.client(wsdl: uat_url)

    # Build request.
    # 6221775500000010 测试卡号。
    q_req = {
            PapersType: "",                    # 证件种类，选填
            adjustmentIntegralPlan: "9975",    # 积分调整计划
            adjustmentIntegralValue: "",       # 积分调整值，选填
            adjustmentMark: "",                # 积分调整标志 + 加，- 减，选填
            cardNo: order.creditcard_num.to_s, # 信用卡号，必填
            cardStateExamination: "N",         # 卡片状态检查 N:不检查（建议送N），必填
            certno: "",                        # 证件号码，选填
            checkItem: "0",                    # 检查项目选择， 默认为"0"， 不检查，必填
            competentNumber: "777733",         # 主管管号
            isPassword: "0",                   # 是否检查密码标志，0 不检查，1 卡片级别，2 取款密码，3 客户级别密码，必填
            password: "",                      # 密码，选填
            resaveDomain: "",                  # 保留域，目前填空
            source: "JBZCH",                   # 来源，回传
            tradeOptions: "1"                  # 交易选项，1 查询，2 调整，必填
          }.to_json

    # 6221775500000010 测试卡号。用于console复制。勿删。
    # q_req = {
    #         PapersType: "",                    # 证件种类，选填
    #         adjustmentIntegralPlan: "9975",    # 积分调整计划
    #         adjustmentIntegralValue: "",       # 积分调整值，选填
    #         adjustmentMark: "",                # 积分调整标志 + 加，- 减，选填
    #         cardNo: 6221775500000010, # 信用卡号，必填
    #         cardStateExamination: "N",         # 卡片状态检查 N:不检查（建议送N），必填
    #         certno: "",                        # 证件号码，选填
    #         checkItem: "0",                    # 检查项目选择， 默认为"0"， 不检查，必填
    #         competentNumber: "777733",         # 主管管号
    #         isPassword: "0",                   # 是否检查密码标志，0 不检查，1 卡片级别，2 取款密码，3 客户级别密码，必填
    #         password: "",                      # 密码，选填
    #         resaveDomain: "",                  # 保留域，目前填空
    #         source: "JBZCH",                   # 来源，回传
    #         tradeOptions: "1"                  # 交易选项，1 查询，2 调整，必填
    #       }.to_json

    self.request = q_req

    # Call the SPDB API.
    response = client.call(:query_point, message: { "in0" => q_req })
    self.response = response
    query_response_hash = response.to_hash[:query_point_response][:out].underscore
    self.update_attributes eval(query_response_hash)   #感觉这个非常吓人哈。注意注意！！！

    # self.user_id = current_user.id
    if self.save
      return self.account_convertibility_integral.to_i
    else
      logger.error "查询不成功。"
      redirect_to root_url, alert: "查询不成功，请重新尝试。要改。"
    end
  end
end
