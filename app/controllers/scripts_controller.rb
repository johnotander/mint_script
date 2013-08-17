class ScriptsController < ApplicationController
  before_filter :authenticate_user!, except: [:try]
  
  # GET /scripts
  # GET /scripts.json
  def index
    @scripts = Script.where('user_id IN (?)', current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scripts }
    end
  end

  # GET /scripts/1
  # GET /scripts/1.json
  def show
    @script = Script.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @script }
    end
  end

  # GET /scripts/new
  # GET /scripts/new.json
  def new
    @script = Script.new
    @user = current_user
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @script }
    end
  end

  # GET /scripts/1/edit
  def edit
    @script = Script.find(params[:id])
    @user = current_user
  end

  # POST /scripts
  # POST /scripts.json
  def create
    @script = Script.new(params[:script])

    respond_to do |format|
      if @script.save
        format.html { redirect_to edit_script_path(@script) }
        format.json { render json: @script, status: :created, location: @script }
      else
        format.html { render action: :new }
        format.json { render json: @script.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /scripts/1
  # PUT /scripts/1.json
  def update
    @script = Script.find(params[:id])

    respond_to do |format|
      if @script.update_attributes(params[:script])
        format.html { redirect_to @script }
        format.json { head :no_content }
      else
        format.html { render action: :edit }
        format.json { render json: @script.errors, status: :unprocessable_entity }
      end
    end
  end

  def save
    @script = Script.where(id: params[:id]).first
    @script = Script.create!(user: current_user) unless @script

    respond_to do |format|
      if @script.update_attributes(params[:script])
        format.html { redirect_to scripts_path, 
                                  notice: "#{ @script.title || 'Your script' } was saved!" }
        format.json { render :saved }
      else
        format.html { render action: :edit }
        format.json { render json: @script.errors, status: :unprocessable_entity }
      end
    end
  end

  def private
    @script = Script.find(params[:id])

    respond_to do |format|
      if @script.update_attribute(:private, !@script.is_private?)
        format.html { redirect_to scripts_path, 
                                  notice: "#{ @script.title || 'Your script' } is now #{ @script.is_private? ? :private : :public }!" }
      else
        raise "ScriptsController.private #{ @script.inspect } wtf?"
      end
    end
  end

  # DELETE /scripts/1
  # DELETE /scripts/1.json
  def destroy
    @script = Script.find(params[:id])
    @script.destroy

    respond_to do |format|
      format.html { redirect_to scripts_path }
      format.json { head :no_content }
    end
  end
  
  def try
    @script = Script.new
  end
end
