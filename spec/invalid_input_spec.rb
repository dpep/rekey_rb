describe Rekey do
  let(:data) { [ 1, 2, 3 ] }

  it "raises when handlers are nil" do
    expect { data.rekey }.to raise_error(ArgumentError)
    expect { data.rekey(nil) }.to raise_error(ArgumentError)
    expect { data.rekey(nil, :v) }.to raise_error(ArgumentError)
  end

  it "raises when args and block are provided" do
    expect { data.rekey(:k) {|k| 1 } }.to raise_error(ArgumentError)
    expect { data.rekey(:k, :v) {|k| 1 } }.to raise_error(ArgumentError)
  end

  it "raises when block expects too many args" do
    # block expects key and value, but data doesn"t have keys

    expect { data.rekey {|k, v| k } }.to raise_error(ArgumentError)
  end

  it "unfortunately does not catch these corner cases" do
    expect(data.rekey(nil) {|v| v }).to eq(data.rekey(&:itself))
    expect(data.rekey(nil, nil) {|v| v }).to eq(data.rekey(&:itself))
  end
end
