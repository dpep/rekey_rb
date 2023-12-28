describe Rekey, :before_patch do
  it { expect([].respond_to?(:rekey)).to be false }

  context "when refined" do
    using Rekey

    it { expect([].respond_to?(:rekey)).to be true }
    it { expect({}.respond_to?(:rekey)).to be true }
    it { expect(Set.new.respond_to?(:rekey)).to be true }

    it "can rekey" do
      res = [ 1, 2, 3 ].rekey { |x| x.to_s }
      expect(res).to eq({
        "1" => 1,
        "2" => 2,
        "3" => 3,
      })
    end
  end
end
