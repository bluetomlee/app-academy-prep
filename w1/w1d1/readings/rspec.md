# Testing Your Code

We're just about ready! Before you get started, though, let's
talk about how to test your code.

All of the exercises we provide come with RSpec files: Ruby scripts that
are used to test your code. You'll need to run these to make sure your
code functions exactly as expected; they're super convenient, and help
account for edge cases you may not have considered.

## How to Install RSpec

When you download each day's exercises, you'll find that they come
packaged in a particular folder structure. In your file system, it
should look something like this:

```
w1d1/
 |- lib/
 |- spec/
 |- Gemfile
 |- Gemfile.lock
```

The `lib` folder contains your actual code, and the `spec` folder holds
all the test files. The directory is structured in this way to make it easy
to run the automated test suite for the day's work.

Before we run the tests, we'll have to make sure we have the right gems
installed. Navigate into the `exercises` directory and run the following
commands; refer back to the [fundamentals][fundamentals] reading if you need
a refresher on using the command line.

[fundamentals]: ./../../../w0/readings/fundamentals.md

```sh
~$ gem install bundler
~$ bundle install
```

Here's what's happening:

1. `gem install bundler` will do what it says: install the Bundler gem.
   Bundler is useful for managing the development environment for a
   project; essentially, it "locks" you into using a particular version
   of each gem in the Gemfile. This makes it easy for someone to
   download our project and get exactly the same results when running
   it.

2. `bundle install` will download and install the gems from the Gemfile.
   After this step, we're ready to run the tests locally.

After you've gone through this setup process, you're ready to run the
specs! Let's download today's exercises and take a look at the first spec
file. It will walk you through the basics of using RSpec; you can use the
section below for reference.

## Running RSpec Tests

All these commands should be run from the `exercises` folder.

To run all the specs for a day:

```sh
~$ bundle exec rspec
```

To run just one spec file, you can pass an [optional] filename argument:

```sh
~$ bundle exec rspec spec/00_hello_spec.rb
```

To run a single test (or a set of tests), you can append the line number
to the filename argument:

```sh
~$ bundle exec rspec spec/00_hello_spec.rb:105
```
