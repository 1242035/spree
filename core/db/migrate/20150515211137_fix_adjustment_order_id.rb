class FixAdjustmentOrderId < ActiveRecord::Migration[4.2]
  def change
    say 'Populate order_id from adjustable_id where appropriate'
    execute(<<-SQL.squish)
      UPDATE
        viauco_adjustments
      SET
        order_id = adjustable_id
      WHERE
        adjustable_type = 'Viauco::Order'
      ;
    SQL

    # Submitter of change does not care about MySQL, as it is not officially supported.
    # Still viauco officials decided to provide a working code path for MySQL users, hence
    # submitter made a AR code path he could validate on PostgreSQL.
    #
    # Whoever runs a big enough MySQL installation where the AR solution hurts:
    # Will have to write a better MySQL specific equivalent.
    if Viauco::Order.connection.adapter_name.eql?('MySQL')
      Viauco::Adjustment.where(adjustable_type: 'Viauco::LineItem').find_each do |adjustment|
        adjustment.update_columns(order_id: Viauco::LineItem.find(adjustment.adjustable_id).order_id)
      end
    else
      execute(<<-SQL.squish)
        UPDATE
          viauco_adjustments
        SET
          order_id =
            (SELECT order_id FROM viauco_line_items WHERE viauco_line_items.id = viauco_adjustments.adjustable_id)
        WHERE
          adjustable_type = 'Viauco::LineItem'
      SQL
    end

    say 'Fix schema for viauco_adjustments order_id column'
    change_table :viauco_adjustments do |t|
      t.change :order_id, :integer, null: false
    end

    # Improved schema for postgresql, uncomment if you like it:
    #
    # # Negated Logical implication.
    # #
    # # When adjustable_type is 'Viauco::Order' (p) the adjustable_id must be order_id (q).
    # #
    # # When adjustable_type is NOT 'Viauco::Order' the adjustable id allowed to be any value (including of order_id in
    # # case foreign keys match). XOR does not work here.
    # #
    # # Postgresql does not have an operator for logical implication. So we need to build the following truth table
    # # via AND with OR:
    # #
    # #  p q | CHECK = !(p -> q)
    # #  -----------
    # #  t t | t
    # #  t f | f
    # #  f t | t
    # #  f f | t
    # #
    # # According to de-morgans law the logical implication q -> p is equivalent to !p || q
    # #
    # execute(<<-SQL.squish)
    #   ALTER TABLE ONLY viauco_adjustments
    #    ADD CONSTRAINT fk_viauco_adjustments FOREIGN KEY (order_id)
    #      REFERENCES viauco_orders(id) ON UPDATE RESTRICT ON DELETE RESTRICT,
    #    ADD CONSTRAINT check_viauco_adjustments_order_id CHECK
    #      (adjustable_type <> 'Viauco::Order' OR order_id = adjustable_id);
    # SQL
  end
end
