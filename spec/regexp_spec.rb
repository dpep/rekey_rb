describe Rekey do
  let(:data) do
    [
      [ "a", "aa", "b", "ba", "dd" ],
      [ "b", "c", "bc", "de" ],
    ]
  end

  it do
    expect(data.rekey(0, /a/)).to eq({
      "a" => ["a", "aa", "ba"],
      "b" => [],
    })

    expect(data.rekey(/d/, /b/)).to eq({
      ["dd"] => ["b", "ba"],
      ["de"] => ["b", "bc"],
    })
  end
end
