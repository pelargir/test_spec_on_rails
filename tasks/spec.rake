desc "Show specs when testing"
task :spec do
  ENV['TESTOPTS'] = '--runner=s'
  Rake::Task[:test].invoke
end

%w(functionals units integration).each do |type|
  namespace :spec do
    desc "Show specs when testing #{type}"
    task type do
      ENV['TESTOPTS'] = '--runner=s'
      Rake::Task["test:#{type}"].invoke
    end
  end
end