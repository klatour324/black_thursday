require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant_repo'
require './lib/item_repo'
require './lib/item'
require './lib/merchant'

class MerchantRepoTest < Minitest::Test
  def test_create_instance_of_mr
    se = SalesEngine.from_csv({
                                :items     => './data/items.csv',
                                :merchants => './data/merchants.csv'
                              })

    mr = se.merchants
    assert_instance_of MerchantRepo, mr
  end

  def test_return_array_of_all_merchants
    se = SalesEngine.from_csv({
                                :items     => './data/items.csv',
                                :merchants => './data/merchants.csv'
                              })

    mr = se.merchants
    assert_equal mr.merchant_list, mr.all
  end

  def test_it_returns_nil_if_no_id_is_found
    se = SalesEngine.from_csv({
                                :items     => './data/items.csv',
                                :merchants => './data/merchants.csv'
                              })

    mr = se.merchants
    merchant = mr.find_by_id("000000")
    assert_nil merchant
  end

  def test_it_returns_a_merchant_id
    se = SalesEngine.from_csv({
                                :items     => './data/items.csv',
                                :merchants => './data/merchants.csv'
                              })

    mr = se.merchants
    expected = mr.find_by_id(12334105)
    assert_equal 12334105, expected.id
  end

  def test_it_returns_nil_if_no_name_is_found
    se = SalesEngine.from_csv({
                                :items     => './data/items.csv',
                                :merchants => './data/merchants.csv'
                              })

    mr = se.merchants
    merchant = mr.find_by_name("Akskakbfekh")
    assert_nil merchant
  end

  def test_it_returns_a_merchant_name
    se = SalesEngine.from_csv({
                                :items     => './data/items.csv',
                                :merchants => './data/merchants.csv'
                              })

    mr = se.merchants
    expected = mr.find_by_name("Shopin1901")
    assert_equal "Shopin1901", expected.name
  end

  def test_it_returns_an_empty_array_when_no_name_matches_the_input
    se = SalesEngine.from_csv({
                                :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv",
                              })
    mr = se.merchants
    expected = mr.find_all_by_name("")
    assert_equal [], expected
  end

  def test_it_can_return_one_or_more_matches_of_the_name
    se = SalesEngine.from_csv({
                                :items     => "./data/items.csv",
                                :merchants => "./fixtures/merchant_sample.csv",
                              })
    mr = se.merchants
    merchant_array = mr.find_all_by_name("Mota")
    assert_equal "MotankiDarena", merchant_array[0].name
  end

  def test_it_can_create_merchants_with_attributes
    se = SalesEngine.from_csv({
                                :items     => "./data/items.csv",
                                :merchants => "./fixtures/merchant_sample.csv",
                              })
    mr = se.merchants
    all_merchants = mr.create({:name => "byMarieinLondon"})
    assert_equal 12334196, all_merchants[5].id
  end

  def test_it_can_update_merchant_name_attribute
    attributes = {
                  name: "TSSD"
                  }


    se = SalesEngine.from_csv({
                                :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv"
                              })
    mr = se.merchants
    not_found = "Turing School of Software and Design"
    assert_equal "TSSD",mr.name
    assert_nil not_found
  end

  def test_delete_id
    se = SalesEngine.from_csv({
                                :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv"
                              })
    mr   = se.merchants
    mr.delete(12337412)
    expected = se.merchants.find_by_id(12337412)
    assert_nil expected
  end
end
