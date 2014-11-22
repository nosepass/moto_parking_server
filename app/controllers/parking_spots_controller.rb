class ParkingSpotsController < ApplicationController
  before_action :require_auth
  before_action :set_parking_spot, only: [:show, :edit, :update, :destroy]

  # GET /parking_spots.json
  def index
    @spots = ParkingSpot.all
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

    respond_to do |format|
      if @spot.save
        format.json { render :show, status: :created, location: @spot }
      else
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parking_spots/1.json
  def update
    respond_to do |format|
      if @spot.update(parking_spot_params)
        format.json { render :show, status: :ok, location: @spot }
      else
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parking_spots/1.json
  def destroy
    @spot.destroy!
    respond_to do |format|
      #format.json { head :no_content }
      format.json { render json: {:message => 'Parking spot was successfully destroyed.'} }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parking_spot
      @spot = ParkingSpot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parking_spot_params
      params.require(:parking_spot).permit([:name, :latitude, :longitude, :description, :paid, :spaces])
    end
end
