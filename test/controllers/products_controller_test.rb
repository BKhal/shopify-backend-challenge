require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count', 1, 'Did not create product') do
      post products_url, params: { product: { name: "NewProduct", quantity: 3 } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should only create product with unique name" do
    assert_no_difference('Product.count', 'Product name not unique') do
      post products_url, params: { product: { name: @product.name, quantity: @product.quantity } }
    end
  end

  test "should not create product without name" do
    assert_no_difference('Product.count', 'Created product without name') do
      post products_url, params: { product: { quantity: @product.quantity } }
    end
  end

  test "should not create product without quantity" do
    assert_no_difference('Product.count', 'Created product without quantity') do
      post products_url, params: { product: { name: "NewProduct" } }
    end
  end

  test "should create product with 0 quantity" do
    assert_difference('Product.count', 1, 'Did not create product with 0 quantity') do
      post products_url, params: { product: { name: "NewProduct", quantity: 0 } }
    end
  end

  test "should not create product with negative quantity" do
    assert_no_difference('Product.count', 'Created product with negative quantity') do
      post products_url, params: { product: { name: "NewProduct", quantity: -1 } }
    end
  end

  test "should not create product with non-integer quantity" do
    assert_no_difference('Product.count', 'Created product with decimal quantity') do
      post products_url, params: { product: { name: "NewProduct", quantity: 1.5 } }
    end
    assert_no_difference('Product.count', 'Created product with string quantity') do
      post products_url, params: { product: { name: "NewProduct", quantity: "four" } }
    end
  end

  test "should not attempt to create product with quantity greater than integer max value" do
    post products_url, params: { product: { name: "NewProduct", quantity: 2**32 } }
    assert_response 422 # 422 is the Unprocessable Entity response
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { name: @product.name, quantity: @product.quantity } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
