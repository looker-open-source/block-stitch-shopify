include: "//@{CONFIG_PROJECT_NAME}/order_facts.view"

view: order_facts {
  extends: [order_facts_config]
}

view: order_facts_core {
    derived_table: {
      explore_source: order_line_items{
        column: order_id {}
        column: items_in_order {field: order_line_items.count}
        column: order_amount {field: orders.total_order}
        #column: order_cost { field: inventory_items.total_cost }
        column: user_id {field: customers.id }
        column: created_at {field: orders.created_raw}
        column: order_gross_margin {field: order_items.total_gross_margin}
        derived_column: order_sequence_number {
          sql: RANK() OVER (PARTITION BY user_id ORDER BY created_at) ;;
        }
      }
    }

}
