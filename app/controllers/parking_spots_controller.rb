class ParkingSpotsController < ApplicationController
  before_action :require_auth
  before_action :set_parking_spot, only: [:show, :edit, :update, :destroy]
  before_filter :massage_gps_coords, :only => [:create, :update]

  # GET /parking_spots.json
  def index
    @spots = ParkingSpot.where :deleted => false
  end

  # GET /parking_spots/1.json
  def show
  end

  # GET /parking_spots/new
  # def new
  #   @spot = ParkingSpot.new
  # end

  # GET /parking_spots/1/edit
  # def edit
  # end

  # POST /parking_spots.json
  def create
    @spot = ParkingSpot.new(parking_spot_params)
    @spot.created_by = current_user
    @spot.updated_by = current_user

    respond_to do |format|
      if @spot.save
        format.json { render :show, status: :created, location: @spot }
      else
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parking_spots/33332e5a-dc83-48c9-ad92-28a99095b47b.json
  def update
    respond_to do |format|
      if @spot.update parking_spot_params.merge(updated_by: current_user)
        format.json { render :show, status: :ok, location: @spot }
      else
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parking_spots/33332e5a-dc83-48c9-ad92-28a99095b47b.json
  def destroy
    respond_to do |format|
      if @spot.update :deleted => true
        format.json { render json: {:message => 'Parking spot was successfully deleted.'} }
      else
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parking_spot
      @spot = ParkingSpot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parking_spot_params
      params.require(:parking_spot).permit([:id, :name, :latitude, :longitude, :description, :paid, :spaces])
    end

    # For some reason BigDecimal in Ruby 2.1/2.2 likes to truncate certain floating point values before they can be converted to BigDecimal
    # See here http://stackoverflow.com/questions/28295583/why-are-my-bigdecimal-objects-initialized-with-unexpected-rounding-errors
    # Convert the gps parameters to strings so the bug is not triggered.
    def massage_gps_coords
      spot = params[:parking_spot]
      %i{latitude longitude}.each do |k|
        if spot.has_key?(k) && !spot[k].is_a?(String)
          spot[k] = spot[k].to_s
        end
      end
    end
end
