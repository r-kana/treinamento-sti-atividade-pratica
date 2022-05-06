require "rails_helper"

RSpec.describe WaypointsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/waypoints").to route_to("waypoints#index")
    end

    it "routes to #new" do
      expect(get: "/waypoints/new").to route_to("waypoints#new")
    end

    it "routes to #show" do
      expect(get: "/waypoints/1").to route_to("waypoints#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/waypoints/1/edit").to route_to("waypoints#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/waypoints").to route_to("waypoints#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/waypoints/1").to route_to("waypoints#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/waypoints/1").to route_to("waypoints#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/waypoints/1").to route_to("waypoints#destroy", id: "1")
    end
  end
end
