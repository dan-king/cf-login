var should = require('should');
var login = require('../app/login');

MOCK = {
  MODULE: {
    name: 'login'
  },
  emptyInputUsername: '',
  emptyInputPassword: '',
  validInputUsername: 'foo',
  validInputPassword: 'bar',
  emptyString: '',
  emptyString: '',
  emptyArray: [],
  randomInt: 7,
  invalidPackageName: 'a.',
  notAnArray: 'This string is not an array.',
  singleEntryArray: ['a'],
  doubleEntryArray: ['a','b'],
  doubleEntryArrayWithEmptyDependency: ['a',''],
  tripleEntryArray: ['a','b','c'],
  sortPackagesEmptyInput: {
    output: 'Usage: sortPackages [package-dependency list]'
  },
  sortPackagesNonArrayInput: {
    input: 'This string is not an array',
    output: 'The package-dependency list is not an array.'
  },
  sortPackagesEmptyArrayInput: {
    input: [],
    output: 'The package-dependency list is empty.'
  },
  sortPackagesSinlgeInput: {
    input: ['a: '],
    output: 'a'
  },
  sortPackagesDoubleInput: {
    input: ['b: a', 'a: '],
    output: 'a, b'
  },
  sortPackagesCycleInput: {
    input: ['c: b', 'b: a', 'a: c'],
    output: 'Error! Encountered dependency cycle.'
  }
}

it('verify the "should" assertion library is working', function() {
  (MOCK.randomInt).should.be.exactly(MOCK.randomInt).and.be.a.Number();
  should(null).not.be.ok();
});

describe(MOCK.MODULE.name, function() {
  describe('keyup on login and password form', function() {

    describe('when login field is blank', function() {
      it ('should return true to disable login button', function(done) {
        login.checkLoginFields(MOCK.emptyInputUsername, MOCK.validInputPassword).should.be.true();
        done();
      });
    });

    describe('when password field is blank', function() {
      it ('should return true to disable login button', function(done) {
        login.checkLoginFields(MOCK.validInputUsername, MOCK.emptyInputPassword).should.be.true();
        done();
      });
    });

    describe('when login and password fields are valid', function() {
      it ('should return false to NOT disable login button', function(done) {
        login.checkLoginFields(MOCK.validInputUsername, MOCK.validInputPassword).should.be.false();
        done();
      });
    });

  });
});
