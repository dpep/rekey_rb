describe Rekey do
  let(:data) { [ 1, 2, 3 ] }

  context "with a block handler" do
    it "rekeys" do
      expect(data.rekey {|v| v }).to eq({
        1 => 1,
        2 => 2,
        3 => 3,
      })

      expect(data.rekey {|v| v * 2 }).to eq({
        2 => 1,
        4 => 2,
        6 => 3,
      })

      expect(data.rekey {|v| v.to_s }).to eq({
        "1" => 1,
        "2" => 2,
        "3" => 3,
      })

      expect(data.rekey {|v| nil }).to eq({
        nil => 3,
      })

      expect(data.rekey { 123 }).to eq({
        123 => 3,
      })

      expect(data.rekey(&:itself)).to eq({
        1 => 1,
        2 => 2,
        3 => 3,
      })

      expect(data.rekey(&:to_f)).to eq({
        1.0 => 1,
        2.0 => 2,
        3.0 => 3,
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

      expect(data.rekey("to_s")).to eq({
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

    context "with an array of arrays" do
      it "works with a matrix" do
        input = [
          [ 1, 2, 3 ],
          [ 4, 5, 6 ],
          [ 7, 8, 9 ],
        ]

        expect(input.rekey(0, 2)).to eq({
          1 => 3,
          4 => 6,
          7 => 9,
        })
      end

      it "works when rows are uneven" do
        input = [
          [ 1 ],
          [ 2, 1 ],
          [ 3, 2, 1 ],
        ]

        expect(input.rekey(0, :count)).to eq({
          1 => 1,
          2 => 2,
          3 => 3,
        })
      end
    end

    context "with an array of hashes" do
      input = [
        { i: 1, v: "a" },
        { i: 2, v: "b" },
        { i: 3, v: "c" },
      ]

      it "rekeys" do
        expect(input.rekey(:i)).to eq({
          1 => input[0],
          2 => input[1],
          3 => input[2],
        })
      end

      it "revalues" do
        expect(input.rekey(:i, :v)).to eq({
          1 => "a",
          2 => "b",
          3 => "c",
        })
      end
    end
  end
end
