describe Rekey do
  let(:data) do
    [
      [ 1, 2, 3 ],
      [ 4, 5, 6 ],
    ]
  end

  it "rekeys" do
    expect(data.rekey(0..1)).to eq({
      [ 1, 2 ] => [ 1, 2, 3 ],
      [ 4, 5 ] => [ 4, 5, 6 ],
    })
  end

  it "revalues" do
    expect(data.rekey(2, 0..1)).to eq({
      3 => [ 1, 2 ],
      6 => [ 4, 5 ],
    })
  end
end
