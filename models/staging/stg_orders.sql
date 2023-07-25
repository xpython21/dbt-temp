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
    , c.customername
    , c.segment
    , c.country
    -- from raw_product
    , p.category
    , p.productname
    , p.subcategory
from {{ ref('raw_orders') }} o
left join {{ ref('raw_customer') }} c
on o.customerid = c.customerid
left join {{ ref('raw_product') }} p
on p.productid = p.productid