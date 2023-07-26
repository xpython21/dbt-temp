select
    -- from raw_orders
    {{ dbt_utils.generate_surrogate_key(['o.orderid', 'c.customerid', 'p.productid']) }} as sk_orders
    , o.orderid
    , o.orderdate
    , o.shipdate
    , o.shipmode
    , o.ordersellingprice - o.ordercostprice as orderprofit
    , o.ordercostprice
    , o.ordersellingprice
    -- from raw_customer
    , c.customerid
    , c.customername
    , c.segment
    , c.country
    -- from raw_product
    , p.productid
    , p.category
    , p.productname
    , p.subcategory
    , {{ markup('ordersellingprice', 'ordercostprice') }} as markup
    -- from delivery_team
    , d.delivery_team
from {{ ref('raw_orders') }} o
left join {{ ref('raw_customer') }} c
on o.customerid = c.customerid
left join {{ ref('raw_product') }} p
on o.productid = p.productid
left join {{ ref('delivery_team') }} d
on o.shipmode = d.shipmode

-- {{limit_data_in_dev('orderdate')}}   --> not working because, 1. date format, 2. not recent data