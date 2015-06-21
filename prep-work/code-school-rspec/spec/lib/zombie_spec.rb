require "spec_helper"
require "zombie"

describe Zombie do

  before do
    @zombie = Zombie.new
  end

  it "is named Ash" do
    zombie.name.should == "Ash"
  end

  it "has no brains" do
    zombie.brains.should < 1
  end

  it "should not be alive" do
    zombie.alive.should be false
  end

end
