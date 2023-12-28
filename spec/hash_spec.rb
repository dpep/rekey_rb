describe Rekey do
  let(:data) do
    {
      a: 1,
      b: 2,
      c: 3,
    }
  end

  context "with a block handler" do
    it "rekeys with arity 1" do
      expect(data.rekey {|v| v }).to eq({
        1 => 1,
        2 => 2,
        3 => 3,
      })

      expect(data.rekey {|v| v.to_s }).to eq({
        "1" => 1,
        "2" => 2,
        "3" => 3,
      })

      # it can use Arrays as Hash keys...if you really want to
      expect(data.rekey {|v| [v] }).to eq({
        [1] => 1,
        [2] => 2,
        [3] => 3,
      })
    end

    it "rekeys with arity 2" do
      expect(data.rekey {|k, v| v }).to eq({
        1 => 1,
        2 => 2,
        3 => 3,
      })

      expect(data.rekey {|k, v| k }).to eq(data)

      expect(data.rekey {|k, v| k.to_s * 2 }).to eq({
        "aa" => 1,
        "bb" => 2,
        "cc" => 3,
      })
    end

    it "handles nil" do
      expect(data.rekey {|k, v| nil }).to eq({
        nil => 3,
      })
    end
  end

  context "with an arg handler" do
    it "rekeys" do
      expect(data.rekey(:to_s)).to eq({
        "1" => 1,
        "2" => 2,
        "3" => 3,
      })

      expect(data.rekey(:to_f)).to eq({
        1.0 => 1,
        2.0 => 2,
        3.0 => 3,
      })
    end

    it "revalues" do
      expect(data.rekey(:to_i, :to_i)).to eq({
        1 => 1,
        2 => 2,
        3 => 3,
      })

      expect(data.rekey(:to_s, :to_f)).to eq({
        "1" => 1.0,
        "2" => 2.0,
        "3" => 3.0,
      })

      expect(data.rekey("to_s", "to_f")).to eq({
        "1" => 1.0,
        "2" => 2.0,
        "3" => 3.0,
      })
    end
  end

  context "with a hash of arrays" do
    it do
      input = {
        a: [ 1, 2, 3 ],
        b: [ 4, 5, 6 ],
        c: [ 7, 8, 9 ],
      }

      expect(input.rekey(0, 1)).to eq({
        1 => 2,
        4 => 5,
        7 => 8,
      })

      expect(input.rekey(:min, :max)).to eq({
        1 => 3,
        4 => 6,
        7 => 9,
      })
    end
  end

  context "with a hash of hashes" do
    it do
      input = {
        a: { i: 1, v: 2 },
        b: { i: 2, v: 4 },
        c: { i: 3, v: 6 },
      }

      expect(input.rekey(:i)).to eq({
        1 => { i: 1, v: 2 },
        2 => { i: 2, v: 4 },
        3 => { i: 3, v: 6 },
      })

      expect(input.rekey(:i, :v)).to eq({
        1 => 2,
        2 => 4,
        3 => 6,
      })
    end
  end
end
