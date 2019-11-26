include: "//@{CONFIG_PROJECT_NAME}/customer_order_facts.view"

view: customer_order_facts {
  extends: [customer_order_facts_config]
}

view: customer_order_facts_core {
  derived_table: {
#     sql_trigger_value: SELECT CURRENT_DATE ;;
#     sortkeys: [customer_id]
#     distribution: "customer_id"
  sql: SELECT
           customer__id as customer_id
          , COUNT(*) as lifetime_orders
          , SUM(total_price_usd) as lifetime_revenue
          , MAX(created_at) as latest_order_created
          , MIN(created_at) as first_order_created
          , COUNT(DISTINCT DATE_TRUNC('month', created_at)) AS number_of_distinct_months_with_orders
         FROM shopify.orders
         GROUP BY customer_id

 ;;
}


dimension: customer_id {
  primary_key: yes
  type: number
  sql: ${TABLE}.customer_id ;;
}

dimension: lifetime_orders {
  hidden: yes
  type: number
  sql: ${TABLE}.lifetime_orders ;;
}

dimension: lifetime_revenue {
  hidden: yes
  type: number
  sql: ${TABLE}.lifetime_revenue ;;
}

dimension: latest_order_created {
  type: string
  sql: ${TABLE}.latest_order_created ;;
}

dimension: first_order_created {
  type: string
  sql: ${TABLE}.first_order_created ;;
}

dimension: number_of_distinct_months_with_orders {
  type: number
  sql: ${TABLE}.number_of_distinct_months_with_orders ;;
}

measure: total_lifetime_revenue {
  type: sum
  description: "Does not include revenue generated from NULL customer_ids, when we don't know who the customer is"
  sql: ${lifetime_revenue} ;;
  value_format_name: usd_0
}

measure: total_lifetime_orders {
  type: sum
  sql: ${lifetime_orders} ;;
  value_format_name: usd_0
}

set: detail {
  fields: [
    customer_id,
    lifetime_orders,
    lifetime_revenue,
    latest_order_created,
    first_order_created,
    number_of_distinct_months_with_orders
  ]
}
}
