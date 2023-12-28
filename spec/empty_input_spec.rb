describe Rekey do
  it "works with arrays" do
    expect([].rekey(:k, :v)).to eq({})
  end

  it "works with hashes" do
    expect({}.rekey(:k, :v)).to eq({})
  end

  it "works with sets" do
    expect(Set.new.rekey(:k, :v)).to eq({})
  end
end
