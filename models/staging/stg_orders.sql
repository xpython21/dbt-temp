select
    -- from raw_orders
    o.orderid
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
from {{ ref('raw_orders') }} as o
left join {{ ref('raw_customer') }} as c
on o.customerid = c.customerid
left join {{ ref('raw_product') }} as p
on o.productid = p.productid
-- {{limit_data_in_dev('orderdate')}}   --> not working because, 1. date format, 2. not recent data