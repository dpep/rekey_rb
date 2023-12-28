describe Rekey, :skip_patch do
  it "did not monkey patch Enumerable" do
    expect(Enumerable.method_defined?(:rekey)).to be false
    expect([]).not_to respond_to(:rekey)
  end

  it "did not monkey patch Array" do
    expect { [].rekey }.to raise_error(NoMethodError)
  end

  it "did not monkey patch .pluck from PluckIt" do
    expect { [].pluck }.to raise_error(NoMethodError)
  end
end
