describe Rekey do
  it 'does not monkey patch .pluck from PluckIt' do
    expect { [].pluck }.to raise_error(NoMethodError)
    expect { {}.pluck }.to raise_error(NoMethodError)
  end
end
