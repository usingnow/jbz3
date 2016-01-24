class AdjustPoint < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  has_many :request_dynamic_passwords

  # 调用接口,构建数据结构。
  def build_req(creditcard_num, adjusted_point)
    req = {
            PaperType: "",                                 # 证件种类，选填
            adjustmentIntegralPlan: "9975",                # 积分调整计划
            adjustmentIntegralValue: adjusted_point.to_s,  # 积分调整值，选填
            adjustmentMark: "+",             # 积分调整标志 + 加，- 减，选填
            cardNo: creditcard_num.to_s,     # 信用卡号，必填
            cardStateExamination: "N",       # 卡片状态检查 N:不检查（建议送N），必填
            certno: "350821198710103357",    # 证件号码，选填
            checkItem: "0",                  # 检查项目选择， 默认为"0"， 不检查，必填
            competentNumber: "777799",       # 主管管号
            isPassword: "0",                 # 是否检查密码标志，0 不检查，1 卡片级别，2 取款密码，3 客户级别密码，必填
            resaveDomain: "",                # 保留域，目前填空
            source: "jbz",                   # 来源，回传
            tradeOption: "2"                 # 交易选项，1 查询，2 调整，必填
          }
  end

  # 调用接口，调整积分值。
  def adjust_point
  end

  # 调用接口，传送动态密码，由浦发sms接口发送至用户手机。
  def process_dynamic_password
  end

  private
    def set_connection
      # UAT "http://172.30.122.161:8002/spdbcccLife/services/DynamicPsw?wsdl"
      # PRD "http://172.20.112.73:9000/spdbcccLife/services/DynamicPsw?wsdl"

      client = Savon.client(wsdl: "http://172.30.122.161:8002/spdbcccLife/services/DynamicPsw?wsdl")
    end

    def build_req
      req = {
            PaperType: "",                   # 证件种类，选填
            adjustmentIntegralPlan: "9975",  # 积分调整计划
            # adjustmentIntegralValue: "0",  # 积分调整值，选填
            adjustmentMark: "+",             # 积分调整标志 + 加，- 减，选填
            cardNo: "6221775500000010",      # 信用卡号，必填
            cardStateExamination: "N",       # 卡片状态检查 N:不检查（建议送N），必填
            certno: "350821198710103357",    # 证件号码，选填
            checkItem: "0",                  # 检查项目选择， 默认为"0"， 不检查，必填
            competentNumber: "777799",       # 主管管号
            isPassword: "0",                 # 是否检查密码标志，0 不检查，1 卡片级别，2 取款密码，3 客户级别密码，必填
            resaveDomain: "",                # 保留域，目前填空
            source: "jbz",                   # 来源，回传
            tradeOption: "1"                 # 交易选项，1 查询，2 调整，必填
          }
    end
end
