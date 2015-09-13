exports.config = {
  framework: 'jasmine2',
  seleniumAddress: 'http://localhost:4444/wd/hub',
  specs: ['*.spec.js'],
  mocks: {
    default: ['mock-login'],
    dir: 'mocks'
  }
}
