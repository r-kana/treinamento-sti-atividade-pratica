require 'rails_helper'

RSpec.describe "/rides", type: :request do

  let!(:college) {create(:college)}
  let!(:driver) {create(:user)}
  let(:valid_attributes) {
    {
      observation: " ", seats: 4, date: "10/05/2022", time: "20:30:00", 
      to_college: false, price: 0.0, driver_id: driver.id, college_id: college.id
    }
  }

  let(:invalid_attributes) {
    { observation: " ", seats: nil, date: nil, time: nil, to_college: nil, price: nil }
  }

  describe "GET user/:user_id/index" do
    it "renders a successful response" do
      create(:ride, driver: driver, college_id: college.id)

      get user_rides_url(driver)
      expect(response).to be_successful
    end

    it "renders a template for :index" do
      get user_rides_url(driver)
      expect(response.content_type).to start_with("text/html")
      expect(response).to render_template(:index)
    end
  end

  describe "GET users/:user_id/new" do
    it "renders a successful response with :new template" do
      get new_user_ride_url(driver)
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe "GET users/:user_id/edit/:id" do
    it "renders a successful response with :edit template" do
      ride = create(:ride, driver: driver, college_id: college.id)
      get edit_user_ride_url(driver, ride)
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  describe "POST users/:user_id/create" do
    context "with valid parameters" do
      it "creates a new Ride" do
        expect {
          post user_rides_url(driver), params: { ride: valid_attributes }
        }.to change(Ride, :count).by(1)
      end

      it "redirects to the created ride" do
        post user_rides_url(driver), params: { ride: valid_attributes }

        expect(response).to redirect_to(user_ride_path(driver, Ride.last))
        follow_redirect!  
        expect(response).to render_template(:show)
        expect(response.body).to include("Ride was successfully created.")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Ride" do
        expect {
          post user_rides_url(driver), params: { ride: invalid_attributes }
        }.to change(Ride, :count).by(0)
      end

      it "renders :new template" do
        post user_rides_url(driver), params: { ride: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH users/:user_id/update/:id" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          observation: "Nova observação", seats: 4, date: "11/05/2022", time: "18:30:00", 
          to_college: false, price: 0.0, driver_id: driver.id, college_id: college.id
        }
      }

      it "updates the requested ride" do
        ride = create(:ride, driver: driver, college_id: college.id)
        patch user_ride_url(driver, ride), params: { ride: new_attributes }
        ride.reload
        expect(response).to redirect_to(user_ride_url(driver, ride))
      end

      it "redirects to the ride" do
        ride = create(:ride, driver: driver, college_id: college.id)
        patch user_ride_url(driver, ride), params: { ride: new_attributes }
        ride.reload
        expect(response).to redirect_to(user_ride_url(driver, ride))
        follow_redirect!
        expect(response).to render_template(:show)
      end
    end

    context "with invalid parameters" do
      xit "renders a successful response (i.e. to display the 'edit' template)" do
        ride = Ride.create! valid_attributes
        patch ride_url(ride), params: { ride: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE users?:uder_id/destroy/:id" do
    xit "destroys the requested ride" do
      ride = Ride.create! valid_attributes
      expect {
        delete ride_url(ride)
      }.to change(Ride, :count).by(-1)
    end

    xit "redirects to the rides list" do
      ride = Ride.create! valid_attributes
      delete ride_url(ride)
      expect(response).to redirect_to(rides_url)
    end
  end
end
