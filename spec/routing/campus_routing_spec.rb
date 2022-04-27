require "rails_helper"

RSpec.describe CampusController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/campus").to route_to("campus#index")
    end

    it "routes to #new" do
      expect(get: "/campus/new").to route_to("campus#new")
    end

    it "routes to #show" do
      expect(get: "/campus/1").to route_to("campus#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/campus/1/edit").to route_to("campus#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/campus").to route_to("campus#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/campus/1").to route_to("campus#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/campus/1").to route_to("campus#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/campus/1").to route_to("campus#destroy", id: "1")
    end
  end
end
