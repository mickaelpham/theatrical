# Theatrical

Following [Martin Fowler](https://martinfowler.com/) as we
[refactor](https://martinfowler.com/books/refactoring.html) the theatrical
company invoice system.

## Installation

```sh
git clone https://github.com/mickaelpham/theatrical
cd theatrical
bundle install
./bin/statement
```

## Development

Execute the spec suite

```sh
bundle exec rspec
```

Run the linter (and auto-correct when possible)

```sh
bundle exec rubocop --auto-correct
```

### Debugging

Add a `binding.pry` statement wherever you want to stop the code execution, then
execute the application in `development` mode, e.g.:

```sh
APP_ENV=development bin/statement
```
