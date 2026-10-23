require_relative "test_helper"

# Every documented endpoint, at the API version the client calls it on.
class Ancon::EndpointsTest < Minitest::Test
  include AnconTestHelpers

  TENANT = "#{API_URL}/v1/Tenants/t".freeze
  OUTLET = "#{API_URL}/v1/Outlets/o".freeze
  CHECKS = "#{API_URL}/v2/Outlets/o/Checks".freeze
  BODY = {"name" => "x"}.freeze

  TENANT_ENDPOINTS = {
    "GET #{TENANT}/Integrations/Current" => ->(t) { t.current_integration },
    "GET #{TENANT}/AddOnGroups" => ->(t) { t.add_on_groups.list },
    "GET #{TENANT}/AddOnGroups/1" => ->(t) { t.add_on_groups.retrieve(1) },
    "GET #{TENANT}/Discounts" => ->(t) { t.discounts.list },
    "GET #{API_URL}/v1.1/Tenants/t/Discounts/1" => ->(t) { t.discounts.retrieve(1) },
    "GET #{TENANT}/Fees" => ->(t) { t.fees.list },
    "GET #{TENANT}/Fees/1" => ->(t) { t.fees.retrieve(1) },
    "GET #{TENANT}/Ingredients" => ->(t) { t.ingredients.list },
    "GET #{TENANT}/Ingredients/1" => ->(t) { t.ingredients.retrieve(1) },
    "GET #{TENANT}/MenuTrees?OutletId=o" => ->(t) { t.menu_trees.list(OutletId: "o") },
    "GET #{TENANT}/MenuTrees/1" => ->(t) { t.menu_trees.retrieve(1) },
    "GET #{TENANT}/Outlets/o/MenuTrees/1/Hierarchy?DayOfWeek=Monday" =>
      ->(t) { t.menu_trees.hierarchy(1, outlet_id: "o", DayOfWeek: "Monday") },
    "GET #{TENANT}/MetadataTemplate" => ->(t) { t.metadata_templates.list },
    "GET #{TENANT}/MetadataTemplate/1" => ->(t) { t.metadata_templates.retrieve(1) },
    "POST #{TENANT}/MetadataTemplate" => ->(t) { t.metadata_templates.create(BODY) },
    "PUT #{TENANT}/MetadataTemplate/1" => ->(t) { t.metadata_templates.update(1, BODY) },
    "DELETE #{TENANT}/MetadataTemplate/1" => ->(t) { t.metadata_templates.delete(1) },
    "GET #{TENANT}/ProductGroups" => ->(t) { t.product_groups.list },
    "GET #{TENANT}/ProductGroups/1" => ->(t) { t.product_groups.retrieve(1) },
    "POST #{API_URL}/v1.1/Tenants/t/ProductGroups" => ->(t) { t.product_groups.create(BODY) },
    "PUT #{API_URL}/v1.1/Tenants/t/ProductGroups/1" => ->(t) { t.product_groups.update(1, BODY) },
    "DELETE #{TENANT}/ProductGroups/1" => ->(t) { t.product_groups.delete(1) },
    "GET #{TENANT}/Products" => ->(t) { t.products.list },
    "GET #{API_URL}/v1.1/Tenants/t/Products/1" => ->(t) { t.products.retrieve(1) },
    "POST #{TENANT}/Products" => ->(t) { t.products.create(BODY) },
    "PUT #{TENANT}/Products/1" => ->(t) { t.products.update(1, BODY) },
    "DELETE #{TENANT}/Products/1" => ->(t) { t.products.delete(1) },
    "PUT #{TENANT}/Products/1/publish" => ->(t) { t.products.publish(1) },
    "PUT #{TENANT}/Products/1/productAvailabilities" => ->(t) { t.products.update_availabilities(1, BODY) },
    "PUT #{TENANT}/Products/1/shares" => ->(t) { t.products.update_shares(1, BODY) },
    "POST #{TENANT}/Products/1/variants" => ->(t) { t.products.create_variant(1, BODY) },
    "PUT #{TENANT}/Products/1/variants/2" => ->(t) { t.products.update_variant(1, 2, BODY) },
    "PUT #{TENANT}/Products/1/tags" => ->(t) { t.products.update_tags(1, BODY) },
    "PUT #{TENANT}/Products/1/metadata" => ->(t) { t.products.update_metadata(1, BODY) },
    "PUT #{TENANT}/Products/1/SubProducts" => ->(t) { t.products.update_sub_products(1, BODY) },
    "GET #{TENANT}/SaleSources" => ->(t) { t.sale_sources.list },
    "GET #{TENANT}/Tags" => ->(t) { t.tags.list },
    "GET #{TENANT}/Taxes" => ->(t) { t.taxes.list },
    "GET #{TENANT}/Taxes/1" => ->(t) { t.taxes.retrieve(1) },
    "GET #{TENANT}/TenantUsers/1" => ->(t) { t.tenant_users.retrieve(1) },
    "GET #{TENANT}/UpsellGroups" => ->(t) { t.upsell_groups.list },
    "GET #{TENANT}/UpsellGroups/1" => ->(t) { t.upsell_groups.retrieve(1) },
    "GET #{API_URL}/v1.2/Tenants/t/WayOfPayments" => ->(t) { t.way_of_payments.list },
    "GET #{API_URL}/v1.2/Tenants/t/WayOfPayments/1" => ->(t) { t.way_of_payments.retrieve(1) },
    "GET #{API_URL}/v1.2/Tenants/t/WayOfPayments/1?Extent.Outlets=true&Extent.Accounts=true" =>
      ->(t) { t.way_of_payments.retrieve(1, outlets: true, accounts: true) }
  }.freeze

  OUTLET_ENDPOINTS = {
    "GET #{API_URL}/v1.1/Outlets/o" => ->(o) { o.retrieve },
    "PUT #{OUTLET}" => ->(o) { o.update(BODY) },
    "GET #{CHECKS}" => ->(o) { o.checks.list },
    "GET #{CHECKS}/SalesLocations/s" => ->(o) { o.checks.list_for_sales_location("s") },
    "GET #{CHECKS}/1" => ->(o) { o.checks.retrieve(1) },
    "POST #{CHECKS}" => ->(o) { o.checks.create(BODY) },
    "DELETE #{CHECKS}/1" => ->(o) { o.checks.delete(1) },
    "POST #{CHECKS}/AddItem" => ->(o) { o.checks.add_item(BODY) },
    "POST #{CHECKS}/1/Items" => ->(o) { o.checks.add_items(1, BODY) },
    "PUT #{CHECKS}/1/Move" => ->(o) { o.checks.move(1, BODY) },
    "PUT #{CHECKS}/1/CustomName" => ->(o) { o.checks.update_custom_name(1, BODY) },
    "PUT #{CHECKS}/1/CustomTicket" => ->(o) { o.checks.update_custom_ticket(1, BODY) },
    "PUT #{CHECKS}/1/Discount" => ->(o) { o.checks.discount(1, BODY) },
    "PUT #{CHECKS}/1/Split" => ->(o) { o.checks.split(1, BODY) },
    "PUT #{CHECKS}/1/Items/Split" => ->(o) { o.checks.split_items(1, BODY) },
    "PUT #{CHECKS}/1/Items/Discount" => ->(o) { o.checks.discount_items(1, BODY) },
    "PUT #{CHECKS}/1/TableReservationMetaData" => ->(o) { o.checks.update_table_reservation(1, BODY) },
    "PUT #{CHECKS}/1/IntegrationPayment" => ->(o) { o.checks.create_integration_payment(1, BODY) },
    "GET #{OUTLET}/Checkouts/1" => ->(o) { o.checkouts.retrieve(1) },
    "POST #{OUTLET}/Checkouts" => ->(o) { o.checkouts.create(BODY) },
    "DELETE #{OUTLET}/Checkouts/1" => ->(o) { o.checkouts.delete(1) },
    "PUT #{OUTLET}/Checkouts/1/RecalculatePrice" => ->(o) { o.checkouts.recalculate_price(1) },
    "PUT #{OUTLET}/Checkouts/1/ApplyDiscount" => ->(o) { o.checkouts.apply_discount(1, BODY) },
    "POST #{OUTLET}/Checkouts/1/Payments" => ->(o) { o.checkouts.create_payment(1, BODY) },
    "GET #{OUTLET}/ClientGroups" => ->(o) { o.client_groups.list },
    "GET #{OUTLET}/ClientGroups/1" => ->(o) { o.client_groups.retrieve(1) },
    "POST #{OUTLET}/ClientGroups" => ->(o) { o.client_groups.create(BODY) },
    "PUT #{OUTLET}/ClientGroups/1" => ->(o) { o.client_groups.update(1, BODY) },
    "DELETE #{OUTLET}/ClientGroups/1" => ->(o) { o.client_groups.delete(1) },
    "GET #{OUTLET}/Clients" => ->(o) { o.clients.list },
    "GET #{OUTLET}/Invoices?Handled=false" => ->(o) { o.invoices.list(Handled: false) },
    "PUT #{OUTLET}/Invoices/Status" => ->(o) { o.invoices.update_status(BODY) },
    "GET #{OUTLET}/Orders/DetailedList" => ->(o) { o.orders.detailed_list },
    "GET #{OUTLET}/Orders/1" => ->(o) { o.orders.retrieve(1) },
    "GET #{OUTLET}/Sections" => ->(o) { o.sections.list },
    "GET #{OUTLET}/Sections/1/Status" => ->(o) { o.sections.status(1) },
    "GET #{OUTLET}/Sections/1/Tables?Limit=5" => ->(o) { o.sections.tables(1, limit: 5) },
    "GET #{OUTLET}/SettlementReports" => ->(o) { o.settlement_reports.list },
    "GET #{OUTLET}/Tables" => ->(o) { o.tables.list },
    "PUT #{OUTLET}/Tables/1" => ->(o) { o.tables.update(1, BODY) },
    "GET #{OUTLET}/Tickets/1" => ->(o) { o.tickets.retrieve(1) },
    "GET #{OUTLET}/Tickets/DetailedList" => ->(o) { o.tickets.detailed_list }
  }.freeze

  def test_tenant_endpoints
    TENANT_ENDPOINTS.each do |endpoint, call|
      call.call(client.tenant("t"))
      assert_request(*endpoint.split(" ", 2))
    end
  end

  def test_outlet_endpoints
    OUTLET_ENDPOINTS.each do |endpoint, call|
      call.call(client.outlet("o"))
      assert_request(*endpoint.split(" ", 2))
    end
  end

  def test_writes_send_the_body
    client.tenant("t").products.update_variant(1, 2, BODY)

    assert_equal BODY.to_json, last_request.body
  end

  def test_deleting_a_check_sends_the_reason
    client.outlet("o").checks.delete(1, reason: "Guest left")

    assert_equal '{"reason":"Guest left"}', last_request.body
  end
end
