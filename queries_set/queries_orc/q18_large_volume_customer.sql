insert overwrite table q18_tmp
select 
  l_orderkey, sum(l_quantity) as t_sum_quantity
from 
  o_lineitem
group by l_orderkey;

select 
  c_name,c_custkey,o_orderkey,o_orderdate,o_totalprice,sum(l_quantity)
from 
  o_customer c join o_orders o 
  on 
    c.c_custkey = o.o_custkey
  join q18_tmp t 
  on 
    o.o_orderkey = t.l_orderkey and t.t_sum_quantity > 300
  join o_lineitem l 
  on 
    o.o_orderkey = l.l_orderkey
group by c_name,c_custkey,o_orderkey,o_orderdate,o_totalprice
order by o_totalprice desc,o_orderdate
limit 100;

