class EmosController < ApplicationController
  before_action :set_emo, only: [:show, :edit, :update, :destroy]

  # GET /emos
  # GET /emos.json
  def index
    @emos = Emo.all
    @emo = Emo.new
  end

  # GET /emos/1
  # GET /emos/1.json
  def show
    @mecab = Natto::MeCab.new("-Ochasen")
  end

  # GET /emos/new
  def new
    @emo = Emo.new
  end

  # GET /emos/1/edit
  def edit
  end

  # POST /emos
  # POST /emos.json
  def create
    @emo = Emo.new(emo_params)

    require "negapoji"

    @emo.emo = (Negapoji.judge(@emo.text) == 'positive' if @emo.text.is_a?(String)) ? 1 : 0
    @emo.point = Negapoji.pointing(@emo.text) if @emo.text.is_a?(String)
    @emo.words_points = Negapoji.word_pointing(@emo.text) if @emo.text.is_a?(String)

    the_words_colors = {}
    @emo.words_points.each do |wp|
     the_words_colors[wp[0]] = ((wp[1] + 1) / 0.0078).to_i
    end
    @emo.words_colors = the_words_colors

    the_rgb = {'r' => 0, 'g' => 0, 'b' => 0}
    the_p = [1]
    the_n = [0]
    @emo.words_colors.each do |wc|
      mind = (Negapoji.judge(wc[0]) == 'positive' if @emo.text.is_a?(String)) ? 1 : 0
      (mind == 1) ? the_p.push(wc[1]) : the_n.push(wc[1])
    end
    the_rgb['r'] = ((@emo.point + 1) / 0.0078).to_i
    the_rgb['g'] = (the_p.size % 2).zero? ? the_p[the_p.size/2 - 1, 2].inject(:+) / 2 : the_p[the_p.size/2]
    the_rgb['b'] = (the_n.size % 2).zero? ? the_n[the_n.size/2 - 1, 2].inject(:+) / 2 : the_n[the_n.size/2]
    @emo.color = the_rgb

    # @emodata = Emo.find_by(text:@emo.text)
    # s = [url:emo_url(@emodata) +'.json','emo':@emodata.emo]
    # return render json: Hash[*s] if @emodata

    respond_to do |format|
      if @emo.save
        format.html { redirect_to @emo, notice: 'Emo was successfully created.' }
        format.json { render :show, status: :created, location: @emo }
      else
        format.html { render :new }
        format.json { render json: @emo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emos/1
  # PATCH/PUT /emos/1.json
  def update
    respond_to do |format|
      if @emo.update(emo_params)
        format.html { redirect_to @emo, notice: 'Emo was successfully updated.' }
        format.json { render :show, status: :ok, location: @emo }
      else
        format.html { render :edit }
        format.json { render json: @emo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emos/1
  # DELETE /emos/1.json
  def destroy
    @emo.destroy
    respond_to do |format|
      format.html { redirect_to emos_url, notice: 'Emo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emo
      @emo = Emo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def emo_params
      params.require(:emo).permit(:text, :emo, :point, :words_points, :color, :words_colors)
    end
end
