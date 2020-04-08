require "test_helper"
require "gds_api/test_helpers/publishing_api"

class ContentItemPublisherTest < ActiveSupport::TestCase
  include GdsApi::TestHelpers::PublishingApi

  setup do
    load_path = fixture_file("smart_answer_flows")
    SmartAnswer::FlowRegistry.stubs(:instance).returns(stub("Flow registry", find: @flow, load_path: load_path))
  end

  context "#sync" do
    setup do
      start_page_content_id = SecureRandom.uuid
      flow_content_id = SecureRandom.uuid
      @start_page_draft_request = stub_publishing_api_put_content(start_page_content_id, {})
      @start_page_publishing_request = stub_publishing_api_publish(start_page_content_id, {})
      @flow_draft_request = stub_publishing_api_put_content(flow_content_id, {})
      @flow_publishing_request = stub_publishing_api_publish(flow_content_id, {})
      @flow = stub("flow",
                   name: "bridge-of-death",
                   start_page_content_id: start_page_content_id,
                   flow_content_id: flow_content_id,
                   external_related_links: nil,
                   nodes: [])
    end

    should "create a preview for a draft smart answer" do
      @flow.stubs(:status).returns(:draft)
      presenter = FlowRegistrationPresenter.new(@flow)
      ContentItemPublisher.new.sync([presenter])

      assert_requested @start_page_draft_request
      assert_not_requested @start_page_publishing_request
      assert_requested @flow_draft_request
      assert_not_requested @flow_publishing_request
    end

    should "publish a published smart answer" do
      @flow.stubs(:status).returns(:published)
      presenter = FlowRegistrationPresenter.new(@flow)
      ContentItemPublisher.new.sync([presenter])

      assert_requested @start_page_draft_request
      assert_requested @start_page_publishing_request
      assert_requested @flow_draft_request
      assert_requested @flow_publishing_request
    end
  end
end
