#!/usr/bin/env ruby

require 'pathname'
require 'ffi'
require 'json'

class Main
  LIB_PATH = Pathname.new(__dir__).join('gofunc.so').freeze
  private_constant :LIB_PATH
  extend FFI::Library
  ffi_lib LIB_PATH

  attach_function :gofunc, [:string], :string

  def initialize
    [
      { input: :example }.to_json,
      'WILL PRODUCE ERROR'
    ].each do |inp|
      result = gofunc inp

      p RUBY: JSON.parse(result)
    end
  end
end

Main.new
