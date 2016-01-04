# 直接写入数据库保险产品与sku信息。

Product.delete_all
JbzSku.delete_all

Product.create!(name:               '爱易分“积分储蓄”年金返还保障计划',
                description:        '将积分对应的原价返还至客户指定账户，额外赠送全年高额公共轨道交通保障。',
                image_url:          'product.png',
                insurance_cycle:    1,
                age_starts_at:      18,
                age_ends_at:        55,
                benifit:            '理财产品的好处，理财产品的好处，理财产品的好处，理财产品的好处，理财产品的好处，理财产品的好处，理财产品的好处，理财产品的好处。',
                acknowledgement:    '保障须知', 
                recommendation:     '产品解读')

period     = ['即时版','季度版','半年版','全年版']
redemption = ['90天赎回', '180天赎回', '360天赎回', '360天以上赎回']
interests  = [0, 0.2, 0.5, 1]

(1..4).each do |n|
  JbzSku.create!(title:             '爱易分“积分储蓄”年金返还保障计划（' + period[n-1] + '）',
                 price:             100.00 + interests[n-1],
                 original_price:    100.00 + interests[n-1],
                 reward:            102000,
                 sales_volume:      0,
                 ref:               'ins000' + n.to_s,
                 product_id:        1,
                 redemption:        redemption[n-1])
end