include: "//@{CONFIG_PROJECT_NAME}/orders.view"

view: orders {
  extends: [orders_config]
}

view: orders_core {
  sql_table_name: @{SHOPIFY_SCHEMA_NAME}.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer__id ;;
  }

  dimension: refunded_flag {
    type: yesno
    sql: ${order_refunds.order_id} is not null ;;
  }


  dimension_group: cancelled {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.cancelled_at ;;
  }
  dimension: cancelled_flag {
    type: yesno
    sql: ${cancelled_date} is null ;;
  }


  dimension: confirmed {
    type: yesno
    sql: ${TABLE}.confirmed ;;
  }

  dimension: contact_email {
    type: string
    sql: ${TABLE}.contact_email ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: reporting_period {
    group_label: "Order Date"
    sql: CASE
      WHEN date_part('year',${created_raw}) = date_part('year',current_date)
      AND ${created_raw} < CURRENT_DATE
      THEN 'This year to date'

      WHEN date_part('year',${created_raw}) + 1 = date_part('year',current_date)
      AND date_part('DOY',${created_raw}) <= date_part('DOY',current_date)
      THEN 'Last Year to Date'
      END
      ;;
  }

  dimension: is_before_mtd {
    type: yesno
#   hidden: yes
    sql:
    (EXTRACT(DAY FROM ${created_date}) < EXTRACT(DAY FROM current_date)
      OR
      (
        EXTRACT(DAY FROM ${created_date}) = EXTRACT(DAY FROM current_date) AND
        EXTRACT(HOUR FROM ${created_date}) < EXTRACT(HOUR FROM current_date)
      )
      OR
      (
        EXTRACT(DAY FROM ${created_date}) = EXTRACT(DAY FROM current_date) AND
        EXTRACT(HOUR FROM ${created_date}) <= EXTRACT(HOUR FROM current_date) AND
        EXTRACT(MINUTE FROM ${created_date}) < EXTRACT(MINUTE FROM current_date)
      )
    );;

    }
  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: customer_accepts_marketing {
    type: yesno
    sql: ${TABLE}.customer__accepts_marketing ;;
  }

  dimension_group: customer_created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.customer__created_at ;;
  }

  dimension: customer_default_address__address1 {
    type: string
    sql: ${TABLE}.customer__default_address__address1 ;;
  }

  dimension: customer_default_address__city {
    type: string
    sql: ${TABLE}.customer__default_address__city ;;
  }

  dimension: customer_default_address__company {
    type: string
    sql: ${TABLE}.customer__default_address__company ;;
  }

  dimension: customer_default_address__country {
    type: string
    sql: ${TABLE}.customer__default_address__country ;;
  }

  dimension: customer_default_address__country_code {
    type: string
    sql: ${TABLE}.customer__default_address__country_code ;;
  }

  dimension: customer_default_address__country_name {
    type: string
    sql: ${TABLE}.customer__default_address__country_name ;;
  }

  dimension: landing_site {
    type: string
    sql: ${TABLE}.landing_site ;;
  }

  dimension: landing_site_ref {
    type: string
    sql: ${TABLE}.landing_site_ref ;;
  }



  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: note {
    type: string
    sql: ${TABLE}.note ;;
  }

  dimension: number {
    type: number
    sql: ${TABLE}.number ;;
  }

  dimension: order_number {
    type: number
    sql: ${TABLE}.order_number ;;
    value_format_name: id
  }

  dimension: order_status_url {
    type: string
    sql: ${TABLE}.order_status_url ;;
  }


  dimension: shipping_address1 {
    type: string
    sql: ${TABLE}.shipping_address__address1 ;;
  }

  dimension: shipping_address2 {
    type: string
    sql: ${TABLE}.shipping_address__address2 ;;
  }

  dimension: shipping_city {
    type: string
    sql: ${TABLE}.shipping_address__city ;;
  }

  dimension: shipping_company {
    type: string
    sql: ${TABLE}.shipping_address__company ;;
  }

  dimension: shipping_country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.shipping_address__country ;;
  }

  dimension: shipping_country_code {
    type: string
    sql: ${TABLE}.shipping_address__country_code ;;
  }

  dimension: shipping_first_name {
    type: string
    sql: ${TABLE}.shipping_address__first_name ;;
  }

  dimension: shipping_last_name {
    type: string
    sql: ${TABLE}.shipping_address__last_name ;;
  }

  dimension: shipping_address__latitude {
    type: number
    sql: ${TABLE}.shipping_address__latitude ;;
  }

  dimension: shipping_address__longitude {
    type: number
    sql: ${TABLE}.shipping_address__longitude ;;
  }
  dimension:  shipping_location {
    type: location
    sql_latitude: round(cast(${shipping_address__latitude} as int),3)  ;;
    sql_longitude: round(cast(${shipping_address__longitude} as int),3) ;;
  }

  dimension: shipping_address__name {
    type: string
    sql: ${TABLE}.shipping_address__name ;;
  }



  dimension: source_name {
    type: string
    sql: ${TABLE}.source_name ;;
  }

  dimension: subtotal_price {
    type: number
    sql: ${TABLE}.subtotal_price ;;
  }


  dimension: taxes_included {
    type: yesno
    sql: ${TABLE}.taxes_included ;;
  }


  dimension: total_discounts {
    type: number
    sql: ${TABLE}.total_discounts ;;
  }

  dimension: total_line_items_price {
    type: number
    sql: ${TABLE}.total_line_items_price ;;
  }

  dimension: total_price {
    type: number
    sql: ${TABLE}.total_price ;;
  }

  dimension: total_price_usd {
    type: number
    sql: ${TABLE}.total_price_usd ;;
  }

  dimension: total_tax {
    type: number
    sql: ${TABLE}.total_tax ;;
  }

  dimension: total_weight {
    type: number
    sql: ${TABLE}.total_weight ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }
  measure: total_order_revenue {
    type: sum
    sql: ${total_price_usd} ;;
    value_format_name:largeamount
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,customers.name,order_number,products.title,orders__line_items.vendor,total_order_revenue,shipping_city,shipping_country,products.product_image
    ]
  }
}
