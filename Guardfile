# A sample Guardfile
# More info at https://github.com/guard/guard#readme
guard :test do
  watch(%r{^(.+).rb$}) do |m|
    system ("ruby test/test_#{m[1]}.rb")
  end
end
