{% macro markup(sellingprice, costprice, scale=3) %}
(({{sellingprice}} - {{costprice}})/{{costprice}})::numeric(16, {{scale}})
{% endmacro %}