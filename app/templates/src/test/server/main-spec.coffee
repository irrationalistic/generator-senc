request = require 'supertest'
process.env.PORT = 4444
app = require '../../dist/app/app'

describe 'Server', ()->
  describe '#API', ()->
    it 'Should respond with Hello World', (done)->
      request(app).get('/api').expect('Hello World', done)
