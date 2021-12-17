#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 17
# Part 2


infile = ARGV[0] || 'input.txt'
input = File.read(infile)[13..].strip.split(', ').then { |r| r.map { _1[2..].split('..').then { |a, b| (a.to_i)..(b.to_i) } } }

CoordPair = Struct.new(:x, :y)
target_area = CoordPair.new(*input)

def step(pos, vel)
  # movement
  pos.x += vel.x
  pos.y += vel.y

  # drag
  vel.x -= (vel.x <=> 0)
  # gravity
  vel.y -= 1
end

def check_collision(init_vel, target)
  pos = CoordPair.new(0, 0)
  vel = init_vel.dup
  log = [pos.dup]

  loop do
    step(pos, vel)
    log << pos.dup

    return [false, nil] if pos.y < target.y.min || pos.x > target.x.max
    return [true, log] if target.y === pos.y && target.x === pos.x
  end
end

def find_collisions(target)
  collisions = []
  (-200..300).each do |dy|
    (1..300).each do |dx|
      vel = CoordPair.new(dx, dy)
      collision, log = check_collision(vel.dup, target)
      collisions << vel.dup if collision
    end
  end
  collisions.count
end

puts find_collisions(target_area)
