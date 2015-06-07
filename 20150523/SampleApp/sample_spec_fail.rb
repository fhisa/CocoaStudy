# coding: utf-8

describe Time do

  describe "==" do

    context "今と１分後と１分前について" do
      before do
        @now = Time.now
        @after_one_minute = @now + 60.0
        @before_one_minute = @now - 60.0
      end

      it "今と今は等しい" do
        expect(@now == @now).to eq true
      end

      it "今と１分後は等しくない" do
        expect(@now == @after_one_minute).to eq true
      end

      it "今と１分前は等しくない" do
        expect(@now == @before_one_minute).to eq false
      end
    end
  end
end


describe Array do

  describe "size" do

    context '空の場合' do
      before { @array = [] }

      it 'サイズは０' do
        expect(@array.size).to eq 0
      end
    end
    
    context '要素が１つの場合' do
      before { @array = ['hello'] }

      it 'サイズは１' do
        expect(@array.size).to eq 2
      end
    end
  end
end
