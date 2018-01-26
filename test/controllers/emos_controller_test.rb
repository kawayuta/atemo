require 'test_helper'

class EmosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @emo = emos(:one)
  end

  test "should get index" do
    get emos_url
    assert_response :success
  end

  test "should get new" do
    get new_emo_url
    assert_response :success
  end

  test "should create emo" do
    assert_difference('Emo.count') do
      post emos_url, params: { emo: { emo: @emo.emo, text: @emo.text } }
    end

    assert_redirected_to emo_url(Emo.last)
  end

  test "should show emo" do
    get emo_url(@emo)
    assert_response :success
  end

  test "should get edit" do
    get edit_emo_url(@emo)
    assert_response :success
  end

  test "should update emo" do
    patch emo_url(@emo), params: { emo: { emo: @emo.emo, text: @emo.text } }
    assert_redirected_to emo_url(@emo)
  end

  test "should destroy emo" do
    assert_difference('Emo.count', -1) do
      delete emo_url(@emo)
    end

    assert_redirected_to emos_url
  end
end
