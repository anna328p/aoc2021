#!/usr/bin/env ruby

# frozen_string_literal: true

# Advent of Code 2021
# Day 16
# Part 1

infile = ARGV[0] || 'input.txt'
input = File.read(infile).chars.map { _1.to_i(16).to_s(2).rjust(4, '0') }.join.chars

Packet = Struct.new(:version, :type_id, :value, :subpackets)

TYPES = {
  sum: 0,
  product: 1,
  minimum: 2,
  maximum: 3,
  literal: 4,
  greater_than: 5,
  less_than: 6,
  equal_to: 7
}.freeze

def int(ary, len)
  ary.shift(len).join.to_i(2)
end

def lit(ary)
  bits = []

  loop do
    new_bits = ary.shift(5)
    bits << new_bits[1..]
    break if new_bits[0] == '0'
  end

  bits.join.to_i(2)
end

def parse_packet(bits)
  packet = Packet.new

  packet.version = int(bits, 3)
  packet.type_id = int(bits, 3)

  case packet.type_id
  when TYPES[:literal]
    packet.value = lit(bits)
    packet.subpackets = nil
  else # operator
    packet.value = nil

    length_type = int(bits, 1)
    case length_type
    when 0
      len_bits = int(bits, 15)

      sub_bits = bits.shift(len_bits)
      packet.subpackets = []

      until sub_bits.length < 11
        packet.subpackets << parse_packet(sub_bits)
      end
    when 1
      len_packets = int(bits, 11)

      packet.subpackets = len_packets.times.map { parse_packet(bits) }
    end
  end

  packet
end

def add_up_versions(packet)
  if packet.subpackets
    packet.version + packet.subpackets.map { add_up_versions(_1) }.compact.sum
  else
    packet.version
  end
end

pp add_up_versions(parse_packet(input))
