require "rails_helper"

RSpec.describe ShowsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/shows").to route_to("shows#index")
    end

    it "routes to #show" do
      expect(get: "/shows/1").to route_to("shows#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/shows").to route_to("shows#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/shows/1").to route_to("shows#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/shows/1").to route_to("shows#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/shows/1").to route_to("shows#destroy", id: "1")
    end
  end
end
